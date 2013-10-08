//
//  FingerPaintView.h
//  PlayingWithTabs
//
//  Created by Ontario on 9/12/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGFingerPaintView : UIView
{
    CGPoint _firstTouchPt;
    NSMutableArray* _allTouches;
}
@property (nonatomic, weak) IBOutlet UIImageView *maskThis;
@property (nonatomic) CGImageRef originalImage;

- (CGImageRef)drawImageWithContext:(CGContextRef)context inRect:(CGRect)rect;


@end
