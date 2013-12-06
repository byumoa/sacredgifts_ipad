//
//  SGTimelineEntry.h
//  SacredGifts
//
//  Created by Ontario on 12/5/13.
//
//

#import <UIKit/UIKit.h>

@interface SGTimelineEntry : UIView
{
    NSString* _popup;
    NSString* _pageLink;
    CGRect _fullFrame;
}

- (SGTimelineEntry*)initWithDictionary: (NSDictionary*)dict andColor: (UIColor*)bgColor;
- (void)animateOn;
- (void)animateOff;
@end
