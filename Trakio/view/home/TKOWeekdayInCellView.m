//
//  TKOWeekdayInCellView.m
//  Trakio
//
//  Created by yang wei on 02/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOWeekdayInCellView.h"

@implementation TKOWeekdayInCellView

@synthesize weekday;
@synthesize date;
@synthesize weekdayLabel;
@synthesize dateLabel;

-(id)initWithWeekday:(NSString *)wd Date:(NSString *)dt{
    
    if (self = [super init]) {
        
        extern NSMutableDictionary * dimension;
        
        self.weekday = wd;
        self.date = dt;
        
        self.weekdayLabel = [[UILabel alloc] init];
        self.weekdayLabel.text = self.weekday;
        self.weekdayLabel.font = [UIFont fontWithName:@"OpenSans-Bold"
                        size:[[dimension objectForKey:@"WEEKDAY_LABEL_SIZE"] intValue]];
        [self.weekdayLabel setTextAlignment:NSTextAlignmentCenter];
        
//        self.weekdayLabel.backgroundColor = [UIColor orangeColor];
        
        self.dateLabel = [[UILabel alloc] init];
        self.dateLabel.text = self.date;
        self.dateLabel.font = [UIFont fontWithName:@"OpenSans-Light"
                        size:[[dimension objectForKey:@"DATE_LABEL_SIZE"] intValue]];
        [self.dateLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self addSubview:self.weekdayLabel];
        [self addSubview:self.dateLabel];
        
    }
    
    return self;
}

-(void)layoutSubviews{
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.weekdayLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.weekdayLabel
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:10]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.weekdayLabel
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.weekdayLabel
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.weekdayLabel
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:20]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.dateLabel
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.weekdayLabel
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.dateLabel
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.dateLabel
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
//    [self addConstraint:[NSLayoutConstraint
//                         constraintWithItem:self.dateLabel
//                         attribute:NSLayoutAttributeHeight
//                         relatedBy:0
//                         toItem:self
//                         attribute:NSLayoutAttributeHeight
//                         multiplier:0.35
//                         constant:0]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
