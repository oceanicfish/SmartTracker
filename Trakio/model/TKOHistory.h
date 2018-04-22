//
//  TKOHistory.h
//  Trakio
//
//  Created by yang wei on 27/04/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKOHistory : NSObject
@property(nonatomic, copy)NSString * weekday;
@property(nonatomic, copy)NSString * date;
@property(nonatomic, copy)NSString * startTime;
@property(nonatomic, copy)NSString * startTimeSuffix;
@property(nonatomic, copy)NSString * endTime;
@property(nonatomic, copy)NSString * endTimeSuffix;
@property(nonatomic, copy)NSString * duration;

@end
