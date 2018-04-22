//
//  TKOTodo.h
//  Trakio
//
//  Created by yang wei on 07/03/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKOTodo : NSObject

@property(nonatomic, copy)NSString * todoID;
@property(nonatomic, copy)NSString * locationID;
@property(nonatomic, copy)NSString * title;
@property(nonatomic, copy)NSString * description;
@property(nonatomic, copy)NSString * created_at;
@property(nonatomic, copy)NSString * updated_at;
@property(nonatomic, assign)bool done;

-(id)initWithTitle:(NSString *)t Description:(NSString *)des;

@end
