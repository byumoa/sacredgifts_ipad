//
//  SGOverlayView.m
//  SacredGifts
//
//  Created by Ontario on 10/7/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayView.h"

@implementation SGOverlayView

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nextResponder touchesMoved:touches withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        for (UIView *subview in self.subviews.reverseObjectEnumerator) {
            CGPoint subPoint = [subview convertPoint:point fromView:self];
            UIView *result = [subview hitTest:subPoint withEvent:event];
            if (result != nil) {
                return result;
                break;
            }
        }
    }
    
    // use this to pass the 'touch' onward in case no subviews trigger the touch
    return [super hitTest:point withEvent:event];
}

@end
