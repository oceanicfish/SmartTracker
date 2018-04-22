//
//  TKOLocationListView.h
//  Trakio
//
//  Created by yang wei on 03/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOSystem.h"
#import "TKOLocationIndexView.h"
#import "TKOTodoView.h"
#import "TKOLocationCellView.h"
#import "TKOLocation.h"
#import "NSString+FontAwesome.h"

@interface TKOLocationListView : UITableView <UITableViewDataSource,
    UITableViewDelegate>

@property(nonatomic, strong)NSDictionary * locations;

-(id)initWithLocations:(NSDictionary *)ls;

@end
