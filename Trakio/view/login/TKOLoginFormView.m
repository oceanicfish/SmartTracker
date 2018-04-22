//
//  TKOLoginFormView.m
//  Trakio
//
//  Created by yang wei on 23/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOLoginFormView.h"

@implementation TKOLoginFormView

@synthesize usernameField;
@synthesize passwordField;

-(id)init {
    if (self = [super init]) {
        NSLog(@"start init...");
        self.usernameField = [[UITextField alloc] init];
        self.usernameField.placeholder = @"Username";
        self.usernameField.textColor = [UIColor blackColor];
        self.usernameField.textAlignment = NSTextAlignmentCenter;
        self.usernameField.font = [UIFont fontWithName:@"OpenSans-Light" size:16];
        //    self.backgroundColor = [UIColor whiteColor];
        self.usernameField.borderStyle = UITextBorderStyleNone;
        [self.usernameField setReturnKeyType:UIReturnKeyDone];
        [self addSubview:self.usernameField];
        
        self.passwordField = [[UITextField alloc] init];
        self.passwordField.placeholder = @"Password";
        self.passwordField.textColor = [UIColor blackColor];
        self.passwordField.textAlignment = NSTextAlignmentCenter;
        self.passwordField.font = [UIFont fontWithName:@"OpenSans-Light" size:16];
        //    self.backgroundColor = [UIColor whiteColor];
        self.passwordField.borderStyle = UITextBorderStyleNone;
        [self.passwordField setReturnKeyType:UIReturnKeyDone];
        [self addSubview:self.passwordField];
        
        self.usernameLine = [[UIView alloc] init];
        self.usernameLine.backgroundColor = [TKOSystem trakioGreenColor];
        [self addSubview:self.usernameLine];
        
        self.passwordLine = [[UIView alloc] init];
        self.passwordLine.backgroundColor = [TKOSystem trakioGreenColor];
        [self addSubview:self.passwordLine];
        NSLog(@"end init...");
    }
    
    return self;
}

-(void)layoutSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    
//    self.usernameField = [[UITextField alloc] init];
//    self.usernameField.placeholder = @"Username";
//    self.usernameField.textColor = [UIColor blackColor];
//    self.usernameField.textAlignment = NSTextAlignmentCenter;
//    self.usernameField.font = [UIFont fontWithName:@"OpenSans-Light" size:16];
////    self.backgroundColor = [UIColor whiteColor];
//    self.usernameField.borderStyle = UITextBorderStyleNone;
//    [self.usernameField setReturnKeyType:UIReturnKeyDone];
//    [self addSubview:self.usernameField];
//    
//    self.passwordField = [[UITextField alloc] init];
//    self.passwordField.placeholder = @"Password";
//    self.passwordField.textColor = [UIColor blackColor];
//    self.passwordField.textAlignment = NSTextAlignmentCenter;
//    self.passwordField.font = [UIFont fontWithName:@"OpenSans-Light" size:16];
////    self.backgroundColor = [UIColor whiteColor];
//    self.passwordField.borderStyle = UITextBorderStyleNone;
//    [self.passwordField setReturnKeyType:UIReturnKeyDone];
//    [self addSubview:self.passwordField];
//    
//    self.usernameLine = [[UIView alloc] init];
//    self.usernameLine.backgroundColor = [TKOSystem trakioGreenColor];
//    [self addSubview:self.usernameLine];
//    
//    self.passwordLine = [[UIView alloc] init];
//    self.passwordLine.backgroundColor = [TKOSystem trakioGreenColor];
//    [self addSubview:self.passwordLine];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.usernameField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.usernameField
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.usernameField
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.usernameField
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.usernameField
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0
                         constant:35]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.usernameLine.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.usernameLine
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.usernameField
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.usernameLine
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.usernameLine
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.usernameLine
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:1]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.passwordField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.passwordField
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.usernameLine
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:10]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.passwordField
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.passwordField
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.passwordField
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:35]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.passwordLine.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.passwordLine
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.passwordField
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.passwordLine
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.passwordLine
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.passwordLine
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:1]];
}


@end
