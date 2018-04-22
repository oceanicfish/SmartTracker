//
//  TKOLocation.m
//  Trakio
//
//  Created by yang wei on 03/03/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOLocation.h"

@implementation TKOLocation

@synthesize locationID;
@synthesize name;
@synthesize address;
@synthesize city;
@synthesize country;
@synthesize postalCode;
@synthesize latitude;
@synthesize longitude;
@synthesize shift;


-(id)initWithLatitude:(float)lat Longitude:(float)lng {
    if (self = [super init]) {
        self.latitude = lat;
        self.longitude = lng;
        self.finished = false;
    }
    
    return self;
}

@end
