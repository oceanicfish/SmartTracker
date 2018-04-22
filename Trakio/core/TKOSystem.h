//
//  TKOSystem.h
//  Trakio
//
//  Created by yang wei on 02/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TKOSystem : NSObject

+(UIColor *)homeViewBackgroundColor;
+(UIColor *)topBarBackgroundColor;
+(UIColor *)trakioGreenColor;
+(int)jobBlockHeight;
+(int)tableHeight;
+(NSMutableDictionary *)getLayoutDimension:(int)height;
+(NSString *)getAPIUrl;
+(NSDate *)getDateFromString:(NSString *)dateString;
+(NSString *)getWeekday:(NSInteger *)weekdayIndex;

@end
