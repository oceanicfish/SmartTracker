//
//  ViewController.h
//  Trakio
//
//  Created by yang wei on 01/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "TKOHomeView.h"
#import "TKOLocationView.h"
#import "TKOTodoView.h"
#import "TKOCheckInView.h"
#import "TKOEmployee.h"
#import "TKOEmployeeShift.h"
#import "TKOLoginView.h"
#import "TKODevice.h"
#import "TKOPerference.h"

@interface ViewController : UIViewController

@property(nonatomic, strong)NSMutableDictionary * settings;

@end

