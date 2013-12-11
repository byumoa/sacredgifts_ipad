//
//  SGIntoMovieViewController.h
//  SacredGifts
//
//  Created by Ontario on 12/2/13.
//
//

#import "SGContentViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface SGIntroMovieViewController : SGContentViewController

@property(nonatomic, strong) MPMoviePlayerController *moviePlayer;
@end
