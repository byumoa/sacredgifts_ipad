//
//  SGConvenienceFunctionsManager.h
//  SacredGifts
//
//  Created by Ontario on 11/9/13.
//
//

#import <Foundation/Foundation.h>

@interface SGConvenienceFunctionsManager : NSObject

+ (id)sharedManager;
+ (NSString*)artistForPainting: (NSString*)paintingStr abbreviated:(BOOL)abbreviate;

@end
