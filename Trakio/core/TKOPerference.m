//
//  TKOPerference.m
//  Trakio
//
//  Created by yang wei on 18/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOPerference.h"

static TKOPerference * tkoPerference_ = nil;

@implementation TKOPerference
{
    NSError * _err;
}

+(id)getPerference {
    
    if (tkoPerference_ == nil) {
        
        NSLog(@"Trakio perference file is nil, start to instantiate");
        tkoPerference_ = [[TKOPerference alloc] init];
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSError *err = nil;
        NSURL *tkoFilePathURL = [fileManager URLForDirectory:NSApplicationSupportDirectory
                                            inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
        
        NSLog(@"%@", tkoFilePathURL.absoluteString);
        
        if (tkoFilePathURL) {
            NSLog(@"tkoFilePathURL = %@", tkoFilePathURL);
            tkoFilePathURL = [tkoFilePathURL URLByAppendingPathComponent:@"tkoplist.dat"];
            NSLog(@"ktFilePathURL = %@", tkoFilePathURL);
            
            NSMutableDictionary *dictFromURL = [[NSMutableDictionary alloc] initWithContentsOfURL:tkoFilePathURL];
            if (dictFromURL) {
                tkoPerference_.tkoSettings = dictFromURL;
                NSLog(@"Trakio Settings Dictionary is loaded completely");
            }else {
                NSLog(@"Trakio Settings Dictionary is not exist or the format is unavailable");
                NSLog(@"start to create new perference dictionary.");
                tkoPerference_.tkoSettings = [tkoPerference_ createDefaultPerference];
                NSLog(@"new perference dictionary created, start to write to file.");
                [tkoPerference_.tkoSettings writeToURL:tkoFilePathURL atomically:YES];
                NSLog(@"new perference dictionary file has been writen.");
            }
        }else {
            tkoPerference_->_err = err;
            NSLog(@"Directory create failed. the err = %@", err);
        }
        
        NSLog(@"Trakio perference file instantiating finished");
        
        
    }else {
        NSLog(@"Trakio perference file is not nil, return it");
    }
    
    return tkoPerference_;
}

-(NSMutableDictionary *)createDefaultPerference {
    NSMutableDictionary * newPerferenceDict = [[NSMutableDictionary alloc] init];
    
    [newPerferenceDict setObject:@"" forKey:@"DEVICE_TYPE"];
    [newPerferenceDict setObject:@"" forKey:@"DEVICE_WIDTH"];
    [newPerferenceDict setObject:@"" forKey:@"DEVICE_HEIGHT"];
    [newPerferenceDict setObject:@"" forKey:@"TRAKIO_TOKEN"];
    [newPerferenceDict setObject:@"" forKey:@"TRAKIO_USER_ID"];
    [newPerferenceDict setObject:@"" forKey:@"TRAKIO_USER_PATH"];
    
    return newPerferenceDict;
}
//
//-(void)deletePerference {
//    
//    NSFileManager *fileManager = [[NSFileManager alloc] init];
//    NSError *err = nil;
//    NSURL *tkoFilePathURL = [fileManager URLForDirectory:NSApplicationSupportDirectory
//                            inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
//    tkoFilePathURL = [tkoFilePathURL URLByAppendingPathComponent:@"tkoplist.dat"];
//    /****************** delete plist file *********************************/
//    
//    [fileManager removeItemAtURL:tkoFilePathURL error:&err];
//    
//    if (!err) {
//        NSLog(@"perference file has been deleted.");
//    }else {
//        NSLog(@"perference file cannot be deleted.");
//    }
//    
//    /****************** delete plist file *********************************/
//}

-(void)savePerference {
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSError *err = nil;
    NSURL *tkoFilePathURL = [fileManager URLForDirectory:NSApplicationSupportDirectory
                                inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
    
    if (tkoFilePathURL) {
        
        tkoFilePathURL = [tkoFilePathURL URLByAppendingPathComponent:@"tkoplist.dat"];
        NSLog(@"ktFilePathURL = %@", tkoFilePathURL);
        BOOL saved = [tkoPerference_.tkoSettings writeToURL:tkoFilePathURL atomically:YES];
        if (saved) {
            NSLog(@"perference file has been writen.");
        }else {
            NSLog(@"perference file cannot be writen.");
        }
        
        
        
    }else {
        tkoPerference_->_err = err;
        NSLog(@"Perference file created failed. the err = %@", err);
    }
}

@end
