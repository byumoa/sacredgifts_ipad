//
//  SGTimelineViewController.h
//  SacredGifts
//
//  Created by Ontario on 12/5/13.
//
//

#import "SGContentViewController.h"
#import "SGTimelineEntry.h"

@interface SGTimelineViewController : SGContentViewController<SGTimelineEntryDelegate>
{
    NSMutableArray *_blochViews, *_schwartzViews, *_hofmannViews, *_worldViews, *_churchViews;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *datesImageView;
- (IBAction)pressedTimelineToggle:(UIButton *)sender;

@end
