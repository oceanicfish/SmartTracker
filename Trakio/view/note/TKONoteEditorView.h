//
//  TKONoteEditorView.h
//  Trakio
//
//  Created by yang wei on 05/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOTopBar.h"
#import "TKOSystem.h"
#import "TKOEmployee.h"
#import "TKOLocation.h"
#import "TKOTopBar.h"
#import "NSString+FontAwesome.h"

@class TKOCheckInView;

@interface TKONoteEditorView : UIView <UITextViewDelegate>

@property(nonatomic, strong)UIView * topMargin;
@property(nonatomic, strong)TKOTopBar * topBar;
@property(nonatomic, strong)UITextView * noteText;
@property(nonatomic, strong)UIButton * backButton;
@property(nonatomic, strong)UIButton * saveButton;
@property(nonatomic, strong)NSString * note;
@property(nonatomic, strong)TKOEmployee * employee;
@property(nonatomic, strong)TKOLocation * location;

-(id)initWithLocation:(TKOLocation *)loc;

-(void)backToNoteView:(TKOLocation *)location;

@end
