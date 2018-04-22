//
//  TKOLocation.h
//  Trakio
//
//  Created by yang wei on 03/03/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKOEmployeeShift.h"

@interface TKOLocation : NSObject

@property(nonatomic, copy)NSString * locationID;
@property(nonatomic, strong)TKOEmployeeShift * shift;
@property(nonatomic, copy)NSString * name;
@property(nonatomic, copy)NSString * address;
@property(nonatomic, copy)NSString * city;
@property(nonatomic, copy)NSString * country;
@property(nonatomic, copy)NSString * postalCode;
@property(nonatomic, assign)float latitude;
@property(nonatomic, assign)float longitude;
@property(nonatomic, assign)bool finished;

-(id)initWithLatitude:(float)lat Longitude:(float)lng;

@end
