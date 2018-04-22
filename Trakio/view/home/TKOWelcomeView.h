//
//  TKOWelcomeView.h
//  Trakio
//
//  Created by yang wei on 01/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOPerference.h"
#import "TKOEmployee.h"
#import "TKOSystem.h"

@interface TKOWelcomeView : UIView <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>

@property(nonatomic, strong)UILabel * welcomeLabel;
//@property(nonatomic, strong)UIImageView * avatarView;
@property(nonatomic, strong)UIButton * changeAvatar;
@property(nonatomic, strong)UIImage * avatar;
@property(nonatomic, strong)NSURL * userAvatarPathURL;
@property(nonatomic, strong)TKOEmployee * employee;

-(id)initWithEmployee:(TKOEmployee *)emp;

-(void)uploadPhoto;
-(void)takePhoto:(NSInteger *)buttonIndex;

@end
