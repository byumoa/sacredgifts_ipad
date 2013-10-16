//
//  SGArtistViewController.h
//  SacredGifts
//
//  Created by Ontario on 10/16/13.
//
//

#import "SGContentViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SGArtistViewController : SGContentViewController
{
    CGSize _scrollContentSize;
}
@property (nonatomic, weak) IBOutlet UIScrollView* scrollView;
@property (strong, nonatomic) AVAudioPlayer* player;

- (IBAction)pressedNarration:(UIButton *)sender;

@end
