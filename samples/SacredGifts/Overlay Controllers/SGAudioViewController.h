//
//  SGAudioViewController.h
//  SacredGifts
//
//  Created by Ontario on 10/23/13.
//
//
#import "SGSecondaryOverlayViewController.h"
#import "SGNarrationManager.h"

@interface SGAudioViewController : SGSecondaryOverlayViewController
{
    NSTimer* _progressTimer;
    SGNarrationManager* _narrationManager;
}
@property (weak, nonatomic) IBOutlet UIImageView *playOverlay;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;

- (IBAction)pressedPlayPause:(id)sender;
- (void)configureAudioWithPath: (NSString*)rootFolderPath;

@end
