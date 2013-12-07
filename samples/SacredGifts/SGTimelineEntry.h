//
//  SGTimelineEntry.h
//  SacredGifts
//
//  Created by Ontario on 12/5/13.
//
//

#import <UIKit/UIKit.h>
@protocol SGTimelineEntryDelegate;

@interface SGTimelineEntry : UIView
{
    NSString* _pageLink;
    CGRect _fullFrame;
    NSString* _popupName;
    UIImageView* _popup;
}
@property(nonatomic, weak) id<SGTimelineEntryDelegate> delegate;
- (SGTimelineEntry*)initWithDictionary: (NSDictionary*)dict andColor: (UIColor*)bgColor;
- (void)animateOn;
- (void)animateOff;
@end

@interface SGTimelinePopup : UIImageView

@end

@protocol SGTimelineEntryDelegate
- (void) timelineEntry: (SGTimelineEntry*)timelineEntry triggersPopup: (SGTimelinePopup*)popup;
@end
