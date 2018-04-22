//
//  TKONote.h
//  Trakio
//
//  Created by yang wei on 08/03/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKONote : NSObject

@property(nonatomic, strong)NSString * title;
@property(nonatomic, strong)NSString * content;

-(id)initWithTitle:(NSString *)t Content:(NSString *)c;

@end
