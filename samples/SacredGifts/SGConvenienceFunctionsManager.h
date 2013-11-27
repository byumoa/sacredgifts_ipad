//
//  SGConvenienceFunctionsManager.h
//  SacredGifts
//
//  Created by Ontario on 11/9/13.
//
//

#import <Foundation/Foundation.h>
#import "SGConstants.h"

@interface SGConvenienceFunctionsManager : NSObject

+ (id)sharedManager;
+ (NSString*)artistForPainting: (NSString*)paintingStr abbreviated:(BOOL)abbreviate;
+ (NSString *)getStringForModule:(ModuleType)moduleType;
+ (NSString *)getFBURLStrForModule:(NSString*)paintingStr;
+ (void) facebookLogout;

@end
