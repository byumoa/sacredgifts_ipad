//
//  SGMusicOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayViewController.h"
@class SGMusicManager;

@interface SGMusicOverlayViewController : SGOverlayViewController
{
    NSTimer* _progressTimer;
    SGMusicManager* _musicManager;
}
@property (weak, nonatomic) IBOutlet UIImageView *playOverlay;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;

- (IBAction)pressedPlayPause:(id)sender;

@end
