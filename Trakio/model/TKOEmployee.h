//
//  TKOEmployee.h
//  Trakio
//
//  Created by yang wei on 01/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKOEmployee : NSObject

@property(nonatomic, copy)NSString * employeeID;
@property(nonatomic, copy)NSString * employeeFirstName;
@property(nonatomic, copy)NSString * employeePhoto;
@property(nonatomic, copy)NSString * employeeToken;
@property(nonatomic, assign)bool started;
@property(nonatomic, assign)bool breakStatus;
@property(nonatomic, assign)NSString * checkInID;

-(id)initWithEmployeeID:(NSString *)ID Token:(NSString *)token;

@end
