//
//  SGVideoOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/5/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGVideoOverlayViewController.h"
#import "SGMusicManager.h"

//Y-Pos = screenHeight - footerHeight - buffer - overlayHeight
//Height = 1024 - 70 - 41 - 688
const CGRect kVideoFrame = {0, 225, 768, 688};

@interface SGVideoOverlayViewController ()
- (void) playbackFinished: (NSNotification*)notification;
@end

@implementation SGVideoOverlayViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 500);
        self.moduleType = kModuleTypeVideo;
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(updateProgressBar:) userInfo:nil repeats:YES];
    self.view.frame = kVideoFrame;
    
    [self.playOverlay removeFromSuperview];
    [self.playUnderlay addSubview:self.playOverlay];
    
    self.mediaPlayhead.startX = self.playUnderlay.frame.origin.x;
    self.mediaPlayhead.endX = self.playUnderlay.frame.origin.x + self.playUnderlay.frame.size.width;
    
    CGPoint center = self.mediaPlayhead.center;
    center.y = self.playPauseButton.center.y;
    self.mediaPlayhead.center = center;
    
    center = self.playUnderlay.center;
    center.y = self.playPauseButton.center.y;
    self.playUnderlay.center = center;
}

-(void)updateProgressBar:(NSTimer*)timer
{
    if( !_isSeeking )
    {
        CGRect frame = self.playOverlay.frame;
        frame.origin = CGPointZero;
    
    	CGPoint center = CGPointZero;
    	if( self.moviePlayer.duration > 0 && self.moviePlayer )
        {
            frame.size.width = self.moviePlayer.currentPlaybackTime / self.moviePlayer.duration * self.playUnderlay.frame.size.width;
        }
    
        if( !isnan(frame.size.width) && !isnan(frame.size.height))
            self.playOverlay.frame = frame;
    
        center = self.mediaPlayhead.center;
        center.x = self.playUnderlay.frame.origin.x + frame.size.width;
//        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//            self.mediaPlayhead.center = center;
//        } completion:nil];
    }
}

- (IBAction)pressedPlayPause:(UIButton *)sender
{
    if( self.moviePlayer.playbackState  == MPMoviePlaybackStatePlaying )
    {
        [self.moviePlayer pause];
        [SGMusicManager bumpUpVolume];
    }
    else
    {
        [self.moviePlayer prepareToPlay];
        [self.moviePlayer play];
        [SGMusicManager dropVolume];
        
        [UIView animateWithDuration:0.25 delay:0 options:0 animations:^{
            self.freezeFrame.alpha = 0;
        } completion:^(BOOL finished) {
            [self.freezeFrame removeFromSuperview];
            [self.view insertSubview:self.freezeFrame belowSubview:self.moviePlayer.view];
        }];
    }
    
    self.playPauseButton.selected = (self.moviePlayer.playbackState != MPMoviePlaybackStatePlaying);
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
    
    self.screenName = [NSString stringWithFormat:@"%@: video", self.paintingName];
}

-(void)playbackFinished:(NSNotification *)notification
{
    [self.freezeFrame removeFromSuperview];
    [self.view insertSubview:self.freezeFrame aboveSubview:self.moviePlayer.view];
    [UIView animateWithDuration:0.25 animations:^{
        self.freezeFrame.alpha = 1;
    }];
    
    self.playPauseButton.selected = (self.moviePlayer.playbackState != MPMoviePlaybackStatePlaying);
    [SGMusicManager bumpUpVolume];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_progressTimer invalidate];
}

-(void)pressedClose:(UIButton *)sender
{
    [super pressedClose:sender];
}

#pragma mark delegate methods
-(void)playhead:(SGMediaPlayhead *)playhead seekingStartedAtPoint:(CGPoint)pt
{
    _isPlaying = (self.moviePlayer.playbackState == MPMoviePlaybackStatePlaying);
    _isSeeking = YES;
    [self.moviePlayer pause];
}

-(void)playhead:(SGMediaPlayhead *)playhead seekingMovedAtPoint:(CGPoint)pt
{
    float percentComplete = (playhead.center.x - self.playUnderlay.frame.origin.x)/self.playUnderlay.frame.size.width;
    self.moviePlayer.currentPlaybackTime = self.moviePlayer.duration * percentComplete;
    [self.moviePlayer pause];
    CGRect frame = self.playOverlay.frame;
    frame.size.width = self.playUnderlay.frame.size.width * percentComplete;
    self.playOverlay.frame = frame;
}

-(void)playhead:(SGMediaPlayhead *)playhead seekingEndedAtPoint:(CGPoint)pt
{
    _isSeeking = NO;
    if( _isPlaying )
        [self.moviePlayer play];
}

@end
