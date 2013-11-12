//
//  SGAudioViewController.h
//  SacredGifts
//
//  Created by Ontario on 10/23/13.
//
//
#import "SGOverlayViewController.h"
@class SGAbstractAudioManager;

@interface SGAudioViewController : SGOverlayViewController
{
    NSTimer* _progressTimer;
    SGAbstractAudioManager* _audioManager;
}
@property (weak, nonatomic) IBOutlet UIImageView *playOverlay;
@property (weak, nonatomic) IBOutlet UIImageView *playUnderlay;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;

- (IBAction)pressedPlayPause:(id)sender;
- (void)configureAudioWithPath: (NSString*)rootFolderPath;

@end
