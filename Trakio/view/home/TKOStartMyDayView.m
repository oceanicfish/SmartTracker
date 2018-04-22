//
//  TKOStartMyDayView.m
//  Trakio
//
//  Created by yang wei on 02/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOStartMyDayView.h"

@implementation TKOStartMyDayView

-(void)layoutSubviews{
    
    self.startMyDayButton = [[UIView alloc] init];
    UILabel * startMyDayLabel = [[UILabel alloc] init];
    startMyDayLabel.text = @"开 始 工 作";
    [startMyDayLabel setTextAlignment:NSTextAlignmentCenter];
    startMyDayLabel.backgroundColor = [UIColor
                                       colorWithRed:75.0/255.0 green:174.0/255.0
                                       blue:81.0/255.0 alpha:1.0];
    
    [self.startMyDayButton addSubview:startMyDayLabel];
    
    [self addSubview:self.startMyDayButton];
    
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.startMyDayButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.startMyDayButton
                         attribute:NSLayoutAttributeCenterX
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeCenterX
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.startMyDayButton
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.startMyDayButton
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:-20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.startMyDayButton
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:-20]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
