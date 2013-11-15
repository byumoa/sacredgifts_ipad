//
//  SGStoryOfTheExhibitionViewController.h
//  SacredGifts
//
//  Created by Ontario on 11/9/13.
//
//

#import "SGParallaxBGViewController.h"

@interface SGStoryOfTheExhibitionViewController : SGParallaxBGViewController
{
    CGSize _scrollContentSize;
}
@property (nonatomic, weak) IBOutlet UIScrollView* scrollView;
@end
