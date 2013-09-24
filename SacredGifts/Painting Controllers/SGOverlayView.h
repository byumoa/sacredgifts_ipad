//
//  SGOverlayView.h
//  SacredGifts
//
//  Created by Ontario on 9/24/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGConstants.h"

@interface SGOverlayView : UIView

@property(nonatomic) CGSize parallaxOffset;
@property(nonatomic) CGPoint blurredImageCenter;
@property (nonatomic, strong) UIImageView *blurredOverlay;

- (void)fadeIn;
- (void)fadeOut;
- (void)turnOffNoFade;
- (void)dismissWithAnim: (OverlayAnimation)overlayAnim;
- (void)animateOnWithPaintingTargetSize: (CGSize)targetSize;
- (void)animateOffWithPaintingTargetSize: (CGSize)targetSize;

@end
