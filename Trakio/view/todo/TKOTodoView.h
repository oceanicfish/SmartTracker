//
//  TKOTodoView.h
//  Trakio
//
//  Created by yang wei on 04/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOSystem.h"
#import "TKOCheckInView.h"
#import "TKOTodoListView.h"
#import "TKOEmployee.h"
#import "TKOLocation.h"
#import "TKOTodo.h"
#import "TKOPerference.h"

@class TKOTopBar;
@class TKOJobBlock;
@class TKOLocationView;

@interface TKOTodoView : UIView

@property(nonatomic, strong)UIView * topMargin;
@property(nonatomic, strong)TKOTopBar * topBar;
@property(nonatomic, strong)TKOJobBlock * todoBlock;
@property(nonatomic, strong)TKOTodoListView * todoList;
@property(nonatomic, strong)UIButton * backButton;
@property(nonatomic, strong)UIButton * checkInButton;
@property(nonatomic, strong)NSDictionary * todos;
@property(nonatomic, strong)TKOEmployee * employee;
@property(nonatomic, strong)TKOLocation * location;

-(id)initWithLocation:(TKOLocation *)l;
//-(id)initWithEmployee:(TKOEmployee *)emp;
//-(id)initWithTodos:(NSDictionary *)tds;

-(void)showTodoList:(NSDictionary *)todoList;

@end
