//
//  TKOLocationView.m
//  Trakio
//
//  Created by yang wei on 03/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOLocationView.h"
#import "TKOHomeView.h"
#import "TKOTopBar.h"

@implementation TKOLocationView {
    NSURLSession * session_;
}

@synthesize locations;

-(id)initWithEmployee:(TKOEmployee *)emp {
    if (self = [super init]) {
        self.employee = emp;
        
        UIColor * backgroundColor = [TKOSystem homeViewBackgroundColor];
        [self setBackgroundColor:backgroundColor];
        
        self.mapView = [[TKOMapView alloc] initWithEmployee:self.employee];
        self.mapView.tintColor = [TKOSystem trakioGreenColor];
        [self addSubview:self.mapView];
        
        self.locations = [[NSMutableDictionary alloc] init];
        
        NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        [sessionConfiguration setAllowsCellularAccess:YES];
        
        session_ = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        
        NSString * ServerURL = [TKOSystem getAPIUrl];
        NSString * locationUrlStr = [ServerURL stringByAppendingString:@"locations/user-locations?token=%@&user_id=%@"];

        NSString * locationUrlString = [NSString stringWithFormat:locationUrlStr, self.employee.employeeToken, self.employee.employeeID];
        NSURL * locationUrl = [NSURL URLWithString:locationUrlString];
        
        NSURLSessionDataTask * dataTask = [session_ dataTaskWithURL:locationUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
                NSLog(@"%ld", httpResponse.statusCode);
                
                NSString * responseJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"response data : %@",responseJson);
                
                NSDictionary * jsonDcit = [NSJSONSerialization JSONObjectWithData:data
                                            options:kNilOptions error:&error];
//                NSArray * shifts = [jsonDcit objectForKey:@"data"];
//                NSArray * locations = [jsonDcit objectForKey:@"included"];
                NSArray * locations = [jsonDcit objectForKey:@"data"];
                
               
                NSMutableDictionary * myLocations = [[NSMutableDictionary alloc] init];
                
                for (int i = 0; i < locations.count; i++) {
                    NSDictionary * myLocation = [locations[i] objectForKey:@"attributes"];
                    
                    float myLatitude = [[myLocation objectForKey:@"latitude"] floatValue];
                    float myLongitude = [[myLocation objectForKey:@"longitude"] floatValue];
                    
                    TKOLocation * tLocation = [[TKOLocation alloc] initWithLatitude:myLatitude Longitude:myLongitude];
                    tLocation.locationID = [locations[i] objectForKey:@"id"];
                    tLocation.name = [myLocation objectForKey:@"name"];
                    tLocation.address = [myLocation objectForKey:@"address"];
                    tLocation.city = [myLocation objectForKey:@"city"];
                    tLocation.country = [myLocation objectForKey:@"country"];
                    tLocation.postalCode = [myLocation objectForKey:@"postalCode"];
//                    NSString * shiftID = [shifts[i] objectForKey:@"id"];
//                    tLocation.shift = [[TKOEmployeeShift alloc] initWithShift:shiftID Location:tLocation.locationID];
                    
                    [myLocations setValue:tLocation forKey:[NSString stringWithFormat:@"%d", i]];
                    
                }
                
                [self performSelectorOnMainThread:@selector(showLocationList:) withObject:myLocations waitUntilDone:NO];
                
            }
        }];
        [dataTask resume];
        
        self.locationListView = [[TKOLocationListView alloc] initWithLocations:self.locations];
        self.locationListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.locationListView.layoutMargins = UIEdgeInsetsZero;
        [self.locationListView setBackgroundColor:backgroundColor];
        
        [self addSubview:self.locationListView];
        
        UIColor * topColor = [TKOSystem topBarBackgroundColor];
        
        self.topMargin = [[UIView alloc] init];
        self.topMargin.backgroundColor = topColor;
        [self addSubview:self.topMargin];
        
        self.topBar = [[TKOTopBar alloc] init];
        self.topBar.backgroundColor = topColor;
        [self addSubview:self.topBar];
        
        self.endMyDay = [[UIButton alloc] init];
        [self.endMyDay setTitle:@"我的工时" forState:UIControlStateNormal];
        [self.endMyDay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.endMyDay.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.endMyDay.titleLabel.font = [UIFont fontWithName:@"Montserrat" size:24];
        self.endMyDay.backgroundColor = [UIColor orangeColor];
        [self.endMyDay addTarget:self action:@selector(endMyDay:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.endMyDay];
    }
    
    return self;
}

-(void)showLocationList:(NSDictionary *)locations{
    
    self.locationListView = [[TKOLocationListView alloc] initWithLocations:locations];
    self.locationListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.locationListView.layoutMargins = UIEdgeInsetsZero;
    [self.locationListView setBackgroundColor:[TKOSystem homeViewBackgroundColor]];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromBottom];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[self.locationListView layer]addAnimation:animation forKey:@"viewAnimation"];
   
    [self insertSubview:self.locationListView belowSubview:self.mapView];
    
    self.mapView.mylocations = locations;
    [self.mapView tkShowAnnotations];

}

-(id)initWithLocations:(NSDictionary *)ls {
    if (self = [super init]) {
        self.locations = ls;
        
        UIColor * backgroundColor = [TKOSystem homeViewBackgroundColor];
        [self setBackgroundColor:backgroundColor];
        
        self.mapView = [[TKOMapView alloc] initWithLocations:ls];
        self.mapView.tintColor = [TKOSystem trakioGreenColor];
        [self addSubview:self.mapView];
        
        self.locationListView = [[TKOLocationListView alloc] initWithLocations:ls];
        self.locationListView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.locationListView.layoutMargins = UIEdgeInsetsZero;
        [self.locationListView setBackgroundColor:backgroundColor];
        [self addSubview:self.locationListView];
        
        UIColor * topColor = [TKOSystem topBarBackgroundColor];
        
        self.topMargin = [[UIView alloc] init];
        self.topMargin.backgroundColor = topColor;
        [self addSubview:self.topMargin];
        
        self.topBar = [[TKOTopBar alloc] init];
        self.topBar.backgroundColor = topColor;
        [self addSubview:self.topBar];
        
        self.endMyDay = [[UIButton alloc] init];
        [self.endMyDay setTitle:@"我的工时" forState:UIControlStateNormal];
        [self.endMyDay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.endMyDay.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.endMyDay.titleLabel.font = [UIFont fontWithName:@"Montserrat" size:24];
        self.endMyDay.backgroundColor = [UIColor orangeColor];
        [self.endMyDay addTarget:self action:@selector(endMyDay:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.endMyDay];
    }
    
    return self;
}

-(void)endMyDay:(UIButton *)button {
    
    self.endMyDay.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:112.0/255.0 blue:0.0/255.0 alpha:1];
    [self.endMyDay setTitleColor:[UIColor colorWithRed:147.0/255.0 green:74.0/255.0 blue:1.0/255.0 alpha:1] forState:UIControlStateNormal];
    
    TKOHomeView * hv = [[TKOHomeView alloc] initWithEmployee:self.employee];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[hv layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self.window.rootViewController.view addSubview:hv];
}

-(void)layoutSubviews {
    
    extern NSMutableDictionary * dimension;
    
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
    self.mapView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.mapView
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.topBar
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.mapView
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.mapView
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.mapView
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0.4
                         constant:0]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.locationListView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.locationListView
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.mapView
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.locationListView
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.locationListView
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.locationListView
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:[[dimension objectForKey:@"LOCATION_LIST_HEIGHT"] intValue]]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.endMyDay.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.endMyDay
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:70]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.endMyDay
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.endMyDay
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.endMyDay
                         attribute:NSLayoutAttributeBottom
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];

    
}

@end
