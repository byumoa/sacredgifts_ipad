#import "UWFacebookService.h"

@implementation UWFacebookService

#pragma mark - Inquiries

- (BOOL)isSessionStateEffectivelyLoggedIn:(FBSessionState)state {
    BOOL effectivelyLoggedIn;
    
    switch (state) {
        case FBSessionStateOpen:
            NSLog(@"Facebook session state: FBSessionStateOpen");
            effectivelyLoggedIn = YES;
            break;
        case FBSessionStateCreatedTokenLoaded:
            NSLog(@"Facebook session state: FBSessionStateCreatedTokenLoaded");
            effectivelyLoggedIn = YES;
            break;
        case FBSessionStateOpenTokenExtended:
            NSLog(@"Facebook session state: FBSessionStateOpenTokenExtended");
            effectivelyLoggedIn = YES;
            break;
        default:
            NSLog(@"Facebook session state: not of one of the open or openable types.");
            effectivelyLoggedIn = NO;
            break;
    }
    
    return effectivelyLoggedIn;
}

/**
 * Determines if the Facebook session has an authorized state. It might still need to be opened if it is a cached
 * token, but the purpose of this call is to determine if the user is authorized at least that they will not be
 * explicitly asked anything.
 */
- (BOOL)isLoggedIn {
    FBSession *activeSession = [FBSession activeSession];
    FBSessionState state = activeSession.state;
    BOOL isLoggedIn = activeSession && [self isSessionStateEffectivelyLoggedIn:state];
    
    NSLog(@"Facebook active session state: %d; logged in conclusion: %@", state, (isLoggedIn ? @"YES" : @"NO"));
    
    return isLoggedIn;
}


/**
 * Attempts to silently open the Facebook session if we have a valid token loaded (that perhaps needs a behind the scenes refresh).
 * After that attempt, we defer to the basic concept of the session being in one of the valid authorized states.
 */
- (BOOL)isLoggedInAfterOpenAttempt {
    NSLog(@"FBSession.activeSession: %@", FBSession.activeSession);
    
    // If we don't have a cached token, a call to open here would cause UX for login to
    // occur; we don't want that to happen unless the user clicks the login button over in Settings, and so
    // we check here to make sure we have a token before calling open
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        NSLog(@"We have a cached token, so we're going to re-establish the login for the user.");
        // Even though we had a cached token, we need to login to make the session usable:
        [FBSession.activeSession openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            NSLog(@"Finished opening login session, with state: %d", status);
        }];
    }
    else {
        NSLog(@"Active session wasn't in state 'FBSessionStateCreatedTokenLoaded'. It has state: %d", FBSession.activeSession.state);
    }
    
    return [self isLoggedIn];
}

@end

