//
//  SGArtistViewController.h
//  SacredGifts
//
//  Created by Ontario on 10/16/13.
//
//

#import "SGParallaxBGViewController.h"

@interface SGArtistViewController : SGParallaxBGViewController
{
    CGSize _scrollContentSize;
    NSString* _narrationStr;
}
@property (nonatomic, weak) IBOutlet UIScrollView* scrollView;

- (IBAction)pressedNarration:(UIButton *)sender;
- (IBAction)pressedPainting:(UIButton *)sender;

@end
