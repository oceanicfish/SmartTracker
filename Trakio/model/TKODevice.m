//
//  TKODevice.m
//  Trakio
//
//  Created by yang wei on 08/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKODevice.h"

@implementation TKODevice

@synthesize deviceModel;
@synthesize screenWidth;
@synthesize screenHeight;
@synthesize historyListHeight;
@synthesize locationListHeight;
@synthesize todoListHeight;
@synthesize loginViewTopMargin;

-(id)initWithWidth:(float)w Height:(float)h {
    if (self = [super init]) {
        self.screenWidth = w;
        self.screenHeight = h;
        
        //for iphone 4s
        if (self.screenHeight == 480 ) {
            self.deviceModel = @"iPhone 4s";
            self.historyListHeight = 90;
            self.locationListHeight = 90;
            self.todoListHeight = 90;
            self.loginViewTopMargin = 60;
        }
        
        //for iphone 5/5s
        if (self.screenHeight == 568 ) {
            self.deviceModel = @"iPhone 5/5s";
            self.historyListHeight = 120;
            self.locationListHeight = 120;
            self.todoListHeight = 120;
            self.loginViewTopMargin = 80;
        }
        
        //for iphone 6/6s
        if (self.screenHeight == 667 ) {
            self.deviceModel = @"iPhone 6/6s";
            self.historyListHeight = 220;
            self.locationListHeight = 220;
            self.todoListHeight = 220;
            self.loginViewTopMargin = 100;
        }
        
        //for iphone 6+/6s+
        if (self.screenHeight == 667 ) {
            self.deviceModel = @"iPhone 6+/6s+";
            self.historyListHeight = 220;
            self.locationListHeight = 220;
            self.todoListHeight = 220;
            self.loginViewTopMargin = 100;
        }
    }
    
    return self;
}

@end
