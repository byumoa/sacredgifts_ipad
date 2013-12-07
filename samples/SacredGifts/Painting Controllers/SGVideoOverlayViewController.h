//
//  SGVideoOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 10/5/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SGMediaPlayhead.h"

@interface SGVideoOverlayViewController : SGOverlayViewController <SGMediaPlayheadDelegate>
{
    BOOL _isPlaying;
    BOOL _isSeeking;
    NSTimer* _progressTimer;
}
@property(nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (weak, nonatomic) IBOutlet UIImageView *freezeFrame;

@property (weak, nonatomic) IBOutlet UIImageView *playOverlay;
@property (weak, nonatomic) IBOutlet UIImageView *playUnderlay;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet SGMediaPlayhead *mediaPlayhead;

- (IBAction)pressedPlayPause:(UIButton *)sender;
- (void)playPerspectiveMovieWithRootFolderPath: (NSString*)rootFoolderPath;
@end
