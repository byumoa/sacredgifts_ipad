//
//  SGTimelineEntry.h
//  SacredGifts
//
//  Created by Ontario on 12/5/13.
//
//

#import <UIKit/UIKit.h>
#import "SGContentControllerDelegate.h"
@protocol SGTimelineEntryDelegate;

@interface SGTimelineEntry : UIView
{
    NSString* _pageLink;
    CGRect _fullFrame;
    NSString* _popupName;
    NSString* _buttonName;
    UIImageView* _popup;
    UIButton *_dismiss1, *_dismiss2;
    NSString* _navStr;
}
@property(nonatomic, weak) id<SGTimelineEntryDelegate> delegate;
- (SGTimelineEntry*)initWithDictionary: (NSDictionary*)dict andColor: (UIColor*)bgColor;
- (void)animateOn;
- (void)animateOff;
@end

@interface SGTimelinePopup : UIImageView

@end

@protocol SGTimelineEntryDelegate
- (void) timelineEntry: (SGTimelineEntry*)timelineEntry triggersNavToStr: (NSString*)navStr;
@end
