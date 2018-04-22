//
//  TKOCheckInView.m
//  Trakio
//
//  Created by yang wei on 04/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOCheckInView.h"
#import "TKOLocationView.h"
#import "TKONoteEditorView.h"
#import "TKOTodoEditorView.h"
#import "TKONoteView.h"
#import "TKOTopBar.h"
#import "TKOJobBlock.h"

@implementation TKOCheckInView {
    NSURLSession * session_;
}

-(id)initWithLocation:(TKOLocation *)tl {
    if (self = [super init]) {
        self.location = tl;
        
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
        
        TKOTodoEditorView * tdev = [[TKOTodoEditorView alloc] initWithLocation:self.location];
        
        TKONoteView * nv = [[TKONoteView alloc] initWithLocation:self.location];
        
        self.todoBlock = [[TKOJobBlock alloc] initWithTitle:@"To-Dos" Icon:FaCheck ActionView: tdev];
        [self addSubview:self.todoBlock];
        
        self.noteBlock = [[TKOJobBlock alloc] initWithTitle:@"Notes" Icon:FaFile ActionView:nv];
        [self addSubview:self.noteBlock];
        
        self.photoBlock = [[TKOJobBlock alloc] initWithTitle:@"Snap Photos" Icon:FaCamera ActionView:nil];
        [self addSubview:self.photoBlock];
        
        self.checkInStatusLabel = [[UILabel alloc] init];
        self.checkInStatusLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:10];
        self.checkInStatusLabel.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
        self.checkInStatusLabel.backgroundColor = [TKOSystem homeViewBackgroundColor];
        if (self.location.name == nil) {
            self.location.name = @"";
        }
        self.checkInStatusLabel.text = [NSString stringWithFormat:@"You are currently checked in %@", self.location.name];
        [self.checkInStatusLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.checkInStatusLabel];

        self.takeBreakButton = [[UIButton alloc] init];
//        [self.takeBreakButton setTitle:@"TAKE BREAK" forState:UIControlStateNormal];
//        [self.takeBreakButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.takeBreakButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
//        self.takeBreakButton.titleLabel.font = [UIFont fontWithName:@"Montserrat" size:18];
//        self.takeBreakButton.backgroundColor = [UIColor orangeColor];
        [self changeBreakStatus];
        [self.takeBreakButton addTarget:self action:@selector(takeBreak:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.takeBreakButton];
        
        self.checkOutButton = [[UIButton alloc] init];
        [self.checkOutButton setTitle:@"CHECK OUT" forState:UIControlStateNormal];
        [self.checkOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.checkOutButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.checkOutButton.titleLabel.font = [UIFont fontWithName:@"Montserrat" size:18];
        self.checkOutButton.backgroundColor = [TKOSystem trakioGreenColor];
        [self.checkOutButton addTarget:self action:@selector(checkOut:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.checkOutButton];
    }
    
    return self;
}

-(void)takeBreak:(UIButton *)button {
    
    extern TKOEmployee * myself;
    self.employee = myself;
    
    NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setAllowsCellularAccess:YES];
    
    session_ = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSString * breakUrlString;
    NSString * ServerURL = [TKOSystem getAPIUrl];
    if (self.employee.breakStatus) {
        NSString * endBreakUrlStr = [ServerURL stringByAppendingString:@"check-ins/end-break?token=%@&check_in_id=%@"];
        breakUrlString = [NSString stringWithFormat:endBreakUrlStr, self.employee.employeeToken, self.employee.checkInID];
    }else {
        NSString * startBreakUrlStr = [ServerURL stringByAppendingString:@"check-ins/start-break?token=%@&check_in_id=%@"];
        breakUrlString = [NSString stringWithFormat:startBreakUrlStr, self.employee.employeeToken, self.employee.checkInID];
    }
//    NSString * breakUrlString = [NSString stringWithFormat:@"http://v2api-staging.trakio.com/api/check-in/start-break?token=%@&id=%@", self.employee.employeeToken, self.employee.checkInID];
    NSURL * breakUrl = [NSURL URLWithString:breakUrlString];
    NSLog(breakUrlString);
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:breakUrl];
    request.HTTPMethod = @"POST";
    [request setValue:@"*" forHTTPHeaderField:@"Access-Control-Allow-Origin"];
    
    NSURLSessionDataTask * dataTask = [session_ dataTaskWithRequest:request
                        completionHandler:^(NSData * _Nullable data,
                                            NSURLResponse * _Nullable response,
                                            NSError * _Nullable error) {
        if (error == nil) {
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
            NSLog(@"%d", httpResponse.statusCode);
                                                          
            if (httpResponse.statusCode == 200) {
                
                NSString * responseJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"response data : %@",responseJson);
                
                NSDictionary * jsonDcit = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions error:&error];
                NSString * status = [jsonDcit objectForKey:@"status"];
                
                if ([status isEqualToString:@"success"]) {
                    self.employee.breakStatus = !self.employee.breakStatus;
                    [self performSelectorOnMainThread:@selector(changeBreakStatus) withObject:nil waitUntilDone:NO];
                    TKOPerference * usrPerference = [TKOPerference getPerference];
                    [usrPerference.tkoSettings setValue:[NSString stringWithFormat:@"%d", self.employee.breakStatus] forKey:@"TRAKIO_BREAK_STATUS"];
                    [usrPerference savePerference];
                }
            
                
            }else {
                    
                [self performSelectorOnMainThread:@selector(showAlertView:) withObject:@"Bad internet connection, please try again later." waitUntilDone:NO];
            }
        }
    }];
    [dataTask resume];
    
}

-(void)changeBreakStatus {
    
    if (self.employee.breakStatus) {
        self.takeBreakButton.backgroundColor = [UIColor redColor];
        [self.takeBreakButton setTitle:@"BACK TO WORK" forState:UIControlStateNormal];
        self.checkOutButton.userInteractionEnabled = NO;
        self.checkOutButton.backgroundColor = [UIColor colorWithRed:58.0/255.0 green:138.0/255.0 blue:63.0/255.0 alpha:1];
        [self.checkOutButton setTitleColor:[UIColor colorWithRed:29.0/255.0 green:75.0/255.0 blue:32.0/255.0 alpha:1] forState:UIControlStateNormal];
    } else {
        self.takeBreakButton.backgroundColor = [UIColor orangeColor];
        [self.takeBreakButton setTitle:@"TAKE BREAK" forState:UIControlStateNormal];
        self.checkOutButton.userInteractionEnabled = YES;
        self.checkOutButton.backgroundColor = [TKOSystem trakioGreenColor];
        [self.checkOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

-(void)checkOut:(UIButton *)button {
    
    self.checkOutButton.userInteractionEnabled = NO;
    self.checkOutButton.backgroundColor = [UIColor colorWithRed:58.0/255.0 green:138.0/255.0 blue:63.0/255.0 alpha:1];
    [self.checkOutButton setTitleColor:[UIColor colorWithRed:29.0/255.0 green:75.0/255.0 blue:32.0/255.0 alpha:1] forState:UIControlStateNormal];
    self.takeBreakButton.userInteractionEnabled = NO;
    self.takeBreakButton.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:112.0/255.0 blue:0.0/255.0 alpha:1];
    [self.takeBreakButton setTitleColor:[UIColor colorWithRed:147.0/255.0 green:74.0/255.0 blue:1.0/255.0 alpha:1] forState:UIControlStateNormal];
    
    NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setAllowsCellularAccess:YES];
    
    extern TKOEmployee * myself;

    session_ = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSString * ServerURL = [TKOSystem getAPIUrl];
    NSString * checkOutUrlStr = [ServerURL stringByAppendingString:@"check-ins/checkout?token=%@&location_id=%@"];
    NSString * checkOutUrlString = [NSString stringWithFormat:checkOutUrlStr, self.employee.employeeToken, self.location.locationID];
    NSURL * checkOutUrl = [NSURL URLWithString:checkOutUrlString];
    NSLog(checkOutUrlString);
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:checkOutUrl];
    request.HTTPMethod = @"POST";
    [request setValue:@"*" forHTTPHeaderField:@"Access-Control-Allow-Origin"];
    
    NSURLSessionDataTask * dataTask = [session_ dataTaskWithRequest:request
                            completionHandler:^(NSData * _Nullable data,
                                                NSURLResponse * _Nullable response,
                                                NSError * _Nullable error) {
        if (error == nil) {
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
            NSLog(@"%d", httpResponse.statusCode);
                                                          
            if (httpResponse.statusCode == 200) {
                
                TKOPerference * usrPerference = [TKOPerference getPerference];
                [usrPerference.tkoSettings setValue:@"" forKey:@"TRAKIO_CHECKED_ID"];
                [usrPerference.tkoSettings setValue:@"" forKey:@"TRAKIO_CHECKED_LOCATION_ID"];
                [usrPerference.tkoSettings setValue:@"" forKey:@"TRAKIO_CHECKED_LOCATION_NAME"];
                [usrPerference.tkoSettings setValue:@"" forKey:@"TRAKIO_CHECKED_LOCATION_SHIFT_ID"];
                [usrPerference.tkoSettings setValue:@"" forKey:@"TRAKIO_CHECKED_LOCATION_LATITUDE"];
                [usrPerference.tkoSettings setValue:@"" forKey:@"TRAKIO_CHECKED_LOCATION_LONGITUDE"];
                myself.checkInID = @"";
                [usrPerference savePerference];
                NSLog(@"User Checked Out, Trakio user check-in data is cleared");
                [self performSelectorOnMainThread:@selector(backToLocationView:) withObject:self.employee waitUntilDone:NO];
                
            }else if (httpResponse.statusCode == 401) {
                [self performSelectorOnMainThread:@selector(showAlertView:) withObject:@"Checking Out multiple location is not allowed." waitUntilDone:NO];
                self.checkOutButton.userInteractionEnabled = YES;
                self.checkOutButton.backgroundColor = [TKOSystem trakioGreenColor];
                [self.checkOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.takeBreakButton.userInteractionEnabled = YES;
                self.takeBreakButton.backgroundColor = [UIColor orangeColor];
                [self.takeBreakButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else {
                [self performSelectorOnMainThread:@selector(showAlertView:) withObject:@"Bad internet connection, please try again later." waitUntilDone:NO];
                self.checkOutButton.userInteractionEnabled = YES;
                self.checkOutButton.backgroundColor = [TKOSystem trakioGreenColor];
                [self.checkOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.takeBreakButton.userInteractionEnabled = YES;
                self.takeBreakButton.backgroundColor = [UIColor orangeColor];
                [self.takeBreakButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

            }
                                                          
            NSString * responseJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"response data : %@",responseJson);
                                                          
        }
    }];
    [dataTask resume];
    
}

-(void)showAlertView:(NSString *)message {
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Trakio" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alertView show];
    
}

-(void)backToLocationView:(TKOEmployee *)emp {
    
    TKOLocationView * lv = [[TKOLocationView alloc] initWithEmployee:emp];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[lv layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self.window.rootViewController.view addSubview:lv];
}

-(void)layoutSubviews {
    
    //make layout's frame equal to superview's frame
    self.frame = self.superview.frame;
    
    //remove all constraints from the layout
    [self removeConstraints:[self constraints]];
    
    //    [TKLog LogWithType:1 Source:@"TKCheckinView.layoutSubViews" Message:@"remove all constrants"];
    
    
    
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
    self.noteBlock.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noteBlock
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.todoBlock
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:25]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noteBlock
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noteBlock
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:-20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noteBlock
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:[TKOSystem jobBlockHeight]]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.photoBlock.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.photoBlock
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.noteBlock
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:25]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.photoBlock
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.photoBlock
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:-20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.photoBlock
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:[TKOSystem jobBlockHeight]]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.checkInStatusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkInStatusLabel
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.photoBlock
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:25]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkInStatusLabel
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkInStatusLabel
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:-20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkInStatusLabel
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:20]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.takeBreakButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.takeBreakButton
                         attribute:NSLayoutAttributeBottom
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.takeBreakButton
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.takeBreakButton
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.5
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.takeBreakButton
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:70]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.checkOutButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkOutButton
                         attribute:NSLayoutAttributeBottom
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkOutButton
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkOutButton
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.5
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkOutButton
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
