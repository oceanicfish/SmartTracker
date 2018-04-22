//
//  TKOHistoryColumnView.m
//  Trakio
//
//  Created by yang wei on 03/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOHistoryColumnView.h"

@implementation TKOHistoryColumnView

-(id)initWithIcon:(FaIcon)i Text:(NSString *)t {
    if (self = [super init]) {
        
        self.Icon = [[UILabel alloc] init];
        self.Icon.font = [UIFont fontWithName:@"FontAwesome" size:12];
        self.Icon.text =  [NSString awesomeIcon:i];
        [self.Icon setTextAlignment:NSTextAlignmentRight];
        [self addSubview:self.Icon];
        
        self.Text = [[UILabel alloc] init];
        self.Text.font = [UIFont fontWithName:@"OpenSans-Light" size:12];
        self.Text.text = t;
        [self.Text setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.Text];
    }
    
    return self;
}

-(void)layoutSubviews {
    
    //FIRST CHECKIN ICON // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.Icon.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.Icon
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:2]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.Icon
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.Icon
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.35
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.Icon
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:0]];
    
    //FIRST CHECKIN TEXT // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.Text.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.Text
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:2]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.Text
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self.Icon
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.Text
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.65
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.Text
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:0]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
