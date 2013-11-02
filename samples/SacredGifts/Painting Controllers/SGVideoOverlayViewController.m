//
//  SGVideoOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/5/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGVideoOverlayViewController.h"

@interface SGVideoOverlayViewController ()
- (void) playbackFinished: (NSNotification*)notification;
@end

@implementation SGVideoOverlayViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder])
    {
        _centerPos = CGPointMake(384, 500);
        self.moduleType = kModuleTypeVideo;
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(updateProgressBar:) userInfo:nil repeats:YES];
}

-(void)updateProgressBar:(NSTimer*)timer
{
    CGRect frame = self.playOverlay.frame;
    if( self.moviePlayer.duration > 0 )
        frame.size.width = self.moviePlayer.currentPlaybackTime / self.moviePlayer.duration * 635.0;
    
    self.playOverlay.frame = frame;
}

- (IBAction)pressedPlayPause:(UIButton *)sender
{
    if( self.moviePlayer.playbackState  == MPMoviePlaybackStatePlaying )
        [self.moviePlayer pause];
    else
    {
        [self.moviePlayer prepareToPlay];
        [self.moviePlayer play];
        [UIView animateWithDuration:0.25 animations:^{
            self.freezeFrame.alpha = 0;
        }];
    }
    
    ((UIButton*)sender).selected = (self.moviePlayer.playbackState != MPMoviePlaybackStatePlaying);
}

-(void)playPerspectiveMovieWithRootFolderPath: (NSString*)rootFoolderPath
{
    self.rootFolderPath = rootFoolderPath;
    NSString* freeFramePath = [[NSBundle mainBundle] pathForResource:@"poster" ofType:@"png" inDirectory:self.rootFolderPath];
    self.freezeFrame.image = [UIImage imageWithContentsOfFile:freeFramePath];
    self.freezeFrame.frame = CGRectMake(0, 45, 768, 432);
    
    NSString* moviePath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4" inDirectory:self.rootFolderPath];
    NSURL* url = [NSURL fileURLWithPath:moviePath];
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];

    self.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    self.moviePlayer.view.frame = self.freezeFrame.frame;
    [self.view insertSubview:self.moviePlayer.view belowSubview:self.freezeFrame];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
}

-(void)playbackFinished:(NSNotification *)notification
{
    NSLog(@"playbackFinished notification");
    [UIView animateWithDuration:0.25 animations:^{
        self.freezeFrame.alpha = 1;
    }];
    
    self.playPauseButton.selected = (self.moviePlayer.playbackState != MPMoviePlaybackStatePlaying);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
