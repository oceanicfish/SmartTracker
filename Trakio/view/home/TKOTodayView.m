//
//  TKOTodayView.m
//  Trakio
//
//  Created by yang wei on 02/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOTodayView.h"

@implementation TKOTodayView

-(void)layoutSubviews {
    
    extern NSMutableDictionary * dimension;
    
    self.todayLabel = [[UILabel alloc] init];
    self.todayLabel.text = @"今天是 ";
    self.todayLabel.font = [UIFont fontWithName:@"OpenSans-Light"
                size:[[dimension objectForKey:@"TODAY_IS_FONT_SIZE"] intValue]];
    [self.todayLabel setTextAlignment:NSTextAlignmentRight];
//    self.todayLabel.backgroundColor = [UIColor orangeColor];
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.text = @" 2016年10月25日 星期二";
    self.dateLabel.font = [UIFont fontWithName:@"OpenSans-Bold"
                size:[[dimension objectForKey:@"TODAY_DATE_FONT_SIZE"] intValue]];
    [self.dateLabel setTextAlignment:NSTextAlignmentLeft];
//    self.dateLabel.backgroundColor = [UIColor blueColor];
    
    self.textView = [[UIView alloc] init];
    [self.textView setContentMode:UIViewContentModeScaleAspectFill];
    self.textView.backgroundColor = [UIColor orangeColor];
    self.textView.frame = CGRectMake(0, 0, 300, 40);
    
//    [self.textView addSubview:self.todayLabel];
//    [self.textView addSubview:self.dateLabel];
    [self addSubview:self.todayLabel];
    [self addSubview:self.dateLabel];
    
//    [self addSubview:self.textView];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.todayLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todayLabel
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todayLabel
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todayLabel
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.35
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todayLabel
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:0]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.dateLabel
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.dateLabel
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.dateLabel
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.65
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.dateLabel
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
