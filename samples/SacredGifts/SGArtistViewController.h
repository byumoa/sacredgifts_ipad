//
//  SGArtistViewController.h
//  SacredGifts
//
//  Created by Ontario on 10/16/13.
//
//

#import "SGContentViewController.h"

@interface SGArtistViewController : SGContentViewController
{
    CGSize _scrollContentSize;
    NSString* _narrationStr;
}
@property (nonatomic, weak) IBOutlet UIScrollView* scrollView;

- (IBAction)pressedNarration:(UIButton *)sender;
- (IBAction)pressedPainting:(UIButton *)sender;

@end
