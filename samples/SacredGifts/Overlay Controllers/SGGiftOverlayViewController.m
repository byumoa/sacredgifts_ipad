//
//  SGGiftOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGGiftOverlayViewController.h"

@interface SGGiftOverlayViewController(Configurations)

- (void)configureVideoWithPath: (NSString*)path;
- (void)configureAudioWithPath: (NSString*)path;

@end

@implementation SGGiftOverlayViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 500);
        self.moduleType = kModuleTypeGifts;
    }
    
    return self;
}

- (void)configureGifts
{
    NSString* videoPath = [[NSBundle mainBundle] pathForResource:@"gift" ofType:@".mp4" inDirectory:self.rootFolderPath];
    NSString* audioPath = [[NSBundle mainBundle] pathForResource:@"gift" ofType:@".mp3" inDirectory:self.rootFolderPath];
    
    if( videoPath )
    {
        [self configureVideoWithPath:videoPath];
        self.screenName = [NSString stringWithFormat:@"%@: video gift", self.paintingName];
    }
    else if ( audioPath )
    {
        [self configureAudioWithPath:audioPath];
        self.screenName = [NSString stringWithFormat:@"%@: audio gift", self.paintingName];
    }
    else
        self.screenName = [NSString stringWithFormat:@"%@: text gift", self.paintingName];
}

- (void)configureVideoWithPath:(NSString *)path
{
    NSURL* url = [NSURL fileURLWithPath:path];
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.moviePlayer.view.frame = CGRectMake(0, 45, 768, 432);
    self.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    [self.view addSubview:self.moviePlayer.view];
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];
}

-(void)configureAudioWithPath:(NSString *)path
{
    
}

@end
