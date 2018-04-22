//
//  TKOCheckInView.h
//  Trakio
//
//  Created by yang wei on 04/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TKOLocationView.h"
#import "TKOSystem.h"
#import "TKOLocation.h"
#import "TKOEmployee.h"


@class TKOTopBar;
@class TKOJobBlock;
@class TKOLocationView;
@class TKONoteEditorView;
@class TKOTodoEditorView;
@class TKONoteView;

@interface TKOCheckInView : UIView

@property(nonatomic, strong)UIView * topMargin;
@property(nonatomic, strong)TKOTopBar * topBar;
@property(nonatomic, strong)UIButton * takeBreakButton;
@property(nonatomic, strong)UIButton * checkOutButton;
@property(nonatomic, strong)TKOJobBlock * todoBlock;
@property(nonatomic, strong)TKOJobBlock * noteBlock;
@property(nonatomic, strong)TKOJobBlock * photoBlock;
@property(nonatomic, strong)NSDictionary * todos;
@property(nonatomic, strong)NSDictionary * notes;
@property(nonatomic, strong)NSDictionary * photos;
@property(nonatomic, strong)TKOLocation * location;
@property(nonatomic, strong)TKOEmployee * employee;
@property(nonatomic, strong)UILabel * checkInStatusLabel;
@property(nonatomic, strong)UIActivityIndicatorView * activityView;

-(id)initWithLocation:(TKOLocation *)tl;

-(void)hideActivityView;
-(void)changeBreakStatus;


@end
