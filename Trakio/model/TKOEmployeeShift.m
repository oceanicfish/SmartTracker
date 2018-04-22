//
//  TKOEmployeeShift.m
//  Trakio
//
//  Created by yang wei on 07/03/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOEmployeeShift.h"

@implementation TKOEmployeeShift

@synthesize shiftID;
@synthesize locationID;

-(id)initWithShift:(NSString *)sid Location:(NSString *)lid {
    if (self = [super init]) {
        self.shiftID = sid;
        self.locationID = lid;
    }
    
    return self;
}

@end
