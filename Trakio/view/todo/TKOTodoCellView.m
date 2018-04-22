//
//  TKOTodoCellView.m
//  Trakio
//
//  Created by yang wei on 07/03/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOTodoCellView.h"

@implementation TKOTodoCellView

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [TKOSystem homeViewBackgroundColor];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:14];
        
        self.checkLabel = [[UILabel alloc] init];
        self.checkLabel.backgroundColor = [UIColor whiteColor];
        [self.checkLabel setTextAlignment:NSTextAlignmentCenter];
        self.checkLabel.font = [UIFont fontWithName:@"FontAwesome" size:14];
        self.checkLabel.text = [NSString awesomeIcon:FaCheck];
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.checkLabel];
        
    }
    
    return self;
}

-(void)layoutSubviews {
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.checkLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkLabel
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkLabel
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkLabel
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:34.5]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.checkLabel
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self.checkLabel
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:0]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.titleLabel
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.titleLabel
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.titleLabel
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self.checkLabel
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.titleLabel
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self.checkLabel
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:0]];

}

@end
