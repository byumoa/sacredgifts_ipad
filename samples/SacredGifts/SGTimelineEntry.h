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
}

- (SGTimelineEntry*)initWithDictionary: (NSDictionary*)dict;

@end
