//
//  UWFacebookService.h
//  SacredGifts
//
//  Created by Ontario on 11/26/13.
//
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface UWFacebookService : NSObject
- (BOOL)isSessionStateEffectivelyLoggedIn:(FBSessionState)state;
- (BOOL)isLoggedIn;
- (BOOL)isLoggedInAfterOpenAttempt;
@end
