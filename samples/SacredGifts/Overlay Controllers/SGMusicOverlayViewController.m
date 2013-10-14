//
//  SGMusicOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGMusicOverlayViewController.h"

@interface SGMusicOverlayViewController ()
- (void) playMusicFromBeginning;
@end

@implementation SGMusicOverlayViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 700);
        self.moduleType = kModuleTypeMusic;
    }
    
    return self;
}

-(void)addBackgroundImgWithPath:(NSString *)bgImgPath
{
    [super addBackgroundImgWithPath:bgImgPath];
    [self playMusicFromBeginning];
}

- (IBAction)pressedPlayPause:(id)sender{}

-(void)playMusicFromBeginning
{
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"music" ofType:@".mp3" inDirectory:self.rootFolderPath];
    
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];

    //[[AVAudioSession sharedInstance] setDelegate: self];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryAmbient error: nil];
    
    // Activates the audio session.
    
    NSError *activationError = nil;
    [[AVAudioSession sharedInstance] setActive: YES error: &activationError];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL: musicURL error: nil];
    [self.player prepareToPlay];
    [self.player setVolume: 1.0];
    self.player.numberOfLoops = -1;
    //[player setDelegate: self];
    [self.player play];
}
@end
