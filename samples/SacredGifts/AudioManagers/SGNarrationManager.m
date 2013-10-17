//
//  SGNarrationManager.m
//  SacredGifts
//
//  Created by Ontario on 10/16/13.
//
//

#import "SGNarrationManager.h"

@implementation SGNarrationManager

+ (id)sharedManager
{
    static SGNarrationManager *sharedNarrationManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedNarrationManager = [self new];
    });
    
    return  sharedNarrationManager;
}

@end
