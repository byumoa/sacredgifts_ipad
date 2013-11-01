//
//  SGNarrationManager.h
//  SacredGifts
//
//  Created by Ontario on 10/16/13.
//
//

#import "SGAbstractAudioManager.h"

@interface SGNarrationManager : SGAbstractAudioManager

+ (id)sharedManager;
+ (void)pause;

@end
