//
//  TKOHistoryColumnView.h
//  Trakio
//
//  Created by yang wei on 03/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"

@interface TKOHistoryColumnView : UIView

@property(nonatomic, strong)UILabel * Icon;
@property(nonatomic, strong)UILabel * Text;

-(id)initWithIcon:(FaIcon)i Text:(NSString *)t;

@end
