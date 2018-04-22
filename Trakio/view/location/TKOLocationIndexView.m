//
//  TKOLocationIndexView.m
//  Trakio
//
//  Created by yang wei on 03/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOLocationIndexView.h"

@implementation TKOLocationIndexView

-(id)initWithIndexNumber:(NSString *)number {
    if (self = [super init]) {
        self.indexNumber = number;
        
        self.indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, self.frame.size.height)];
        UIColor * trakioGreen = [TKOSystem trakioGreenColor];
        self.indexLabel.backgroundColor = trakioGreen;
        self.indexLabel.text = self.indexNumber;
        self.indexLabel.textColor = [UIColor whiteColor];
        self.indexLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
        [self.indexLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self addSubview:self.indexLabel];
        
    }
    
    return self;
}

-(void)layoutSubviews {
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.indexLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.indexLabel
                         attribute:NSLayoutAttributeCenterX
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeCenterX
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.indexLabel
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.indexLabel
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:-10]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.indexLabel
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:-10]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
