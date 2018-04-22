//
//  TKOEmployee.m
//  Trakio
//
//  Created by yang wei on 01/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOEmployee.h"

@implementation TKOEmployee

@synthesize employeeID;
@synthesize employeeFirstName;
@synthesize employeeToken;
@synthesize employeePhoto;
@synthesize started;
@synthesize breakStatus;
@synthesize checkInID;

-(id)initWithEmployeeID:(NSString *)ID Token:(NSString *)token {
    if (self = [super init]) {
        self.employeeID = ID;
        self.employeeToken = token;
        self.started = false;
        self.breakStatus = false;
    }
    
    return self;
}


@end
