//
//  TKONoteEditorView.m
//  Trakio
//
//  Created by yang wei on 05/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKONoteEditorView.h"
#import "TKOCheckInView.h"

@implementation TKONoteEditorView {
    NSURLSession * session_;
}

@synthesize note;

-(id)initWithLocation:(TKOLocation *)loc {
    if (self = [super init]) {
        self.location = loc;
        extern TKOEmployee * myself;
        self.employee = myself;
        
        UIColor * backgroundColor = [TKOSystem homeViewBackgroundColor];
        [self setBackgroundColor:backgroundColor];
        
        UIColor * topColor = [TKOSystem topBarBackgroundColor];
        
        self.topMargin = [[UIView alloc] init];
        self.topMargin.backgroundColor = topColor;
        [self addSubview:self.topMargin];
        
        self.topBar = [[TKOTopBar alloc] init];
        self.topBar.backgroundColor = topColor;
        [self addSubview:self.topBar];
        
        //textfield
        self.noteText = [[UITextView alloc] init];
        self.noteText.font = [UIFont fontWithName:@"OpenSans-Regular" size:12];
        self.noteText.backgroundColor = [UIColor whiteColor];
        [self.noteText setDelegate:self];
//        self.noteText.returnKeyType = UIReturnKeyDone;
        
        [self addSubview:self.noteText];
        
        self.backButton = [[UIButton alloc] init];
        [self.backButton setTitle:@"BACK" forState:UIControlStateNormal];
        [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.backButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.backButton.titleLabel.font = [UIFont fontWithName:@"Montserrat" size:20];
        self.backButton.backgroundColor = [UIColor orangeColor];
        [self.backButton addTarget:self action:@selector(backToCheckinView:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.backButton];
        
        self.saveButton = [[UIButton alloc] init];
        [self.saveButton setTitle:@"SAVE" forState:UIControlStateNormal];
        [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.saveButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.saveButton.titleLabel.font = [UIFont fontWithName:@"Montserrat" size:20];
        self.saveButton.backgroundColor = [TKOSystem trakioGreenColor];
        [self.saveButton addTarget:self action:@selector(saveNote:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.saveButton];
    }
    
    return self;
}

-(void)backToCheckinView:(UIButton *)button {
    
    TKOCheckInView * civ = [[TKOCheckInView alloc] initWithLocation:self.location];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[civ layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self.window.rootViewController.view addSubview:civ];
}

-(void)saveNote:(UIButton *)button {
    
    NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setAllowsCellularAccess:YES];
    
    session_ = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSString * ServerURL = [TKOSystem getAPIUrl];
    NSString * saveNoteUrlStr = [ServerURL stringByAppendingString:@"checkin-notes?token=%@"];
    NSString * saveNoteUrlString = [NSString stringWithFormat:saveNoteUrlStr, self.employee.employeeToken];
    NSURL * saveNoteUrl = [NSURL URLWithString:saveNoteUrlString];
    NSLog(@"note list url:%@", saveNoteUrlString);
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:saveNoteUrl];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSError * error;
    NSMutableDictionary * newNoteDict = [[NSMutableDictionary alloc] initWithCapacity:1];
    [newNoteDict setObject:self.employee.checkInID forKey:@"check_in_id"];
    [newNoteDict setObject:self.noteText.text forKey:@"note"];
    NSData * noteListData = [NSJSONSerialization dataWithJSONObject:newNoteDict options:kNilOptions error: &error];
    
    NSURLSessionUploadTask * postTask = [session_ uploadTaskWithRequest:request fromData:noteListData
                            completionHandler:^(NSData * _Nullable data,
                                                NSURLResponse * _Nullable response,
                                                NSError * _Nullable error) {
        if (error == nil) {
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
            NSLog(@"%d", httpResponse.statusCode);
            NSString * responseJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"response data : %@",responseJson);
            if (httpResponse.statusCode == 200) {
                [self performSelectorOnMainThread:@selector(backToNoteView:) withObject:self.location waitUntilDone:NO];
            }else {
                NSLog(@"error");
            }
        }
    }];
    [postTask resume];
}

-(void)backToNoteView:(TKOLocation *)location {
    
    TKOCheckInView * civ = [[TKOCheckInView alloc] initWithLocation:location];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[civ layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self.window.rootViewController.view addSubview:civ];
}

-(void)layoutSubviews {
    //make layout's frame equal to superview's frame
    self.frame = self.superview.frame;
    
    //remove all constraints from the layout
    [self removeConstraints:[self constraints]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.topMargin.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topMargin
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topMargin
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topMargin
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topMargin
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:20]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.topBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topBar
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.topMargin
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topBar
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topBar
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topBar
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:40]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.noteText.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noteText
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.topBar
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:25]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noteText
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noteText
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:-20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noteText
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:[TKOSystem tableHeight]]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.backButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.backButton
                         attribute:NSLayoutAttributeBottom
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.backButton
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.backButton
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.5
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.backButton
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:70]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.saveButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.saveButton
                         attribute:NSLayoutAttributeBottom
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.saveButton
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.saveButton
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.5
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.saveButton
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:70]];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.noteText resignFirstResponder];
}

@end
