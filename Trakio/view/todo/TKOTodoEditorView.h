//
//  TKOTodoEditorView.h
//  Trakio
//
//  Created by yang wei on 05/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOTopBar.h"
#import "TKOSystem.h"
#import "TKOJobBlock.h"
#import "TKOCheckInView.h"
#import "TKOTodoListEditorView.h"

@interface TKOTodoEditorView : UIView

@property(nonatomic, strong)UIView * topMargin;
@property(nonatomic, strong)TKOTopBar * topBar;
@property(nonatomic, strong)TKOJobBlock * todoBlock;
@property(nonatomic, strong)TKOTodoListEditorView * todoList;
@property(nonatomic, strong)UIButton * backButton;
@property(nonatomic, strong)UIButton * checkInButton;
@property(nonatomic, strong)NSDictionary * todos;
@property(nonatomic, strong)TKOLocation * location;
@property(nonatomic, strong)TKOEmployee * employee;
@property(nonatomic, strong)UIActivityIndicatorView * activityView;

-(id)initWithLocation:(TKOLocation *)lo;
-(void)showTodoList:(NSDictionary *)todoslist;

@end
