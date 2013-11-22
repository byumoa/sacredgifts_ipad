//
//  SGAnalyticsManager.h
//  SacredGifts
//
//  Created by Ontario on 11/21/13.
//
//

#import <Foundation/Foundation.h>

@interface SGAnalyticsManager : NSObject

+ (id)sharedManager;
+ (void)registerPageView: (NSString*)pageName;
+ (void)registerEventName: (NSString*)name category: (NSString*)category data:(NSString*)data;
+ (void)startTimedEvent: (NSString*)name category: (NSString*)category data:(NSString*)data;
+ (void)endTimedEvent: (NSString*)name category: (NSString*)category data:(NSString*)data;

@end
