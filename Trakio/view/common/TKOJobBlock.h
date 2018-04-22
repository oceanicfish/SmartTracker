//
//  TKOJobBlock.h
//  Trakio
//
//  Created by yang wei on 04/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NSString+FontAwesome.h"
#import "TKOSystem.h"
#import "TKOEmployee.h"
#import "TKOPerference.h"

@interface TKOJobBlock : UIView <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>

@property(nonatomic, strong)CLLocationManager * locationManager;
@property(nonatomic, strong)UIButton * blockTitle;
@property(nonatomic, strong)UIButton * blockIcon;
@property(nonatomic, strong)UIView * actionView;
@property(nonatomic, strong)TKOEmployee * employee;
@property(nonatomic, copy)NSString * lat;
@property(nonatomic, copy)NSString * lng;

-(id)initWithTitle:(NSString *)t Icon:(FaIcon)i ActionView:(UIView *)av;

-(void)uploadPhoto:(UIImage *)photo;

@end
