//
//  TKOHistoryTableView.h
//  Trakio
//
//  Created by yang wei on 02/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOHistoryView.h"
#import "NSString+FontAwesome.h"

@interface TKOHistoryTableView : UITableView <UITableViewDataSource,
UITableViewDelegate>

@property(nonatomic, strong)NSDictionary * history;

-(id)initWithHistory:(NSDictionary *)his;

@end
