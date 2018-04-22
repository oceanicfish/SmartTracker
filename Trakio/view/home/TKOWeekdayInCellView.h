//
//  TKOWeekdayInCellView.h
//  Trakio
//
//  Created by yang wei on 02/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKOWeekdayInCellView : UIView

@property(nonatomic, copy)NSString * weekday;
@property(nonatomic, copy)NSString * date;
@property(nonatomic, strong)UILabel * weekdayLabel;
@property(nonatomic, strong)UILabel * dateLabel;

-(id)initWithWeekday:(NSString *)wd Date:(NSString *)dt;

@end
