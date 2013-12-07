//
//  SGNarrationOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 11/6/13.
//
//

#import "SGAudioViewController.h"
#import "SGNarrationManager.h"
#import "SGMediaPlayhead.h"

@interface SGNarrationOverlayViewController : SGAudioViewController <SGMediaPlayheadDelegate>
{
    SGNarrationManager* _narrationManager;
    BOOL _isPlaying;
}

@property(nonatomic, weak) IBOutlet SGMediaPlayhead* playhead;

@end
