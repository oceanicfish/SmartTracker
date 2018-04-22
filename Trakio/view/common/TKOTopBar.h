//
//  TKOTopBar.h
//  Trakio
//
//  Created by yang wei on 01/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"

@interface TKOTopBar : UIView

@property(nonatomic, strong)UILabel * menuLabel;
@property(nonatomic, strong)UILabel * noticeLabel;
@property(nonatomic, strong)UIImageView * logoImageView;
@property(nonatomic, strong)UIView * separatorView;

//-(id)init;

@end
