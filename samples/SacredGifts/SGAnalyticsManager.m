//
//  SGAnalyticsManager.m
//  SacredGifts
//
//  Created by Ontario on 11/21/13.
//
//

#import "SGAnalyticsManager.h"

@implementation SGAnalyticsManager

+(id)sharedManager
{
    static SGAnalyticsManager *analyticsManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        analyticsManager = [self new];
    });
    
    return analyticsManager;
}

+ (void)registerPageView: (NSString*)pageName{
    NSLog(@"registerPageView: %@", pageName);
}

+ (void)registerEventName: (NSString*)name category: (NSString*)category data:(NSString*)data{
    NSLog(@"registerEventName: %@, cat: %@, data: %@", name, category, data);
}

+ (void)startTimedEvent: (NSString*)name category: (NSString*)category data:(NSString*)data{
    NSLog(@"startTimedEvent: %@, cat: %@, data: %@", name, category, data);
}

+ (void)endTimedEvent: (NSString*)name category: (NSString*)category data:(NSString*)data{
    NSLog(@"endTimedEvent: %@, cat: %@, data: %@", name, category, data);
}

@end
