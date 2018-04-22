//
//  TKOLoginView.h
//  Trakio
//
//  Created by yang wei on 17/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "TKOLoginFormView.h"
#import "TKOEmployee.h"
#import "TKOSystem.h"

@class TKOHomeView;

@interface TKOLoginView : UIView <UITextFieldDelegate>

@property(nonatomic, strong)UIImageView * logoImageView;
//@property(nonatomic, strong)UITextField * usernameField;
//@property(nonatomic, strong)UITextField * passwordField;
@property(nonatomic, strong)UIButton * loginButton;
@property(nonatomic, strong)TKOLoginFormView * loginForm;
@property(nonatomic, strong)UIView * maskView;
@property(nonatomic, strong)UIActivityIndicatorView * activityView;
@property(nonatomic, strong)TKOEmployee * employee;

-(id)init;

-(void)layoutWithoutKeyboard;
-(void)layoutWithKeyboard;

-(void)goHomeView:(TKOEmployee *)employee;
-(void)showAlertView:(NSString *)message;

@end
