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

-(void)playPerspectiveMovieWithRootFolderPath: (NSString*)rootFoolderPath
{
    self.rootFolderPath = rootFoolderPath;
    NSString* moviePath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4" inDirectory:self.rootFolderPath];
    NSURL* url = [NSURL fileURLWithPath:moviePath];
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.moviePlayer.view.frame = CGRectMake(0, 45, 768, 432);
    self.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    [self.view addSubview:self.moviePlayer.view];
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];
}

@end
