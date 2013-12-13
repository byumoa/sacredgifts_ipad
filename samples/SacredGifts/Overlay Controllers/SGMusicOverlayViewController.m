//
//  SGMusicOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGMusicOverlayViewController.h"
#import "SGMusicManager.h"


@interface SGMusicOverlayViewController ()
- (void) updateProgressBar: (NSTimer*)timer;
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

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)updateProgressBar:(NSTimer*)timer
{
    if( !_musicManager.player.isPlaying )return;
    CGRect frame = self.playOverlay.frame;
    frame.origin = CGPointMake(100, 221);
    if( _musicManager.player.duration > 0 )
        frame.size.width = _musicManager.player.currentTime / _musicManager.player.duration * 635.0;
    self.playOverlay.frame = frame;
}

-(void)addBackgroundImgWithPath:(NSString *)bgImgPath
{
    [super addBackgroundImgWithPath:bgImgPath];
    
    _musicManager = [SGMusicManager sharedManager];
    [self updateProgressBar:nil];
    self.playPauseButton.selected = _musicManager.player.isPlaying;
}

- (IBAction)pressedPlayPause:(id)sender
{
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"music" ofType:@".mp3" inDirectory:self.rootFolderPath];
    
    if( musicPath )
    {
        _musicManager = [SGMusicManager sharedManager];
        if( _musicManager.player.isPlaying )
            [_musicManager pauseAudio];
        else
            [_musicManager playAudioWithPath:musicPath];
        
        ((UIButton*)sender).selected = _musicManager.player.isPlaying;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_progressTimer invalidate];
}

@end
