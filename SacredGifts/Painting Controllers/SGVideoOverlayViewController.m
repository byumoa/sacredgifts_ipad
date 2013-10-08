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
@synthesize player = _player;
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
    NSString* moviePath = [[NSBundle mainBundle] pathForResource:@"perspectives_video" ofType:@"mov" inDirectory:self.rootFolderPath];
    NSURL* url = [NSURL fileURLWithPath:moviePath];
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.player.view.frame = CGRectMake(0, 45, 768, 432);
    self.player.movieSourceType = MPMovieSourceTypeFile;
    self.player.controlStyle = MPMovieControlStyleNone;
    [self.view addSubview:self.player.view];
    [self.player prepareToPlay];
    [self.player play];
}

@end