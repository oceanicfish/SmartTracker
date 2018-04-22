//
//  TKONoteView.m
//  Trakio
//
//  Created by yang wei on 05/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKONoteView.h"
#import "TKOCheckInView.h"
#import "TKONoteEditorView.h"

@implementation TKONoteView {
    NSURLSession * session_;
}

@synthesize notes;

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
        
        self.todoBlock = [[TKOJobBlock alloc] initWithTitle:@"Notes" Icon:FaFile ActionView:nil];
        [self addSubview:self.todoBlock];
        
        NSMutableDictionary * noteList = [[NSMutableDictionary alloc] init];
        
        NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        [sessionConfiguration setAllowsCellularAccess:YES];
        
        session_ = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        
        NSString * ServerURL = [TKOSystem getAPIUrl];
        NSString * noteListUrlStr = [ServerURL stringByAppendingString:@"checkin-notes/by-checkin?token=%@"];
        NSString * noteListUrlString = [NSString stringWithFormat:noteListUrlStr, self.employee.employeeToken];
        NSURL * noteListUrl = [NSURL URLWithString:noteListUrlString];
        NSLog(@"note list url:%@", noteListUrlString);
        
        NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:noteListUrl];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        NSError * error;
        NSMutableDictionary * noteListDict = [[NSMutableDictionary alloc] initWithCapacity:1];
        [noteListDict setObject:self.employee.checkInID forKey:@"check_in_id"];
        NSData * noteListData = [NSJSONSerialization dataWithJSONObject:noteListDict options:kNilOptions error: &error];

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
                    NSMutableDictionary * noteList = [[NSMutableDictionary alloc] init];
                    NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                                              options:kNilOptions error:&error];
                    NSArray * notesArray = [jsonDict objectForKey:@"data"];
                    
                    for (int i = 0; i < notesArray.count; i++) {
                        NSDictionary * myNote = notesArray[i];
                        NSString * content = [[myNote objectForKey:@"attributes"] objectForKey:@"note"];
                        NSString * title = [NSString stringWithFormat:@"Note %d", i];
                        TKONote * note = [[TKONote alloc] initWithTitle:title Content:content];
                        [noteList setObject:note forKey:[NSString stringWithFormat:@"%d", i]];
                    }
                    
                    [self performSelectorOnMainThread:@selector(showNoteList:) withObject:noteList waitUntilDone:NO];
                }else {
//                    [self performSelectorOnMainThread:@selector(showAlertView:) withObject:@"Bad internet connection, please try again later." waitUntilDone:NO];
                }
            }
        }];
        [postTask resume];
        
        self.noteList = [[TKONoteListView alloc] initWithNoteList:noteList];
        self.noteList.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.noteList.layoutMargins = UIEdgeInsetsZero;
        [self.noteList setBackgroundColor:[TKOSystem homeViewBackgroundColor]];
        [self addSubview:self.noteList];
        
        self.backButton = [[UIButton alloc] init];
        [self.backButton setTitle:@"BACK" forState:UIControlStateNormal];
        [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.backButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.backButton.titleLabel.font = [UIFont fontWithName:@"Montserrat" size:20];
        self.backButton.backgroundColor = [UIColor orangeColor];
        [self.backButton addTarget:self action:@selector(backToCheckInView:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.backButton];
        
        self.addButton = [[UIButton alloc] init];
        [self.addButton setTitle:@"ADD" forState:UIControlStateNormal];
        [self.addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.addButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.addButton.titleLabel.font = [UIFont fontWithName:@"Montserrat" size:20];
        self.addButton.backgroundColor = [TKOSystem trakioGreenColor];
        [self.addButton addTarget:self action:@selector(addNote:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.addButton];
    }
    
    return self;
}

-(void)showNoteList:(NSDictionary *)noteList {
    
    self.noteList = [[TKONoteListView alloc] initWithNoteList:noteList];
    self.noteList.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.noteList.layoutMargins = UIEdgeInsetsZero;
    [self.noteList setBackgroundColor:[TKOSystem homeViewBackgroundColor]];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFade];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[self.noteList layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self insertSubview:self.noteList belowSubview:self.todoBlock];
    
//    TKOCheckInView * checkInView = (TKOCheckInView *) topView;
//    checkInView.noteBlock.blockTitle.backgroundColor = [UIColor whiteColor];
}

-(void)backToCheckInView:(UIButton *)button {
    
    TKOCheckInView * civ = [[TKOCheckInView alloc] initWithLocation:self.location];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[civ layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self.window.rootViewController.view addSubview:civ];
    
}

-(void)addNote:(UIButton *)button {
    
    TKONoteEditorView * nev = [[TKONoteEditorView alloc] initWithLocation:self.location];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[nev layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self.window.rootViewController.view addSubview:nev];
}

-(void)layoutSubviews {
    
    extern NSMutableDictionary * dimension;
    
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
    self.todoBlock.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoBlock
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.topBar
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:25]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoBlock
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoBlock
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:-20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoBlock
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:[TKOSystem jobBlockHeight]]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.noteList.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noteList
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.todoBlock
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:1]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noteList
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self.todoBlock
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noteList
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self.todoBlock
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noteList
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:[[dimension objectForKey:@"NOTE_LIST_HEIGHT"] intValue]]];
    
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
    self.addButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.addButton
                         attribute:NSLayoutAttributeBottom
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.addButton
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.addButton
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.5
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.addButton
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:70]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
