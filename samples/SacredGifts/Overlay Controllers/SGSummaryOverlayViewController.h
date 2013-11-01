//
//  SGSummaryOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SGSummaryOverlayViewController : SGOverlayViewController
@property (strong, nonatomic) AVAudioPlayer* player;
@property (nonatomic, weak) IBOutlet UIButton* narrationBtn;
- (IBAction)pressedNarration:(UIButton *)sender;

@end
