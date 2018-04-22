//
//  TKOLocationCellViewTableViewCell.m
//  Trakio
//
//  Created by yang wei on 04/03/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOLocationCellView.h"

@implementation TKOLocationCellView

@synthesize name;
@synthesize address;
@synthesize number;
@synthesize status;

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
        
        self.numberLabel = [[UILabel alloc] init];
        self.numberLabel.backgroundColor = [TKOSystem trakioGreenColor];
        self.numberLabel.textColor = [UIColor whiteColor];
        [self.numberLabel setTextAlignment:NSTextAlignmentCenter];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.backgroundColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:14];
        
        
        self.addressLabel = [[UILabel alloc] init];
        self.addressLabel.backgroundColor = [UIColor whiteColor];
        self.addressLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:10];
        
        self.statusLable = [[UILabel alloc] init];
        self.statusLable.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
        self.statusLable.textColor = [UIColor whiteColor];
        [self.statusLable setTextAlignment:NSTextAlignmentCenter];
        self.statusLable.font = [UIFont fontWithName:@"FontAwesome" size:30];
        
        [self addSubview:self.numberLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.addressLabel];
        [self addSubview:self.statusLable];
        
        
    }
    
    return self;
}

-(void)layoutSubviews {
    
    NSLog(@"cell layout subviews");
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.numberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.numberLabel
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:5]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.numberLabel
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:5]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.numberLabel
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0
                         constant:40]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.numberLabel
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:40]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.statusLable.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.statusLable
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:5]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.statusLable
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:-5]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.statusLable
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0
                         constant:40]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.statusLable
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:40]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.nameLabel
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.numberLabel
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.nameLabel
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self.numberLabel
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.nameLabel
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self.statusLable
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.nameLabel
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:25]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.addressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.addressLabel
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.nameLabel
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.addressLabel
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self.numberLabel
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.addressLabel
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self.statusLable
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.addressLabel
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:15]];
    
    
}

@end
