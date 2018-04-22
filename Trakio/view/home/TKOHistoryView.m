//
//  TKOHistoryView.m
//  Trakio
//
//  Created by yang wei on 02/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOHistoryView.h"

@implementation TKOHistoryView

@synthesize weekdayView;
@synthesize startTimeView;
@synthesize endTimeView;
@synthesize durationView;
@synthesize separatorView;
@synthesize separated;

-(id)initWithWeekday:(NSString *)wd Date:(NSString *)dt
           StartTime:(NSString *)st StartTimeSuffix:(FaIcon)sts
             EndTime:(NSString *)et EndTimeSuffix:(FaIcon)ets
            Duration:(NSString *)dr Separator:(BOOL)sep {
    
    if (self = [super init]) {
        self.weekdayView = [[TKOWeekdayInCellView alloc] initWithWeekday:wd Date:dt];
        self.startTimeView = [[TKOTimeInCellView alloc] initWithTime:st Suffix:sts];
//        self.startTimeView.backgroundColor = [UIColor orangeColor];
        self.endTimeView = [[TKOTimeInCellView alloc] initWithTime:et Suffix:ets];
        self.durationView = [[TKOTimeInCellView alloc] initWithTime:dr Suffix:FaCheck];
        self.separatorView = [[UIView alloc] init];
        self.separatorView.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
        self.separated = sep;
        
        [self addSubview:self.weekdayView];
        [self addSubview:self.startTimeView];
        [self addSubview:self.endTimeView];
        [self addSubview:self.durationView];
        [self addSubview:self.separatorView];
        
        UIColor * backgroundColor = [TKOSystem homeViewBackgroundColor];
        [self setBackgroundColor:backgroundColor];
        
//        UIColor * historyColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
//        self.backgroundColor = historyColor;
    }
    
    return self;
}

-(void)layoutSubviews {
    
    int h = 0;
    if (separated) {
        h = -0.5;
    }
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.weekdayView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.weekdayView
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.weekdayView
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.weekdayView
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.25
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.weekdayView
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:h]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.startTimeView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.startTimeView
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.startTimeView
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self.weekdayView
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.startTimeView
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.25
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.startTimeView
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:h]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.endTimeView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.endTimeView
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.endTimeView
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self.startTimeView
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.endTimeView
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.25
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.endTimeView
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:h]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.durationView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.durationView
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.durationView
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self.endTimeView
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.durationView
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.25
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.durationView
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:h]];
    
    if (separated) {
        // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
        self.separatorView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.separatorView
                             attribute:NSLayoutAttributeBottom
                             relatedBy:0
                             toItem:self
                             attribute:NSLayoutAttributeBottom
                             multiplier:1
                             constant:0]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.separatorView
                             attribute:NSLayoutAttributeLeft
                             relatedBy:0
                             toItem:self
                             attribute:NSLayoutAttributeLeft
                             multiplier:1
                             constant:0]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.separatorView
                             attribute:NSLayoutAttributeWidth
                             relatedBy:0
                             toItem:self
                             attribute:NSLayoutAttributeWidth
                             multiplier:1
                             constant:0]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.separatorView
                             attribute:NSLayoutAttributeHeight
                             relatedBy:0
                             toItem:self
                             attribute:NSLayoutAttributeHeight
                             multiplier:0
                             constant:0.5]];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
