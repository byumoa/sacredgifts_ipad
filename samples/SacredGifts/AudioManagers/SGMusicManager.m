//
//  SGMusicManager.m
//  SacredGifts
//
//  Created by Ontario on 10/16/13.
//
//

#import "SGMusicManager.h"

@implementation SGMusicManager

+ (id)sharedManager
{
    static SGMusicManager *sharedMusicManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMusicManager = [self new];
    });
    
    return  sharedMusicManager;
}

+(void)dropVolume
{
    ((SGMusicManager*)[SGMusicManager sharedManager]).player.volume = 0.1;
}

+(void)bumpUpVolume
{
    ((SGMusicManager*)[SGMusicManager sharedManager]).player.volume = 1.0;
}

@end
