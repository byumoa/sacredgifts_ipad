//
//  SGVideoOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 10/5/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface SGVideoOverlayViewController : SGOverlayViewController
@property(nonatomic, strong) MPMoviePlayerController *moviePlayer;
-(void)playPerspectiveMovieWithRootFolderPath: (NSString*)rootFoolderPath;
@end
