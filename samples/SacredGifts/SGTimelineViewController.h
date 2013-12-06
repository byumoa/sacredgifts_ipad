//
//  SGTimelineViewController.h
//  SacredGifts
//
//  Created by Ontario on 12/5/13.
//
//

#import "SGContentViewController.h"

@interface SGTimelineViewController : SGContentViewController
{
    NSMutableArray *_bochViews, *_schwartzViews, *_hofmannViews, *_worldViews, *_churchViews;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
