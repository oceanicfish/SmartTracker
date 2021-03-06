//
//  TKOTodoListEditorView.h
//  Trakio
//
//  Created by yang wei on 05/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOSystem.h"
#import "TKOTodo.h"
#import "TKOTodoEditorCellView.h"
#import "TKOEmployee.h"

@interface TKOTodoListEditorView : UITableView <UITableViewDataSource,
UITableViewDelegate>

@property(nonatomic, strong)NSDictionary * todolist;
@property(nonatomic, strong)TKOEmployee * employee;


-(id)initWithTodoList:(NSDictionary *)tl;
-(void)markDownTodo:(NSIndexPath *)index;

@end
