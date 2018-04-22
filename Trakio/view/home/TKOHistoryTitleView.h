//
//  TKOHistoryTitleView.h
//  Trakio
//
//  Created by yang wei on 03/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOHistoryColumnView.h"
#import "NSString+FontAwesome.h"

@interface TKOHistoryTitleView : UIView

@property(nonatomic, strong)UIView * occupationView;
@property(nonatomic, strong)TKOHistoryColumnView * checkInView;
@property(nonatomic, strong)TKOHistoryColumnView * checkOutView;
@property(nonatomic, strong)TKOHistoryColumnView * timeView;

@end
