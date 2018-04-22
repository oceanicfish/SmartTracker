//
//  TKOEmployeeShift.h
//  Trakio
//
//  Created by yang wei on 07/03/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKOEmployeeShift : NSObject

@property(nonatomic, copy)NSString * shiftID;
@property(nonatomic, copy)NSString * locationID;

-(id)initWithShift:(NSString *)sid Location:(NSString *)lid;

@end
