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
}

- (IBAction)pressedPlayPauseMusic:(id)sender
{
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"music" ofType:@".mp3" inDirectory:self.rootFolderPath];
    
    if( musicPath )
    {
        SGMusicManager* musicManager = [SGMusicManager sharedManager];
        [musicManager playAudioWithPath:musicPath];
        //        ((UIButton*)sender). musicManager.player.isPlaying
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Missing Asset" message:@"music.pm3 has not been added for this overlay" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

@end
