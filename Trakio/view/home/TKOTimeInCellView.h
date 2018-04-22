//
//  TKOTimeInCellView.h
//  Trakio
//
//  Created by yang wei on 02/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"

@interface TKOTimeInCellView : UIView

@property(nonatomic, copy)NSString * time;
@property(nonatomic)FaIcon suffix;
@property(nonatomic, strong)UILabel * timeLabel;
@property(nonatomic, strong)UILabel * suffixLabel;

-(id)initWithTime:(NSString *)t Suffix:(FaIcon)s;

@end
