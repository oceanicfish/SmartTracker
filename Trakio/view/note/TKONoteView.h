//
//  TKONoteView.h
//  Trakio
//
//  Created by yang wei on 05/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOTopBar.h"
#import "TKOJobBlock.h"
#import "TKONoteListView.h"
#import "TKOEmployee.h"
#import "TKOLocation.h"
#import "TKONote.h"

@class TKOCheckInView;
@class TKONoteEditorView;

@interface TKONoteView : UIView

@property(nonatomic, strong)UIView * topMargin;
@property(nonatomic, strong)TKOTopBar * topBar;
@property(nonatomic, strong)TKOJobBlock * todoBlock;
@property(nonatomic, strong)TKONoteListView * noteList;
@property(nonatomic, strong)UIButton * backButton;
@property(nonatomic, strong)UIButton * addButton;
@property(nonatomic, strong)NSDictionary * notes;
@property(nonatomic, strong)TKOLocation * location;
@property(nonatomic, strong)TKOEmployee * employee;

-(id)initWithLocation:(TKOLocation *)loc;
-(void)showNoteList:(NSDictionary *)noteList;

@end
