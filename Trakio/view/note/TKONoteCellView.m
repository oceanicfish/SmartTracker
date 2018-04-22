//
//  TKONoteCellView.m
//  Trakio
//
//  Created by yang wei on 08/03/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKONoteCellView.h"

@implementation TKONoteCellView

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
        self.titleLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:18];
        
        
//        self.contentLable = [[UILabel alloc] init];
//        self.contentLable.backgroundColor = [UIColor whiteColor];
//        self.contentLable.font = [UIFont fontWithName:@"OpenSans-Light" size:12];
//        self.contentLable.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1];
        
        self.checkLabel = [[UILabel alloc] init];
        self.checkLabel.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
        [self.checkLabel setTextAlignment:NSTextAlignmentCenter];
        self.checkLabel.font = [UIFont fontWithName:@"FontAwesome" size:20];
        self.checkLabel.textColor = [UIColor whiteColor];
        self.checkLabel.text = [NSString awesomeIcon:FaPencil];
        
        [self addSubview:self.titleLabel];
//        [self addSubview:self.contentLable];
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
                         constant:60]];
    
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
    
//    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
//    self.contentLable.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [self addConstraint:[NSLayoutConstraint
//                         constraintWithItem:self.contentLable
//                         attribute:NSLayoutAttributeTop
//                         relatedBy:0
//                         toItem:self.titleLabel
//                         attribute:NSLayoutAttributeBottom
//                         multiplier:1
//                         constant:0]];
//    
//    [self addConstraint:[NSLayoutConstraint
//                         constraintWithItem:self.contentLable
//                         attribute:NSLayoutAttributeLeft
//                         relatedBy:0
//                         toItem:self.titleLabel
//                         attribute:NSLayoutAttributeLeft
//                         multiplier:1
//                         constant:0]];
//    
//    [self addConstraint:[NSLayoutConstraint
//                         constraintWithItem:self.contentLable
//                         attribute:NSLayoutAttributeRight
//                         relatedBy:0
//                         toItem:self.checkLabel
//                         attribute:NSLayoutAttributeLeft
//                         multiplier:1
//                         constant:0]];
//    
//    [self addConstraint:[NSLayoutConstraint
//                         constraintWithItem:self.contentLable
//                         attribute:NSLayoutAttributeHeight
//                         relatedBy:0
//                         toItem:self
//                         attribute:NSLayoutAttributeHeight
//                         multiplier:0
//                         constant:25]];
    
}

@end
