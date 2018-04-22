//
//  TKOTopBar.m
//  Trakio
//
//  Created by yang wei on 01/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOTopBar.h"

int const _LOGO_IMAGE_HEIGHT = 30;
int const _MENU_NOTICE_LABEL_SIZE = 20;

@implementation TKOTopBar

-(void)layoutSubviews {
    
    self.menuLabel = [[UILabel alloc] init];
    self.menuLabel.font = [UIFont fontWithName:@"FontAwesome" size:_MENU_NOTICE_LABEL_SIZE];
    self.menuLabel.text =  [NSString awesomeIcon:FaBars];
    
    self.noticeLabel = [[UILabel alloc] init];
    self.noticeLabel.font = [UIFont fontWithName:@"FontAwesome" size:_MENU_NOTICE_LABEL_SIZE];
    self.noticeLabel.text = [NSString awesomeIcon:FaEnvelopeO];
    self.noticeLabel.textColor = [UIColor lightGrayColor];
    
    UIImage * logoImage = [UIImage imageNamed:@"logo_banner.png"];
    self.logoImageView = [[UIImageView alloc] initWithImage:logoImage];
//    self.logoImageView.frame = CGRectMake(50, 50, 123, 40);
    [self.logoImageView setContentMode:UIViewContentModeScaleAspectFit];
//    self.logoImageView.backgroundColor = [UIColor grayColor];
//    self.logoImageView.clipsToBounds = YES;
    
//    self.logoImageView.contentMode = UIViewContentModeCenter;
    
    self.separatorView = [[UIView alloc] init];
    
    [self addSubview:self.logoImageView];
    [self addSubview:self.menuLabel];
    [self addSubview:self.noticeLabel];
    [self addSubview:self.separatorView];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.logoImageView
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.logoImageView
                         attribute:NSLayoutAttributeCenterX
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeCenterX
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.logoImageView
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:_LOGO_IMAGE_HEIGHT]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.menuLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.menuLabel
                         attribute:NSLayoutAttributeBottom
                         relatedBy:0
                         toItem:self.logoImageView
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.menuLabel
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.menuLabel
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0
                         constant:_MENU_NOTICE_LABEL_SIZE]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.menuLabel
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:_MENU_NOTICE_LABEL_SIZE]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.noticeLabel.translatesAutoresizingMaskIntoConstraints = NO
    ;
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noticeLabel
                         attribute:NSLayoutAttributeBottom
                         relatedBy:0
                         toItem:self.logoImageView
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noticeLabel
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:-20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noticeLabel
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0
                         constant:_MENU_NOTICE_LABEL_SIZE]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.noticeLabel
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:_MENU_NOTICE_LABEL_SIZE]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.separatorView.translatesAutoresizingMaskIntoConstraints = NO
    ;
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.separatorView
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.logoImageView
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
                         constant:20]];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
