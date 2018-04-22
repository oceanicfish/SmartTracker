//
//  TKONoteCellView.h
//  Trakio
//
//  Created by yang wei on 08/03/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOSystem.h"
#import "NSString+FontAwesome.h"
#import "TKONote.h"

@interface TKONoteCellView : UITableViewCell

@property(nonatomic, strong)UILabel * titleLabel;
@property(nonatomic, strong)UILabel * contentLable;
@property(nonatomic, strong)UILabel * checkLabel;

@end
