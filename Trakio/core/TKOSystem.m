//
//  TKOSystem.m
//  Trakio
//
//  Created by yang wei on 02/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOSystem.h"

@implementation TKOSystem

+(UIColor *)homeViewBackgroundColor {
    return [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0];
}

+(UIColor *)topBarBackgroundColor {
    return [UIColor colorWithRed:251.0/255.0 green:251.0/255.0 blue:251.0/255.0 alpha:1.0];
}

+(UIColor *)trakioGreenColor {
    return [UIColor colorWithRed:75.0/255.0 green:174.0/255.0 blue:81.0/255.0 alpha:1.0];
}

+(int)jobBlockHeight {
    return 60;
}

+(int)tableHeight {
    return 220;
}

+(NSMutableDictionary *)getLayoutDimension:(int)height {
    NSMutableDictionary * dimensions = [[NSMutableDictionary alloc] initWithCapacity:5];
    if (height == 736) { // iphone 6 plus/6s plus
        [dimensions setObject:@"363" forKey:@"NOTE_LIST_HEIGHT"];
        [dimensions setObject:@"0" forKey:@"LOGIN_LOGO_OFFSIZE"];
        [dimensions setObject:@"441" forKey:@"LOGIN_LOGO_WEIGHT"];
        [dimensions setObject:@"441" forKey:@"LOGIN_LOGO_HEIGHT"];
        [dimensions setObject:@"736" forKey:@"DEVICE_HEIGHT"];
        [dimensions setObject:@"40" forKey:@"TODAY_VIEW_HEIGHT"];
        [dimensions setObject:@"20" forKey:@"START_MY_DAY_SIZE"];
        [dimensions setObject:@"18" forKey:@"TIME_LABEL_SIZE"];
        [dimensions setObject:@"10" forKey:@"SUFFIX_LABEL_SIZE"];
        [dimensions setObject:@"18" forKey:@"WEEKDAY_LABEL_SIZE"];
        [dimensions setObject:@"8" forKey:@"DATE_LABEL_SIZE"];
        [dimensions setObject:@"18" forKey:@"TODAY_IS_FONT_SIZE"];
        [dimensions setObject:@"18" forKey:@"TODAY_DATE_FONT_SIZE"];
        [dimensions setObject:@"210" forKey:@"AVATAR_IMAGE_SIZE"];
        [dimensions setObject:@"24" forKey:@"HELLO_USERNAME_SIZE"];
        [dimensions setObject:@"260" forKey:@"WELCOME_VIEW_HEIGHT"];
        [dimensions setObject:@"220" forKey:@"HISTORY_LIST_HEIGHT"];
        [dimensions setObject:@"265" forKey:@"LOCATION_LIST_HEIGHT"];
    }else if (height == 667) { // iphone 6/6s
        [dimensions setObject:@"302.5" forKey:@"NOTE_LIST_HEIGHT"];
        [dimensions setObject:@"0" forKey:@"LOGIN_LOGO_OFFSIZE"];
        [dimensions setObject:@"400" forKey:@"LOGIN_LOGO_WEIGHT"];
        [dimensions setObject:@"400" forKey:@"LOGIN_LOGO_HEIGHT"];
        [dimensions setObject:@"667" forKey:@"DEVICE_HEIGHT"];
        [dimensions setObject:@"40" forKey:@"TODAY_VIEW_HEIGHT"];
        [dimensions setObject:@"20" forKey:@"START_MY_DAY_SIZE"];
        [dimensions setObject:@"18" forKey:@"TIME_LABEL_SIZE"];
        [dimensions setObject:@"10" forKey:@"SUFFIX_LABEL_SIZE"];
        [dimensions setObject:@"18" forKey:@"WEEKDAY_LABEL_SIZE"];
        [dimensions setObject:@"8" forKey:@"DATE_LABEL_SIZE"];
        [dimensions setObject:@"15" forKey:@"TODAY_IS_FONT_SIZE"];
        [dimensions setObject:@"15" forKey:@"TODAY_DATE_FONT_SIZE"];
        [dimensions setObject:@"190" forKey:@"AVATAR_IMAGE_SIZE"];
        [dimensions setObject:@"22" forKey:@"HELLO_USERNAME_SIZE"];
        [dimensions setObject:@"238" forKey:@"WELCOME_VIEW_HEIGHT"];
        [dimensions setObject:@"219" forKey:@"HISTORY_LIST_HEIGHT"];
        [dimensions setObject:@"220" forKey:@"LOCATION_LIST_HEIGHT"];
    }else if (height == 568) { // iphone 5/5c/5s
        [dimensions setObject:@"242" forKey:@"NOTE_LIST_HEIGHT"];
        [dimensions setObject:@"155" forKey:@"LOGIN_LOGO_OFFSIZE"];
        [dimensions setObject:@"340" forKey:@"LOGIN_LOGO_WEIGHT"];
        [dimensions setObject:@"340" forKey:@"LOGIN_LOGO_HEIGHT"];
        [dimensions setObject:@"568" forKey:@"DEVICE_HEIGHT"];
        [dimensions setObject:@"40" forKey:@"TODAY_VIEW_HEIGHT"];
        [dimensions setObject:@"20" forKey:@"START_MY_DAY_SIZE"];
        [dimensions setObject:@"18" forKey:@"TIME_LABEL_SIZE"];
        [dimensions setObject:@"10" forKey:@"SUFFIX_LABEL_SIZE"];
        [dimensions setObject:@"18" forKey:@"WEEKDAY_LABEL_SIZE"];
        [dimensions setObject:@"8" forKey:@"DATE_LABEL_SIZE"];
        [dimensions setObject:@"15" forKey:@"TODAY_IS_FONT_SIZE"];
        [dimensions setObject:@"15" forKey:@"TODAY_DATE_FONT_SIZE"];
        [dimensions setObject:@"160" forKey:@"AVATAR_IMAGE_SIZE"];
        [dimensions setObject:@"20" forKey:@"HELLO_USERNAME_SIZE"];
        [dimensions setObject:@"203" forKey:@"WELCOME_VIEW_HEIGHT"];
        [dimensions setObject:@"180" forKey:@"HISTORY_LIST_HEIGHT"];
        [dimensions setObject:@"180" forKey:@"LOCATION_LIST_HEIGHT"];
    }else { // iphone 4/4s
        [dimensions setObject:@"181.5" forKey:@"NOTE_LIST_HEIGHT"];
        [dimensions setObject:@"155" forKey:@"LOGIN_LOGO_OFFSIZE"];
        [dimensions setObject:@"192" forKey:@"LOGIN_LOGO_WEIGHT"];
        [dimensions setObject:@"192" forKey:@"LOGIN_LOGO_HEIGHT"];
        [dimensions setObject:@"480" forKey:@"DEVICE_HEIGHT"];
        [dimensions setObject:@"35" forKey:@"TODAY_VIEW_HEIGHT"];
        [dimensions setObject:@"18" forKey:@"START_MY_DAY_SIZE"];
        [dimensions setObject:@"18" forKey:@"TIME_LABEL_SIZE"];
        [dimensions setObject:@"10" forKey:@"SUFFIX_LABEL_SIZE"];
        [dimensions setObject:@"18" forKey:@"WEEKDAY_LABEL_SIZE"];
        [dimensions setObject:@"8" forKey:@"DATE_LABEL_SIZE"];
        [dimensions setObject:@"15" forKey:@"TODAY_IS_FONT_SIZE"];
        [dimensions setObject:@"15" forKey:@"TODAY_DATE_FONT_SIZE"];
        [dimensions setObject:@"130" forKey:@"AVATAR_IMAGE_SIZE"];
        [dimensions setObject:@"18" forKey:@"HELLO_USERNAME_SIZE"];
        [dimensions setObject:@"164" forKey:@"WELCOME_VIEW_HEIGHT"];
        [dimensions setObject:@"135" forKey:@"HISTORY_LIST_HEIGHT"];
        [dimensions setObject:@"135" forKey:@"LOCATION_LIST_HEIGHT"];
    }
    return dimensions;
}

+(NSString *)getAPIUrl {
    return @"http://yw.enumen.com/api/";
}

+(NSDate *)getDateFromString:(NSString *)dateString {
    dateString = [dateString stringByAppendingString:@" +0000"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    NSDate * date=[formatter dateFromString:dateString];
    return date;
}

+(NSString *)getWeekday:(NSInteger *) weekdayIndex {
    if (weekdayIndex == 1) {
        return @"星期天";
    }else if (weekdayIndex == 2) {
        return @"星期一";
    }else if (weekdayIndex == 3) {
        return @"星期二";
    }else if (weekdayIndex == 4) {
        return @"星期三";
    }else if (weekdayIndex == 5) {
        return @"星期四";
    }else if (weekdayIndex == 6) {
        return @"星期五";
    }else if (weekdayIndex == 7) {
        return @"星期六";
    }else {
        return @"未知";
    }
}

@end
