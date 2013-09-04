//
//  SGParallaxManager.m
//  SacredGifts
//
//  Created by Ontario on 9/3/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import "SGParallaxManager.h"
#import "SGOverlayView.h"

@interface SGParallaxManager ( PrivateMethods )
- (void) resetBlurredImages;
@end

@implementation SGParallaxManager
@synthesize sharedBlurredImg = _sharedBlurredImg;

-(void)setSharedBlurredImg:(UIImage *)sharedBlurredImg{
    _sharedBlurredImg = sharedBlurredImg;
    [self resetBlurredImages];
}

-(void)addOverlay:(SGOverlayView *)overlay{
    [m_parallaxingOverlays addObject:overlay];
    overlay.blurredOverlay.image = self.sharedBlurredImg;
    CGRect frame = overlay.blurredOverlay.frame;
    frame.size = self.sharedBlurredImg.size;
    overlay.blurredOverlay.frame = frame;
}

-(void)resetBlurredImages{
    for( SGOverlayView* overlay in m_parallaxingOverlays ){
        overlay.blurredOverlay.image = self.sharedBlurredImg;
        CGRect frame = overlay.blurredOverlay.frame;
        frame.size = self.sharedBlurredImg.size;
        overlay.blurredOverlay.frame = frame;
    }
}

@end
