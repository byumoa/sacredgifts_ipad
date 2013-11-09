//
//  SGStoryOfTheExhibitionViewController.h
//  SacredGifts
//
//  Created by Ontario on 11/9/13.
//
//

#import "SGContentViewController.h"

@interface SGStoryOfTheExhibitionViewController : SGContentViewController
{
    CGSize _scrollContentSize;
}
@property (nonatomic, weak) IBOutlet UIScrollView* scrollView;
@end
