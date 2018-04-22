//
//  TKODevice.h
//  Trakio
//
//  Created by yang wei on 08/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKODevice : NSObject

@property(nonatomic, copy)NSString * deviceModel;
@property(nonatomic, assign)float screenWidth;
@property(nonatomic, assign)float screenHeight;
@property(nonatomic, assign)int historyListHeight;
@property(nonatomic, assign)int locationListHeight;
@property(nonatomic, assign)int todoListHeight;
@property(nonatomic, assign)int loginViewTopMargin;

-(id)initWithWidth:(float)w Height:(float)h ;

@end
