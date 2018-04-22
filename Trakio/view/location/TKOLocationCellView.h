//
//  TKOLocationCellViewTableViewCell.h
//  Trakio
//
//  Created by yang wei on 04/03/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOSystem.h"

@interface TKOLocationCellView : UITableViewCell

@property(nonatomic, copy)NSString * number;
@property(nonatomic, copy)NSString * name;
@property(nonatomic, copy)NSString * address;
@property(nonatomic, copy)NSString * status;

@property(nonatomic, strong)UILabel * numberLabel;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UILabel * addressLabel;
@property(nonatomic, strong)UILabel * statusLable;

@end
