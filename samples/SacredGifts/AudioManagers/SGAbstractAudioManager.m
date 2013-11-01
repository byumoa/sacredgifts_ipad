//
//  SGAbstractAudioManager.m
//  SacredGifts
//
//  Created by Ontario on 10/16/13.
//
//

#import "SGAbstractAudioManager.h"

@implementation SGAbstractAudioManager

- (void)playAudioWithPath:(NSString *)audioPath
{
    if( [audioPath isEqualToString:_currentAudioPath] )
    {
        if( !self.player.playing )
            [self.player play];
    }
    else
    {
        _currentAudioPath = audioPath;
    
        if( audioPath )
        {
            NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
            [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryAmbient error: nil];
        
            NSError *activationError = nil;
            [[AVAudioSession sharedInstance] setActive: YES error: &activationError];
        
            self.player = [[AVAudioPlayer alloc] initWithContentsOfURL: audioURL error: nil];
            self.player.delegate = self;
            [self.player prepareToPlay];
            [self.player setVolume: 1.0];
            self.player.numberOfLoops = 0;
            [self.player play];
        }
    }
}

- (void)pauseAudio
{
    [self.player pause];
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
}

@end
