//
//  TKOHomeView.h
//  Trakio
//
//  Created by yang wei on 02/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TKOTopBar.h"
#import "TKOWelcomeView.h"
#import "TKOTodayView.h"
#import "TKOHistoryView.h"
#import "TKOHistoryTableView.h"
#import "TKOStartMyDayView.h"
#import "TKOHistoryTitleView.h"
#import "TKOSystem.h"
#import "TKOEmployee.h"
#import "TKOLoginView.h"

@interface TKOHomeView : UIView <UIAlertViewDelegate>

@property(nonatomic, strong)UIView * topMargin;
@property(nonatomic, strong)TKOTopBar * topBar;
@property(nonatomic, strong)TKOWelcomeView * welcomeView;
@property(nonatomic, strong)TKOTodayView * todayView;
@property(nonatomic, strong)TKOHistoryView * historyView;
@property(nonatomic, strong)TKOHistoryTableView * historyTableView;
@property(nonatomic, strong)TKOHistoryTitleView * historyTitleView;
//for layout test
//@property(nonatomic, strong)UILabel * startMyDay;
@property(nonatomic, strong)UIButton * startMyDay;
//@property(nonatomic, strong)TKOStartMyDayView * startMyDayView;
@property(nonatomic, strong)TKOEmployee * employee;

-(id)initWithEmployee:(TKOEmployee *)e;

//-(void)startMyday;
-(void)changeButtonStatus:(TKOEmployee *)emp;
-(void)trackLocation;
-(void)loadHistoryData;
-(void)goLocationView:(TKOEmployee *)emp;
-(void)goBackLoginView:(TKOEmployee *)emp;
-(void)showTokenExpired;

@end
