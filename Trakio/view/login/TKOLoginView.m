//
//  TKOLoginView.m
//  Trakio
//
//  Created by yang wei on 17/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOLoginView.h"
#import "TKOPerference.h"
#import "TKOHomeView.h"

@implementation TKOLoginView {
    int offsize_;
    NSString * token_;
}

@synthesize loginForm;
@synthesize maskView;
@synthesize logoImageView;
@synthesize loginButton;

-(id)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.logoImageView = [[UIImageView alloc] init];
        self.logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-login.png"]];
        [self.logoImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.logoImageView];
        
        self.loginForm = [[TKOLoginFormView alloc] init];
        [self addSubview:self.loginForm];
        
        [self.loginForm.usernameField setDelegate:self];
        [self.loginForm.passwordField setDelegate:self];
        
        self.loginButton = [[UIButton alloc] init];
        [self.loginButton setTitle:@"Let's Start" forState:UIControlStateNormal];
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.loginButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.loginButton.titleLabel.font = [UIFont fontWithName:@"Montserrat" size:16];
        self.loginButton.backgroundColor = [UIColor orangeColor];
        [self.loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.loginButton];
        
        self.maskView = [[UIView alloc] init];
        self.maskView.backgroundColor = [UIColor whiteColor];
        [self addSubview:maskView];
        
        extern NSMutableDictionary * dimension;
        
        offsize_ = [[dimension objectForKey:@"LOGIN_LOGO_OFFSIZE"] intValue];

    }
    
    return self;
    
}

-(void)layoutSubviews {
    
//    [super layoutSubviews];
    
    NSLog(@"enter Login view");
    
    [self removeConstraints:self.constraints];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.maskView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.maskView
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.maskView
                         attribute:NSLayoutAttributeCenterX
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeCenterX
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.maskView
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.maskView
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:25]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.logoImageView
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.maskView
                         attribute:NSLayoutAttributeBottom
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
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.6
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.logoImageView
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.6
                         constant:0]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.loginForm.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.loginForm
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.logoImageView
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:10]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.loginForm
                         attribute:NSLayoutAttributeCenterX
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeCenterX
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.loginForm
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0.8
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.loginForm
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:0
                         constant:82]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.loginButton
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.loginForm
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.loginButton
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self.loginForm
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.loginButton
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self.loginForm
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.loginButton
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self.loginForm
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:50]];
    
}

-(void)layoutWithoutKeyboard {
    [UIView animateWithDuration:0.3f animations:^{
        
        self.logoImageView.frame = CGRectMake(
                                              self.logoImageView.frame.origin.x,
                                              self.logoImageView.frame.origin.y + offsize_,
                                              self.logoImageView.frame.size.width,
                                              self.logoImageView.frame.size.height);
        
        self.loginForm.frame = CGRectMake(
                                          self.loginForm.frame.origin.x,
                                          self.loginForm.frame.origin.y + offsize_,
                                          self.loginForm.frame.size.width,
                                          self.loginForm.frame.size.height);
        
        self.loginButton.frame = CGRectMake(
                                            self.loginButton.frame.origin.x,
                                            self.loginButton.frame.origin.y + offsize_,
                                            self.loginButton.frame.size.width,
                                            self.loginButton.frame.size.height);
        
    }];
}

-(void)layoutWithKeyboard {
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.logoImageView.frame = CGRectMake(
                                              self.logoImageView.frame.origin.x,
                                              self.logoImageView.frame.origin.y - offsize_,
                                              self.logoImageView.frame.size.width,
                                              self.logoImageView.frame.size.height);
        
        self.loginForm.frame = CGRectMake(
                                              self.loginForm.frame.origin.x,
                                              self.loginForm.frame.origin.y - offsize_,
                                              self.loginForm.frame.size.width,
                                              self.loginForm.frame.size.height);
        
        self.loginButton.frame = CGRectMake(
                                              self.loginButton.frame.origin.x,
                                              self.loginButton.frame.origin.y - offsize_,
                                              self.loginButton.frame.size.width,
                                              self.loginButton.frame.size.height);
        
    }];
 }

-(void)login:(UIButton *)button {
    
    /*
     * hide the keyboard
     */
    [self.loginForm.usernameField resignFirstResponder];
    [self.loginForm.passwordField resignFirstResponder];
    [self layoutWithoutKeyboard];
    
    /*
     * show loading view when the network activity is launched
     */
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.frame = self.frame;
    self.activityView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.50];
    self.activityView.center = self.center;
    self.activityView.hidesWhenStopped = YES;
    self.activityView.hidden = NO;
    [self addSubview:self.activityView];
    [self insertSubview:self.activityView aboveSubview:self.maskView];
    [self.activityView startAnimating];
    [self layoutSubviews];
    
    /*
     * start the network activity
     */
    NSString * ServerURL = [TKOSystem getAPIUrl];
    NSString * authUrlStr = [ServerURL stringByAppendingString:@"auth"];
    NSURL * authUrl = [NSURL URLWithString:authUrlStr];
    NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setAllowsCellularAccess:YES];
    
    NSURLSession * session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:authUrl];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSString * username = self.loginForm.usernameField.text;
    NSString * password = self.loginForm.passwordField.text;
    
    NSMutableDictionary * user = [[NSMutableDictionary alloc] initWithCapacity:2];
    [user setObject:username forKey:@"username"];
    [user setObject:password forKey:@"password"];
    
    NSMutableDictionary * login = [[NSMutableDictionary alloc] initWithCapacity:1];
    [login setObject:user forKey:@"user"];
    
    NSError * error;
    NSData * data = [NSJSONSerialization dataWithJSONObject:login options:kNilOptions error: &error];
    NSString * requestJson = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    NSLog(@"Data = %@",requestJson);
    
    if (!error) {
        NSURLSessionUploadTask * postTask = [session uploadTaskWithRequest:request fromData:data
                    completionHandler:^(NSData * _Nullable data,
                                        NSURLResponse * _Nullable response,
                                        NSError * _Nullable error) {
                        
                        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
                        NSLog(@"%d", httpResponse.statusCode);
                        
                        if (httpResponse.statusCode == 401) {
                            
                            [self performSelectorOnMainThread:@selector(showAlertView:) withObject:@"Username/Password incorrect" waitUntilDone:NO];
                            
                            NSLog(@"username/password not correct");
                        }else if (httpResponse.statusCode == 200) {
                 
                            NSString * responseJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                            NSLog(responseJson);
                            NSLog(@"login successful");
                            NSDictionary* jsonDcit = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:kNilOptions
                                                                                   error:&error];
                            NSLog(@"user id : %@", [[jsonDcit objectForKey:@"data"] objectForKey:@"id"]);
                            NSLog(@"token : %@", [[jsonDcit objectForKey:@"meta"] objectForKey:@"token"]);
                            
                            NSString * userID = [[jsonDcit objectForKey:@"data"] objectForKey:@"id"];
//                            NSString * userToken = [jsonDcit objectForKey:@"token"];
                            NSString * userToken = [[jsonDcit objectForKey:@"meta"] objectForKey:@"token"];
                            NSString * userFirstName = [[[jsonDcit objectForKey:@"data"] objectForKey:@"attributes"] objectForKey:@"firstName"];
                            
                            TKOPerference * usrPerference = [TKOPerference getPerference];
                            [usrPerference.tkoSettings setValue:userToken forKey:@"TRAKIO_TOKEN"];
                            [usrPerference.tkoSettings setValue:userID forKey:@"TRAKIO_USER_ID"];
                            [usrPerference.tkoSettings setValue:userFirstName forKey:@"TRAKIO_USER_FIRST_NAME"];
                            
                            TKOEmployee * employee = [[TKOEmployee alloc] initWithEmployeeID:userID Token:userToken];
                            employee.employeeFirstName = userFirstName;
                            
                            extern TKOEmployee * myself;
                            myself = employee;
                            
                            [usrPerference savePerference];
                            
                            [self performSelectorOnMainThread:@selector(goHomeView:) withObject:employee waitUntilDone:NO];
                            
                        }else {
                            
                            [self performSelectorOnMainThread:@selector(showAlertView:) withObject:@"Bad internet connection, please try again later." waitUntilDone:NO];
                            
                            NSLog(@"http response code : %d", httpResponse.statusCode);
                        }
                        NSString * responseJson = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                        NSLog(@"Data = %@",responseJson);

                    }];
        [postTask resume];
    
    }
    
}

-(void)goHomeView:(TKOEmployee *)employee {
    
            TKOHomeView * homeView = [[TKOHomeView alloc] initWithEmployee:employee];
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.3];
            [animation setType:kCATransitionPush];
            [animation setSubtype:kCATransitionFromRight];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
            [[homeView layer]addAnimation:animation forKey:@"viewAnimation"];
    
            [self.window.rootViewController.view addSubview:homeView];
}

-(void)showAlertView:(NSString *)message {
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Trakio" message:message delegate:self cancelButtonTitle:@"Try again" otherButtonTitles:nil, nil];
    [alertView show];
    
    [self.activityView stopAnimating];
    self.activityView.hidden = YES;
    
    self.loginForm.usernameField.text = @"";
    self.loginForm.passwordField.text = @"";
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.loginForm.usernameField resignFirstResponder];
    [self.loginForm.passwordField resignFirstResponder];
    
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.loginForm.usernameField resignFirstResponder];
    [self.loginForm.passwordField resignFirstResponder];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    extern NSMutableDictionary * dimension;
    
    if ([[dimension objectForKey:@"DEVICE_HEIGHT"] intValue] < 667) {
        [self layoutWithoutKeyboard];
    }

}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    extern NSMutableDictionary * dimension;
    
    if ([[dimension objectForKey:@"DEVICE_HEIGHT"] intValue] < 667) {
        [self layoutWithKeyboard];
    }
    
}

@end
