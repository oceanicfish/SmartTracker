//
//  TKOTodoListView.h
//  Trakio
//
//  Created by yang wei on 04/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOSystem.h"
#import "TKOTodo.h"
#import "TKOTodoCellView.h"

@interface TKOTodoListView : UITableView <UITableViewDataSource,
UITableViewDelegate>

@property(nonatomic, strong)NSDictionary * todolist;

-(id)initWithTodoList:(NSDictionary *)tl;

@end
