//
//  SGAudioViewController.h
//  SacredGifts
//
//  Created by Ontario on 10/23/13.
//
//

#import "SGOverlayViewController.h"
#import "SGMusicManager.h"

@interface SGAudioViewController : SGOverlayViewController
{
    NSTimer* _progressTimer;
    SGMusicManager* _musicManager;
}
@property (weak, nonatomic) IBOutlet UIImageView *playOverlay;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;

- (IBAction)pressedPlayPause:(id)sender;

@end
