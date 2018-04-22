//
//  TKOHomeView.m
//  Trakio
//
//  Created by yang wei on 02/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOHomeView.h"

@implementation TKOHomeView
{
    NSMutableDictionary * history_;
    NSURLSession * session_;
}

@synthesize welcomeView;
@synthesize topBar;
@synthesize employee;

-(id)initWithEmployee:(TKOEmployee *)e {
    if (self = [super init]) {
        
        NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        [sessionConfiguration setAllowsCellularAccess:YES];
        
        session_ = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        
        self.employee = e;
        UIColor * backgroundColor = [TKOSystem homeViewBackgroundColor];
        [self setBackgroundColor:backgroundColor];
        
        //search employee info from db
        
        UIColor * topColor = [TKOSystem topBarBackgroundColor];
        
        self.topMargin = [[UIView alloc] init];
        self.topMargin.backgroundColor = topColor;
        [self addSubview:self.topMargin];
        
        self.topBar = [[TKOTopBar alloc] init];
        self.topBar.backgroundColor = topColor;
        [self addSubview:self.topBar];
        
        self.welcomeView = [[TKOWelcomeView alloc] initWithEmployee:self.employee];
        
        [self addSubview:self.welcomeView];
        
        UIColor * dateColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1.0];
        
        self.todayView = [[TKOTodayView alloc] init];
        self.todayView.backgroundColor = dateColor;
        [self addSubview:self.todayView];
        
        self.historyTitleView = [[TKOHistoryTitleView alloc] init];

        [self addSubview:self.historyTitleView];
        
        [self loadHistoryData];
        
        history_ = [[NSMutableDictionary alloc] init];
        
//        [history_ setObject:@"MON" forKey:@"JAN 25 2016"];
//        [history_ setObject:@"TUE" forKey:@"JAN 26 2016"];
//        [history_ setObject:@"WED" forKey:@"JAN 27 2016"];
//        [history_ setObject:@"THU" forKey:@"JAN 28 2016"];
//        [history_ setObject:@"FRI" forKey:@"JAN 39 2016"];
        
        self.historyTableView = [[TKOHistoryTableView alloc] initWithHistory:history_];
        self.historyTableView.tableHeaderView = nil;
        self.historyTableView.tableFooterView = nil;
        self.historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.historyTableView];
        
        self.startMyDay = [[UIButton alloc] init];
        
        if (!self.employee.started) {
            [self.startMyDay setTitle:@"开始工作" forState:UIControlStateNormal];
            self.startMyDay.backgroundColor = [TKOSystem trakioGreenColor];
        } else {
            [self.startMyDay setTitle:@"结束工作" forState:UIControlStateNormal];
            self.startMyDay.backgroundColor = [UIColor orangeColor];
        }

        [self.startMyDay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.startMyDay.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.startMyDay.titleLabel.font = [UIFont fontWithName:@"Montserrat" size:24];
        [self.startMyDay addTarget:self action:@selector(startMyDay:) forControlEvents:UIControlEventTouchUpInside];
        self.startMyDay.userInteractionEnabled = YES;
        
        [self addSubview:self.startMyDay];
        
    }
    
    return  self;
}

-(void)loadHistoryData {
    
    NSString * ServerURL = [TKOSystem getAPIUrl];
    NSString * historyUrlStr = [ServerURL stringByAppendingString:@"users/recent-history?token=%@"];
    NSString * historyUrlString = [NSString stringWithFormat:historyUrlStr, self.employee.employeeToken];
    NSURL * historyUrl = [NSURL URLWithString:historyUrlString];
    NSLog(historyUrlString);
    NSURLSessionDataTask * dataTask = [session_ dataTaskWithURL:historyUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
            NSLog(@"%ld", httpResponse.statusCode);
            
            NSString * responseJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(responseJson);
            
            NSDictionary * jsonDcit = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:kNilOptions error:&error];
            NSArray * historyList = [jsonDcit objectForKey:@"data"];
            NSMutableDictionary * myHistoryList = [[NSMutableDictionary alloc] init];
            
//            history_ = [[NSMutableDictionary alloc] init];
            
            for (int i = 0; i < historyList.count; i++) {
                NSDictionary * myHistory = historyList[i];
                NSDictionary * historyEntry = [myHistory objectForKey:@"attributes"];
//                NSNumber * startTimeStamp = [historyEntry objectForKey:@"timeInUnix"];
//                NSNumber * endTimeStamp = [historyEntry objectForKey:@"timeOutUnix"];
//                
//                double durationMillsecond = [endTimeStamp doubleValue] - [startTimeStamp doubleValue];
//                NSLog(@"duration:%f", durationMillsecond);
//                
//                NSCalendar * calender = [NSCalendar currentCalendar];
//                NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
//                [dateFormat setDateFormat:@"YYYY年MM月dd号"];
//                NSDateFormatter * timeFormat = [[NSDateFormatter alloc] init];
//                [timeFormat setDateFormat:@"HH:mm"];
//                
//                NSDate * startDateTime = [NSDate dateWithTimeIntervalSince1970:[startTimeStamp doubleValue]];
//                NSDateComponents * startWeekdayComp = [calender components:NSWeekdayCalendarUnit fromDate:startDateTime];
//                NSString * startWeekdayStr = [TKOSystem getWeekday:[startWeekdayComp weekday]];
//                NSLog(@"weekday:%@", startWeekdayStr);
//                NSString * startDateStr = [dateFormat stringFromDate:startDateTime];
//                NSLog(@"start date : %@", startDateStr);
//                NSString * startTimeStr = [timeFormat stringFromDate:startDateTime];
//                NSLog(@"start time : %@", startTimeStr);
//                
//                NSDate * endDateTime = [NSDate dateWithTimeIntervalSince1970:[endTimeStamp doubleValue]];
//                NSDateComponents * endWeekdayComp = [calender components:NSWeekdayCalendarUnit fromDate:endDateTime];
//                NSString * endWeekdayStr = [TKOSystem getWeekday:[endWeekdayComp weekday]];
//                NSLog(@"weekday:%@", endWeekdayStr);
//                NSString * endDateStr = [dateFormat stringFromDate:endDateTime];
//                NSLog(@"end date : %@", endDateStr);
//                NSString * endTimeStr = [timeFormat stringFromDate:endDateTime];
//                NSLog(@"end time : %@", endTimeStr);
                
                [history_ setObject:historyEntry forKey:[NSString stringWithFormat:@"%d", i]];
                
            }
            
            [self performSelectorOnMainThread:@selector(showHistoryList:) withObject:history_ waitUntilDone:NO];

        }
    }];
    [dataTask resume];
 
}

-(void)showHistoryList:(NSDictionary *)history{
    
    self.historyTableView = [[TKOHistoryTableView alloc] initWithHistory:history];
    self.historyTableView.tableHeaderView = nil;
    self.historyTableView.tableFooterView = nil;
    self.historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
//    [animation setType:kCATransitionPush];
//    [animation setSubtype:kCATransitionFromBottom];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[self.historyTableView layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self addSubview:self.historyTableView];
    
//    [self insertSubview:self.historyTableView belowSubview:self.mapView];
//    
//    self.mapView.mylocations = locations;
//    [self.mapView tkShowAnnotations];
    
}

-(void)startMyDay:(TKOEmployee *)employee {
    
    NSString * startMyDayUrlString;
    NSString * ServerURL = [TKOSystem getAPIUrl];
    if (!self.employee.started) {
        
        NSString * startMyDayUrlStr = [ServerURL stringByAppendingString:@"users/start-the-day?token=%@&user_id=%@"];
        
        startMyDayUrlString = [NSString stringWithFormat:startMyDayUrlStr, self.employee.employeeToken, self.employee.employeeID];
        
        [self.startMyDay setTitle:@"连接服务器..." forState:UIControlStateNormal];
        self.startMyDay.userInteractionEnabled = NO;
        self.startMyDay.backgroundColor = [UIColor colorWithRed:58.0/255.0 green:138.0/255.0 blue:63.0/255.0 alpha:1];
        [self.startMyDay setTitleColor:[UIColor colorWithRed:29.0/255.0 green:75.0/255.0 blue:32.0/255.0 alpha:1] forState:UIControlStateNormal];
    }else {
        
        NSString * startMyDayUrlStr = [ServerURL stringByAppendingString:@"users/end-the-day?token=%@&user_id=%@"];
        
        startMyDayUrlString = [NSString stringWithFormat:startMyDayUrlStr, self.employee.employeeToken, self.employee.employeeID];
        
        [self.startMyDay setTitle:@"连接服务器..." forState:UIControlStateNormal];
        self.startMyDay.userInteractionEnabled = NO;
        self.startMyDay.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:112.0/255.0 blue:0.0/255.0 alpha:1];
        [self.startMyDay setTitleColor:[UIColor colorWithRed:147.0/255.0 green:74.0/255.0 blue:1.0/255.0 alpha:1] forState:UIControlStateNormal];
    }
    
    NSLog(@"start my day url : %@", startMyDayUrlString);
    NSURL * startMyDayUrl = [NSURL URLWithString:startMyDayUrlString];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:startMyDayUrl];
    request.HTTPMethod = @"POST";
    [request setValue:@"*" forHTTPHeaderField:@"Access-Control-Allow-Origin"];
    
    NSURLSessionDataTask * dataTask = [session_ dataTaskWithRequest:request
            completionHandler:^(NSData * _Nullable data,
                                NSURLResponse * _Nullable response,
                                NSError * _Nullable error) {
        if (error == nil) {
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
            NSLog(@"%ld", httpResponse.statusCode);
            
            if (httpResponse.statusCode == 401) {
                /**
                 * if token is expired
                 */
                [self performSelectorOnMainThread:@selector(showTokenExpired) withObject:nil waitUntilDone:NO];
            }else if(httpResponse.statusCode == 403) {
                self.employee.started = true;
                [self performSelectorOnMainThread:@selector(changeButtonStatus:) withObject:self.employee waitUntilDone:NO];
            }else {
                /**
                 * if token is not expired
                 */
                NSString * responseJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"response data : %@",responseJson);
                
                NSDictionary* jsonDcit = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:kNilOptions error:&error];
                NSString * startAt = [[[jsonDcit objectForKey:@"data"] objectForKey:@"attributes"] objectForKey:@"startedAt"];
                
                TKOPerference * usrPerference = [TKOPerference getPerference];
                if (startAt != [NSNull null] && startAt.length > 0) {
                    self.employee.started = true;
                    [usrPerference.tkoSettings setValue:startAt forKey:@"TRAKIO_USER_STARTED"];
                    [self performSelectorOnMainThread:@selector(goLocationView:) withObject:self.employee waitUntilDone:NO];
                }else {
                    self.employee.started = false;
                    [usrPerference.tkoSettings setValue:@"" forKey:@"TRAKIO_USER_STARTED"];
                    [self performSelectorOnMainThread:@selector(changeButtonStatus:) withObject:self.employee waitUntilDone:NO];
                }
                [usrPerference savePerference];

            }
            
                    }
    }];
    [dataTask resume];
    
}

-(void)showTokenExpired {
    
    NSString * msg = @"Your Token is expired, click 'Log in' and re-enter please";
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Trakio"
                                                     message:msg
                                                    delegate:self
                                           cancelButtonTitle:@"Log in"
                                           otherButtonTitles:nil, nil];
    [alert show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self performSelectorOnMainThread:@selector(goBackLoginView:) withObject:self.employee waitUntilDone:NO];
    
}

-(void)goBackLoginView:(TKOEmployee *)emp {
    
    TKOLoginView * lv = [[TKOLoginView alloc] init];
    lv.frame = self.window.rootViewController.view.frame;
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[lv layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self.window.rootViewController.view addSubview:lv];

}

-(void)changeButtonStatus:(TKOEmployee *)emp {
    
    if (!self.employee.started) {
        [self.startMyDay setTitle:@"开始工作" forState:UIControlStateNormal];
        self.startMyDay.backgroundColor = [TKOSystem trakioGreenColor];
        [self.startMyDay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [self.startMyDay setTitle:@"结束工作" forState:UIControlStateNormal];
        self.startMyDay.backgroundColor = [UIColor orangeColor];
        [self.startMyDay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    self.startMyDay.userInteractionEnabled = YES;
}

-(void)goLocationView:(TKOEmployee *)emp{
    
    TKOLocationView * lv = [[TKOLocationView alloc] initWithEmployee:emp];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[lv layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self.window.rootViewController.view addSubview:lv];
}

-(void)trackLocation {
    NSLog(@"%@",@"start tracking...");
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
    self.welcomeView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.welcomeView
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.topBar
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.welcomeView
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.welcomeView
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.welcomeView
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:[[dimension objectForKey:@"WELCOME_VIEW_HEIGHT"] intValue]]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.todayView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todayView
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.welcomeView
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todayView
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todayView
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todayView
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:[[dimension objectForKey:@"TODAY_VIEW_HEIGHT"] intValue]]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.historyTitleView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.historyTitleView
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.todayView
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.historyTitleView
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.historyTitleView
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.historyTitleView
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:20]];
    
    
    if (history_ != nil && history_.count > 0) {
        
        // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
        self.historyTableView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.historyTableView
                             attribute:NSLayoutAttributeTop
                             relatedBy:0
                             toItem:self.historyTitleView
                             attribute:NSLayoutAttributeBottom
                             multiplier:1
                             constant:0]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.historyTableView
                             attribute:NSLayoutAttributeLeft
                             relatedBy:0
                             toItem:self
                             attribute:NSLayoutAttributeLeft
                             multiplier:1
                             constant:0]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.historyTableView
                             attribute:NSLayoutAttributeWidth
                             relatedBy:0
                             toItem:self
                             attribute:NSLayoutAttributeWidth
                             multiplier:1
                             constant:0]];
        
        //    int hlh = [[dimension objectForKey:@"HISTORY_LIST_HEIGHT"] intValue];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.historyTableView
                             attribute:NSLayoutAttributeHeight
                             relatedBy:0
                             toItem:self
                             attribute:NSLayoutAttributeHeight
                             multiplier:0
                             constant:[[dimension objectForKey:@"HISTORY_LIST_HEIGHT"] intValue]]];
    }
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.startMyDay.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.startMyDay
                         attribute:NSLayoutAttributeBottom
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.startMyDay
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.startMyDay
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.startMyDay
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:70]];
    
}

@end
