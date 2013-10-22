//
//  SGGiftOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface SGGiftOverlayViewController : SGOverlayViewController
@property(nonatomic, strong) MPMoviePlayerController *moviePlayer;
- (void)configureGifts;

@end
