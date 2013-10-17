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
}
@property (nonatomic, weak) IBOutlet UIScrollView* scrollView;

- (IBAction)pressedNarration:(UIButton *)sender;

@end
