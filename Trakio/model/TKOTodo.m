//
//  TKOTodo.m
//  Trakio
//
//  Created by yang wei on 07/03/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOTodo.h"

@implementation TKOTodo

@synthesize todoID;
@synthesize locationID;
@synthesize title;
@synthesize description;
@synthesize created_at;
@synthesize updated_at;
@synthesize done;

-(id)initWithTitle:(NSString *)t Description:(NSString *)des {
    if (self = [super init]) {
        self.title = t;
        self.description = des;
        
    }
    
    return self;
}

@end
