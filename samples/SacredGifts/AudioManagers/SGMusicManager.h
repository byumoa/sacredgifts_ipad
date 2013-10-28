//
//  SGMusicManager.h
//  SacredGifts
//
//  Created by Ontario on 10/16/13.
//
//

#import "SGAbstractAudioManager.h"

@interface SGMusicManager : SGAbstractAudioManager

+ (id)sharedManager;
+ (void)dropVolume;
+ (void)bumpUpVolume;

@end
