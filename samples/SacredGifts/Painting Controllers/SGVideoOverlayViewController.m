//
//  SGVideoOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/5/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGVideoOverlayViewController.h"

@interface SGVideoOverlayViewController ()

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

- (IBAction)pressedPlayPause:(UIButton *)sender
{
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];
    [UIView animateWithDuration:0.25 animations:^{
        self.freezeFrame.alpha = 0;
    }];
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
}

@end
