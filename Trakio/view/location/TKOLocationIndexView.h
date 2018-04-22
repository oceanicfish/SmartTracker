//
//  TKOLocationIndexView.h
//  Trakio
//
//  Created by yang wei on 03/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOSystem.h"

@interface TKOLocationIndexView : UIImageView

@property(nonatomic, strong)UILabel * indexLabel;
@property(nonatomic, strong)NSString * indexNumber;

-(id)initWithIndexNumber:(NSString *)number;

@end
