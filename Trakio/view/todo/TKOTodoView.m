//
//  TKOTodoView.m
//  Trakio
//
//  Created by yang wei on 04/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOTodoView.h"
#import "TKOLocationView.h"
#import "TKOTopBar.h"
#import "TKOJobBlock.h"


@implementation TKOTodoView {
    NSURLSession * session_;
}

@synthesize topMargin;
@synthesize topBar;
@synthesize backButton;
@synthesize checkInButton;
@synthesize todos;
@synthesize location;

-(id)initWithLocation:(TKOLocation *)l {
    
    if (self = [super init]) {
        self.location = l;
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
        
        self.todoBlock = [[TKOJobBlock alloc] initWithTitle:@"To-DO List" Icon:FaCheck ActionView:nil];
        [self addSubview:self.todoBlock];
        
        self.todos = [[NSMutableDictionary alloc] init];
        
        NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        [sessionConfiguration setAllowsCellularAccess:YES];
        
        session_ = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        
        NSString * ServerURL = [TKOSystem getAPIUrl];
        NSString * locationTodoUrlStr = [ServerURL stringByAppendingString:@"location/todos?token=%@&location_id=%@"];
        
        NSString * locationUrlString = [NSString stringWithFormat:locationTodoUrlStr, self.employee.employeeToken, self.location.locationID];
        NSURL * locationUrl = [NSURL URLWithString:locationUrlString];
        NSLog(locationUrlString);
        
        NSURLSessionDataTask * dataTask = [session_ dataTaskWithURL:locationUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
                NSLog(@"%d", httpResponse.statusCode);
                NSString * responseJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(responseJson);
                
                NSDictionary * jsonDcit = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions error:&error];
//                NSString * status = [jsonDcit objectForKey:@"status"];
//                NSLog(@"status:", status);
//                if ([status isEqualToString:@"success"]) {
                
//                    NSDictionary * locationData = [jsonDcit objectForKey:@"data"];
                    NSDictionary * locationData = jsonDcit;
                    NSArray * todosArray = [locationData objectForKey:@"todos"];
                    
                    NSMutableDictionary * myTodos = [[NSMutableDictionary alloc] init];
                    
                    for (int i = 0; i < todosArray.count; i++) {
                        NSDictionary * myTodo = todosArray[i];
                        
                        TKOTodo * todoEntry = [[TKOTodo alloc] initWithTitle:[myTodo objectForKey:@"title"] Description:[myTodo objectForKey:@"description"]];
                        
                        todoEntry.todoID = [myTodo objectForKey:@"id"];
                        todoEntry.locationID = [myTodo objectForKey:@"location_id"];
                        todoEntry.created_at = [myTodo objectForKey:@"created_at"];
                        todoEntry.updated_at = [myTodo objectForKey:@"updated_at"];
                        
                        [myTodos setValue:todoEntry forKey:[NSString stringWithFormat:@"%d", i]];
                        
                    }
                    
                    [self performSelectorOnMainThread:@selector(showTodoList:) withObject:myTodos waitUntilDone:NO];
//                }
                
                
//                NSString * responseJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(responseJson);
            }
        }];
        [dataTask resume];
        
        self.todoList = [[TKOTodoListView alloc] initWithTodoList:self.todos];
        self.todoList.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.todoList.layoutMargins = UIEdgeInsetsZero;
        [self.todoList setBackgroundColor:[TKOSystem homeViewBackgroundColor]];
        [self addSubview:self.todoList];
        
        self.backButton = [[UIButton alloc] init];
        [self.backButton setTitle:@"BACK" forState:UIControlStateNormal];
        [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.backButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.backButton.titleLabel.font = [UIFont fontWithName:@"Montserrat" size:20];
        self.backButton.backgroundColor = [UIColor orangeColor];
        [self.backButton addTarget:self action:@selector(backToLocationView:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.backButton];
        
        self.checkInButton = [[UIButton alloc] init];
        [self.checkInButton setTitle:@"CHECK IN" forState:UIControlStateNormal];
        [self.checkInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.checkInButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.checkInButton.titleLabel.font = [UIFont fontWithName:@"Montserrat" size:20];
        self.checkInButton.backgroundColor = [TKOSystem trakioGreenColor];
        [self.checkInButton addTarget:self action:@selector(checkInClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.checkInButton];
    }
    
    return self;
}

-(void)showTodoList:(NSDictionary *)todoslist {
    
    self.todoList = [[TKOTodoListView alloc] initWithTodoList:todoslist];
    self.todoList.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.todoList.layoutMargins = UIEdgeInsetsZero;
    [self.todoList setBackgroundColor:[TKOSystem homeViewBackgroundColor]];
//    [self.todoList setBackgroundColor:[UIColor whiteColor]];
//    [self.todoList beginUpdates];
//    [self addSubview:self.todoList];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFade];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[self.todoList layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self insertSubview:self.todoList belowSubview:self.todoBlock];
//    [self.todoList endUpdates];
//    [self addSubview:self.todoList];

}

-(void)backToLocationView:(UIButton *)button {
    
    extern TKOEmployee * myself;
    self.employee = myself;
    TKOLocationView * lv = [[TKOLocationView alloc] initWithEmployee:self.employee];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[lv layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self.window.rootViewController.view addSubview:lv];
}

-(void)checkInClicked:(UIButton *)button {
    
    self.checkInButton.userInteractionEnabled = NO;
    self.checkInButton.backgroundColor = [UIColor colorWithRed:58.0/255.0 green:138.0/255.0 blue:63.0/255.0 alpha:1];
    [self.checkInButton setTitleColor:[UIColor colorWithRed:29.0/255.0 green:75.0/255.0 blue:32.0/255.0 alpha:1] forState:UIControlStateNormal];
    
    self.backButton.userInteractionEnabled = NO;
    self.backButton.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:112.0/255.0 blue:0.0/255.0 alpha:1];
    [self.backButton setTitleColor:[UIColor colorWithRed:147.0/255.0 green:74.0/255.0 blue:1.0/255.0 alpha:1] forState:UIControlStateNormal];
    
    NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setAllowsCellularAccess:YES];
    
    session_ = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    extern TKOEmployee * myself;
    self.employee = myself;
    
    
    NSString * ServerURL = [TKOSystem getAPIUrl];
    NSString * checkinUrlStr = [ServerURL stringByAppendingString:@"check-ins/create?token=%@&location_id=%@"];
    NSString * checkInUrlString = [NSString stringWithFormat:checkinUrlStr, self.employee.employeeToken, self.location.locationID];
    NSURL * checkInUrl = [NSURL URLWithString:checkInUrlString];
    NSLog(checkInUrlString);
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:checkInUrl];
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
                
                NSLog(@"checked in");
                NSDictionary * jsonDcit = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions error:&error];
                NSDictionary * dataArray = [jsonDcit objectForKey:@"data"];
                NSString * checkInID = [dataArray objectForKey:@"id"];
                
                TKOPerference * usrPerference = [TKOPerference getPerference];
                [usrPerference.tkoSettings setValue:checkInID forKey:@"TRAKIO_CHECKED_ID"];
                [usrPerference.tkoSettings setValue:self.location.locationID forKey:@"TRAKIO_CHECKED_LOCATION_ID"];
                [usrPerference.tkoSettings setValue:self.location.name forKey:@"TRAKIO_CHECKED_LOCATION_NAME"];
                [usrPerference.tkoSettings setValue:self.location.shift.shiftID forKey:@"TRAKIO_CHECKED_LOCATION_SHIFT_ID"];
                [usrPerference.tkoSettings setValue:[NSString stringWithFormat:@"%f", self.location.latitude] forKey:@"TRAKIO_CHECKED_LOCATION_LATITUDE"];
                [usrPerference.tkoSettings setValue:[NSString stringWithFormat:@"%f", self.location.longitude] forKey:@"TRAKIO_CHECKED_LOCATION_LONGITUDE"];
                myself.checkInID = checkInID;
                [usrPerference savePerference];
                
                NSLog(@"User Checked In, Trakio user check-in data is saved");
                [self performSelectorOnMainThread:@selector(goToCheckInView:) withObject:self.location waitUntilDone:NO];
                
            }else if (httpResponse.statusCode == 401) {
                [self performSelectorOnMainThread:@selector(showAlertView:) withObject:@"Checking in multiple location is not allowed." waitUntilDone:NO];
                self.checkInButton.userInteractionEnabled = YES;
                self.checkInButton.backgroundColor = [TKOSystem trakioGreenColor];
                [self.checkInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.backButton.userInteractionEnabled = YES;
                self.backButton.backgroundColor = [UIColor orangeColor];
                [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else {
                [self performSelectorOnMainThread:@selector(showAlertView:) withObject:@"Bad internet connection, please try again later." waitUntilDone:NO];
                self.checkInButton.userInteractionEnabled = YES;
                self.checkInButton.backgroundColor = [TKOSystem trakioGreenColor];
                [self.checkInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.backButton.userInteractionEnabled = YES;
                self.backButton.backgroundColor = [UIColor orangeColor];
                [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
                                                          
            NSString * responseJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"response data : %@",responseJson);
            
        }
    }];
    [dataTask resume];
    
}

-(void)goToCheckInView:(TKOLocation *)loc {
    
    TKOCheckInView * civ = [[TKOCheckInView alloc] initWithLocation:loc];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[civ layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self.window.rootViewController.view addSubview:civ];
}

-(void)showAlertView:(NSString *)message {
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Trakio" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alertView show];
    
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
    self.todoList.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoList
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.todoBlock
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:1]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoList
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self.todoBlock
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoList
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self.todoBlock
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoList
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
    self.checkInButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkInButton
                         attribute:NSLayoutAttributeBottom
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkInButton
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkInButton
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.5
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkInButton
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
