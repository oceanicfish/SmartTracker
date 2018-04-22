//
//  TKOWelcomeView.m
//  Trakio
//
//  Created by yang wei on 01/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOWelcomeView.h"

@implementation TKOWelcomeView

@synthesize welcomeLabel;
//@synthesize avatarView;
@synthesize changeAvatar;
@synthesize avatar;
@synthesize employee;

-(id)initWithEmployee:(TKOEmployee *)emp {
    if (self = [super init]) {
        
        NSFileManager * fileManager = [[NSFileManager alloc] init];
        NSError *err = nil;
        NSURL * userPathURL = [fileManager URLForDirectory:NSApplicationSupportDirectory
                    inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
        self.userAvatarPathURL = [userPathURL URLByAppendingPathComponent:@"avatar.png"];
        
        extern NSMutableDictionary * dimension;
        
        self.employee = emp;
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.welcomeLabel = [[UILabel alloc] init];
        self.welcomeLabel.font = [UIFont fontWithName:@"Montserrat" size:[[dimension objectForKey:@"HELLO_USERNAME_SIZE"] intValue]];
        
        self.welcomeLabel.text = [NSString stringWithFormat:@"你好, %@!", self.employee.employeeFirstName];
        
        [self addSubview:self.welcomeLabel];
        
        if (self.employee.employeePhoto == nil || self.employee.employeePhoto.length == 0) {
            self.employee.employeePhoto = @"img-user.png";
            self.avatar = [UIImage imageNamed:self.employee.employeePhoto];
        }else {
            
            NSData * avatarData = [NSData dataWithContentsOfURL:self.userAvatarPathURL];
            self.avatar = [UIImage imageWithData:avatarData];
        }
        
        self.changeAvatar = [[UIButton alloc] init];
        [self.changeAvatar addTarget:self action:@selector(clickAvatar:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.changeAvatar];
        
    }
    
    return self;
}

-(void)clickAvatar:(UIButton *)button {
    NSLog(@"%@", @"avatar clicked");
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Trakio" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Take photo", @"Choose from library", nil];
    [alertView show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog([NSString stringWithFormat:@"%d", buttonIndex]);
    [self takePhoto:buttonIndex];
}

-(void)takePhoto:(NSInteger *)buttonIndex {
    UIImagePickerController * pickerCtrl = [[UIImagePickerController alloc] init];
    pickerCtrl.delegate = self;
    pickerCtrl.allowsEditing = YES;
    
    //to check which PickerControllerSource type is available.
    if (buttonIndex == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
    }else if(buttonIndex == 2) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            pickerCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
    }
//    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        pickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
//    } else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
//        pickerCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    } else {
//        pickerCtrl.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    }
    
//    [self.window.rootViewController presentModalViewController:pickerCtrl animated:YES];
    [self.window.rootViewController presentViewController:pickerCtrl animated:YES completion:nil];
}

///*
// 选取成功后在界面上进行显示
// */
//-(void)editedImage:(UIImage *)image
//{
////    NSLog(@"选择成功");
//    [self.changeAvatar.imageView setImage:image];
//    
//}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSData * avatarData = UIImagePNGRepresentation(chosenImage);
    NSString * userAvatarPathString = [self.userAvatarPathURL absoluteString];
    
    TKOPerference * perference = [TKOPerference getPerference];
    [perference.tkoSettings setValue:userAvatarPathString forKey:@"TRAKIO_USER_AVATAR_PATH"];
    [perference savePerference];
    
    [avatarData writeToURL:self.userAvatarPathURL atomically:YES];
    
    self.avatar = chosenImage;
    [self.changeAvatar setImage:self.avatar forState:UIControlStateNormal];
    [self.changeAvatar setImage:self.avatar forState:UIControlStateSelected];
    
    [self uploadPhoto];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)layoutSubviews {
    
    extern NSMutableDictionary * dimension;
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.welcomeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.welcomeLabel
                         attribute:NSLayoutAttributeCenterX
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeCenterX
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.welcomeLabel
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:5]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.changeAvatar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.changeAvatar
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.welcomeLabel
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:3]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.changeAvatar
                         attribute:NSLayoutAttributeCenterX
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeCenterX
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.changeAvatar
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:[[dimension objectForKey:@"AVATAR_IMAGE_SIZE"] intValue]]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.changeAvatar
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self.changeAvatar
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    //set avatarView round corner
//    CGFloat w = self.superview.frame.size.width;
    self.changeAvatar.imageView.layer.cornerRadius = [[dimension objectForKey:@"AVATAR_IMAGE_SIZE"] intValue] / 2.0;
    [self.changeAvatar setImage:self.avatar forState:UIControlStateNormal];
    [self.changeAvatar setImage:self.avatar forState:UIControlStateSelected];
    [self.changeAvatar setAdjustsImageWhenHighlighted:NO];
    [self.changeAvatar.imageView setContentMode:UIViewContentModeScaleAspectFit];
    self.changeAvatar.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.changeAvatar.imageView.layer.masksToBounds = YES;
    [self.changeAvatar.imageView.layer setBorderWidth:5];
    
    CGColorSpaceRef rgbColorRef = CGColorSpaceCreateDeviceRGB();
    CGFloat rgbVaues[] = {75.0/255.0, 174.0/255.0 , 81.0/255.0, 1.0};
    CGColorRef borderColor = CGColorCreate(rgbColorRef, rgbVaues);
    [self.changeAvatar.imageView.layer setBorderColor:borderColor];
}

-(void)uploadPhoto {
    
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    NSString * ServerURL = [TKOSystem getAPIUrl];
    NSString * uploadUrlStr = [ServerURL stringByAppendingString:@"users/upload-avatar?token=%@"];
    NSString * uploadUrlString = [NSString stringWithFormat:uploadUrlStr, self.employee.employeeToken];
    NSURL * uploadUrl = [NSURL URLWithString:uploadUrlString];
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"token"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", self.employee.employeeToken] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(self.avatar, 1.0);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"avatar.png\"\r\n", @"photo"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/png \r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:uploadUrl];
    
    NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setAllowsCellularAccess:YES];

    NSURLSession * session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSURLSessionUploadTask * uploadTask = [session
                                           uploadTaskWithRequest:request fromData:nil
    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
            NSLog(@"%ld", httpResponse.statusCode);
        
            NSString * responseJson = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog(@"Data = %@",responseJson);
    }];
//
    [uploadTask resume];
    
}

@end
