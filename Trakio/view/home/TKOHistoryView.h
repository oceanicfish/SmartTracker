//
//  TKOHistoryView.h
//  Trakio
//
//  Created by yang wei on 02/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOWeekdayInCellView.h"
#import "TKOTimeInCellView.h"
#import "TKOSystem.h"
#import "NSString+FontAwesome.h"

@interface TKOHistoryView : UIView

@property(nonatomic, strong)TKOWeekdayInCellView * weekdayView;
@property(nonatomic, strong)TKOTimeInCellView * startTimeView;
@property(nonatomic, strong)TKOTimeInCellView * endTimeView;
@property(nonatomic, strong)TKOTimeInCellView * durationView;
@property(nonatomic, strong)UIView * separatorView;
@property(nonatomic, assign)bool separated;

-(id)initWithWeekday:(NSString *)wd Date:(NSString *)dt
           StartTime:(NSString *)st StartTimeSuffix:(FaIcon)sts
             EndTime:(NSString *)et EndTimeSuffix:(FaIcon)ets
            Duration:(NSString *)dt Separator:(BOOL)sep ;

@end
