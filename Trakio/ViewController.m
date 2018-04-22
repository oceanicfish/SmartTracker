//
//  ViewController.m
//  Trakio
//
//  Created by yang wei on 01/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "ViewController.h"

TKOEmployee * myself = nil;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TKOPerference * perference = [TKOPerference getPerference];
    
    NSString * userID = [perference.tkoSettings objectForKey:@"TRAKIO_USER_ID"];
    NSString * userToken = [perference.tkoSettings objectForKey:@"TRAKIO_TOKEN"];
    NSString * userFirstName = [perference.tkoSettings objectForKey:@"TRAKIO_USER_FIRST_NAME"];
    NSString * userPhoto = [perference.tkoSettings objectForKey:@"TRAKIO_USER_AVATAR_PATH"];
    NSString * startedAt = [perference.tkoSettings objectForKey:@"TRAKIO_USER_STARTED"];
    NSString * checkInID = [perference.tkoSettings objectForKey:@"TRAKIO_CHECKED_ID"];
//    if([checkInID isEqualToString:@"(null)"]) {
//        checkInID = @"";
//    }
    NSString * locationID = [perference.tkoSettings objectForKey:@"TRAKIO_CHECKED_LOCATION_ID"];
    NSString * locationName = [perference.tkoSettings objectForKey:@"TRAKIO_CHECKED_LOCATION_NAME"];
    NSString * shiftID = [perference.tkoSettings objectForKey:@"TRAKIO_CHECKED_LOCATION_SHIFT_ID"];
    NSString * latitude = [perference.tkoSettings objectForKey:@"TRAKIO_CHECKED_LOCATION_LATITUDE"];
    NSString * longitude = [perference.tkoSettings objectForKey:@"TRAKIO_CHECKED_LOCATION_LONGITUDE"];
    
    NSString * breakStatus = [perference.tkoSettings objectForKey:@"TRAKIO_BREAK_STATUS"];
    bool breakStatusflag;
    if (breakStatus == nil) {
        breakStatusflag = false;
    }else if([breakStatus isEqualToString:@"0"]) {
        breakStatusflag = false;
    }else {
        breakStatusflag = true;
    }
    
    TKOEmployee * emp = [[TKOEmployee alloc] initWithEmployeeID:userID Token:userToken];
    emp.employeeFirstName = userFirstName;
    emp.employeePhoto = userPhoto;
    
    if (startedAt != nil && startedAt.length > 0) {
        [emp setStarted:true];
    }else {
        [emp setStarted:false];
    }
    
    [emp setBreakStatus:breakStatusflag];
    
    myself = emp;
    myself.checkInID = checkInID;
//    myself.checkInID = [NSString stringWithFormat:@"%@", checkInID];
    
    self.view.frame = [UIScreen mainScreen].bounds;
    UIView * landingView;
    
    if (userToken.length > 0) {
        if (myself.checkInID != nil && myself.checkInID.length > 0) {
            NSLog(@"check-in id : %@", myself.checkInID);
            TKOLocation * checkedInlocation = [[TKOLocation alloc] initWithLatitude:[latitude floatValue] Longitude:[longitude floatValue]];
            checkedInlocation.locationID = locationID;
            checkedInlocation.name = locationName;
            TKOEmployeeShift * checkedInShift = [[TKOEmployeeShift alloc] initWithShift:shiftID Location:locationID];
            checkedInlocation.shift = checkedInShift;
            landingView = [[TKOCheckInView alloc] initWithLocation: checkedInlocation];
        }else {
            landingView = [[TKOHomeView alloc] initWithEmployee:emp];
        }
        
    }else {
        landingView = [[TKOLoginView alloc] init];
        landingView.frame = self.view.frame;

    }
    
    
    [self.view addSubview:landingView];
//    NSMutableDictionary * locations = [[NSMutableDictionary alloc] initWithCapacity:5];
//    
//    CLLocation * location1 = [[CLLocation alloc] initWithLatitude:10.324203 longitude:123.908806];
//    [locations setObject:location1 forKey:@"Crown 7 Bldg"];
//    
//    CLLocation * location2 = [[CLLocation alloc] initWithLatitude:10.317162 longitude:123.903571];
//    [locations setObject:location2 forKey:@"Ayala Center Cebu"];
//    
//    CLLocation * location3 = [[CLLocation alloc] initWithLatitude:10.311987 longitude:123.918199];
//    [locations setObject:location3 forKey:@"SM City Cebu"];
//    
//    CLLocation * location4 = [[CLLocation alloc] initWithLatitude:10.322727 longitude:123.913702];
//    [locations setObject:location4 forKey:@"Castle Peak Hotel"];
//    
//    CLLocation * location5 = [[CLLocation alloc] initWithLatitude:10.307578 longitude:123.893864];
//    [locations setObject:location5 forKey:@"Crown Regency Hotel"];
    
//    TKOCheckInView * civ = [[TKOCheckInView alloc] initWithTodos:locations];
//    [self.view addSubview:civ];

//    
//    TKOTodoView * tdv = [[TKOTodoView alloc] initWithTodos:locations];
//    [self.view addSubview:tdv];
//
//    TKOLocationView * lv = [[TKOLocationView alloc] initWithLocations:locations];
//    [self.view addSubview:lv];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
