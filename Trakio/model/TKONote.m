//
//  TKONote.m
//  Trakio
//
//  Created by yang wei on 08/03/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKONote.h"

@implementation TKONote

@synthesize title;
@synthesize content;

-(id)initWithTitle:(NSString *)t Content:(NSString *)c {
    if (self = [super init]) {
        self.title = t;
        self.content = c;
    }
    
    return self;
}

@end
