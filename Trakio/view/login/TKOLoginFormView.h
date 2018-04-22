//
//  TKOLoginFormView.h
//  Trakio
//
//  Created by yang wei on 23/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOSystem.h"

@interface TKOLoginFormView : UIView 

@property(nonatomic, strong)UITextField * usernameField;
@property(nonatomic, strong)UIView * usernameLine;
@property(nonatomic, strong)UITextField * passwordField;
@property(nonatomic, strong)UIView * passwordLine;

-(id)init;

@end
