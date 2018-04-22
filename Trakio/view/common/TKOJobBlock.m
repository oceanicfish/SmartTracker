//
//  TKOJobBlock.m
//  Trakio
//
//  Created by yang wei on 04/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOJobBlock.h"

@implementation TKOJobBlock

@synthesize blockTitle;
@synthesize blockIcon;
@synthesize actionView;
@synthesize lat;
@synthesize lng;

-(id)initWithTitle:(NSString *)t Icon:(FaIcon)i ActionView:(UIView *)av {
    if (self = [super init]) {
        
        /**
         * setting LocationManager (for user's location)
         */
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
        
        self.actionView = av;
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.blockTitle = [[UIButton alloc] init];
        [self.blockTitle setTitle:t forState:UIControlStateNormal];
        [self.blockTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.blockTitle.titleLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:18];
        self.blockTitle.backgroundColor = [UIColor whiteColor];
        [self.blockTitle.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.blockTitle setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self.blockTitle addTarget:self action:@selector(clickBlock:)
                  forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.blockTitle];
        
        self.blockIcon = [[UIButton alloc] init];
        
        [self.blockIcon setTitle:[NSString awesomeIcon:i] forState:UIControlStateNormal];
        [self.blockIcon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.blockIcon.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:20];
        self.blockIcon.backgroundColor = [TKOSystem trakioGreenColor];
        [self.blockIcon.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.blockIcon addTarget:self action:@selector(clickBlock:)
                  forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.blockIcon];
        
    }
    
    return self;
}

-(void)clickBlock:(UIButton *)button{
    
    NSString * buttonText =  button.titleLabel.text;
    
    if ([buttonText  isEqual: @"Snap Photos"]) {
        
        [self takePhoto];
    } else {
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.3];
        [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionFromRight];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        [[self.actionView layer]addAnimation:animation forKey:@"viewAnimation"];
        
        [self.window.rootViewController.view addSubview:self.actionView];
    }

}

-(void)takePhoto {
    
    UIImagePickerController * pickerCtrl = [[UIImagePickerController alloc] init];
    pickerCtrl.delegate = self;
    pickerCtrl.allowsEditing = YES;
    
    //to check which PickerControllerSource type is available.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        pickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        pickerCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        pickerCtrl.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    //    [self.window.rootViewController presentModalViewController:pickerCtrl animated:YES];
    [self.window.rootViewController presentViewController:pickerCtrl animated:YES completion:nil];
}


#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSLog(@"trakio uploaded photo: %@", chosenImage.description);
    // upload image
    [self uploadPhoto:chosenImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)uploadPhoto:(UIImage *)photo {
    
    extern TKOEmployee * myself;
    self.employee = myself;
    
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    NSString * ServerURL = [TKOSystem getAPIUrl];
    NSString * snapPhotoUrlStr = [ServerURL stringByAppendingString:@"checkin-notes?token=%@"];
    NSString * uploadUrlString = [NSString stringWithFormat:snapPhotoUrlStr, self.employee.employeeToken];
    NSURL * uploadUrl = [NSURL URLWithString:uploadUrlString];
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"check_in_id"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", self.employee.checkInID] dataUsingEncoding:NSUTF8StringEncoding]];

    NSLog(@"lat:%@; lng:%@", self.lat, self.lng);
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"location_lat"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", self.lat] dataUsingEncoding:NSUTF8StringEncoding]];

    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"location_lng"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", self.lng] dataUsingEncoding:NSUTF8StringEncoding]];


    // add image data
    NSData *imageData = UIImageJPEGRepresentation(photo, 1.0);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"upload.png\"\r\n", @"photo"] dataUsingEncoding:NSUTF8StringEncoding]];
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
                                               
                                               [self performSelectorOnMainThread:@selector(showAlertView:) withObject:@"Photo uploaded." waitUntilDone:NO];
                                           }];
    //
    [uploadTask resume];
    
}

/** location update
 *
 * log coordinate everytime location updated
 * for everytime of uploading photo, it's should be the updated location
 */
-(void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation * location = locations.lastObject;
    self.lat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    self.lng = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    NSLog(@"latitude: %@, longitude: %@", self.lat, self.lng);
    
    /**
     * keeping tracking user's location will lead very fast power consumption
     * of user's cellphone
     */
    [self.locationManager stopUpdatingLocation];
}


-(void)showAlertView:(NSString *)message {
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Trakio" message:message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [alertView show];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)layoutSubviews{
    
    //FIRST CHECKIN ICON // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.blockTitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.blockTitle
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.blockTitle
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:10]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.blockTitle
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:-[TKOSystem jobBlockHeight]]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.blockTitle
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:0]];
    
    //FIRST CHECKIN TEXT // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.blockIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.blockIcon
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.blockIcon
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.blockIcon
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0
                         constant:[TKOSystem jobBlockHeight]]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.blockIcon
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:[TKOSystem jobBlockHeight]]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
