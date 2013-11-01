//
//  SGNarrationManager.m
//  SacredGifts
//
//  Created by Ontario on 10/16/13.
//
//

#import "SGNarrationManager.h"
#import "SGMusicManager.h"

@implementation SGNarrationManager

+ (id)sharedManager
{
    static SGNarrationManager *sharedNarrationManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedNarrationManager = [self new];
    });
    
    return sharedNarrationManager;
}

-(void)playAudioWithPath:(NSString *)audioPath
{
    [super playAudioWithPath:audioPath];
    [SGMusicManager dropVolume];
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [super audioPlayerDidFinishPlaying:player successfully:flag];
    [SGMusicManager bumpUpVolume];
}

-(void)pauseAudio
{
    [super pauseAudio];
    [SGMusicManager bumpUpVolume];
}

+ (void)pause
{
    [[SGNarrationManager sharedManager] pauseAudio];
}

@end
