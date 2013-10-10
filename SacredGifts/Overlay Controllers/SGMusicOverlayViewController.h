//
//  SGMusicOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SGMusicOverlayViewController : SGOverlayViewController
@property (weak, nonatomic) IBOutlet UIImageView *playHead;
@property (weak, nonatomic) IBOutlet UIImageView *playOverlay;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (strong, nonatomic) AVAudioPlayer* player;

- (IBAction)pressedPlayPause:(id)sender;

@end
