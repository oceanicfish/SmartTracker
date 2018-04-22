//
//  TKOPerference.h
//  Trakio
//
//  Created by yang wei on 18/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKOPerference : NSObject

@property(strong)NSMutableDictionary * tkoSettings;

+(id)getPerference;

-(NSMutableDictionary *)createDefaultPerference;
-(void)savePerference;
-(void)deletePerference;

@end
