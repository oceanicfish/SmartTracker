//
//  TKOTimeInCellView.m
//  Trakio
//
//  Created by yang wei on 02/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOTimeInCellView.h"

@implementation TKOTimeInCellView

@synthesize time;
@synthesize suffix;
@synthesize timeLabel;
@synthesize suffixLabel;

-(id)initWithTime:(NSString *)t Suffix:(FaIcon)s{
    if (self = [super init]) {
        
        extern NSMutableDictionary * dimension;
        
        self.time = t;
        self.suffix = s;
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.text = self.time;
        self.timeLabel.font = [UIFont fontWithName:@"OpenSans-Bold"
                    size:[[dimension objectForKey:@"TIME_LABEL_SIZE"] intValue]];
        [self.timeLabel setTextAlignment:NSTextAlignmentRight];
//        self.timeLabel.backgroundColor = [UIColor blueColor];
        
        self.suffixLabel = [[UILabel alloc] init];
        self.suffixLabel.font = [UIFont fontWithName:@"FontAwesome"
                    size:[[dimension objectForKey:@"SUFFIX_LABEL_SIZE"] intValue]];
        self.suffixLabel.text = [NSString stringWithFormat:@" %@",[NSString awesomeIcon:s]];
        [self.suffixLabel setTextAlignment:NSTextAlignmentLeft];
        
//        if (s == FaCircleO) {
//            self.suffixLabel.textColor = [UIColor greenColor];
//        }else if(s == FaSquare) {
//            self.suffixLabel.textColor = [UIColor yellowColor];
//        }else if(s == FaStar) {
//            self.suffixLabel.textColor = [UIColor redColor];
//        }
//        self.suffixLabel.backgroundColor = [UIColor redColor];
        
        
        [self addSubview:self.timeLabel];
        [self addSubview:self.suffixLabel];
    }
    
    return self;
}

-(void)layoutSubviews{
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.timeLabel
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.timeLabel
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.timeLabel
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.75
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.timeLabel
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:0]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.suffixLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.suffixLabel
                         attribute:NSLayoutAttributeBottom
                         relatedBy:0
                         toItem:self.timeLabel
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.suffixLabel
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self.timeLabel
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.suffixLabel
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.25
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.suffixLabel
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0.9
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
