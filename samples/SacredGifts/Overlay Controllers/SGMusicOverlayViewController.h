//
//  SGMusicOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayViewController.h"

@interface SGMusicOverlayViewController : SGOverlayViewController
@property (weak, nonatomic) IBOutlet UIImageView *playHead;
@property (weak, nonatomic) IBOutlet UIImageView *playOverlay;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;

- (IBAction)pressedPlayPause:(id)sender;

@end
