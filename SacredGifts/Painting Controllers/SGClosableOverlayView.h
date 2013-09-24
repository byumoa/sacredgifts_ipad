//
//  SGClosableOverlayView.h
//  SacredGifts
//
//  Created by Ontario on 9/24/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGOverlayView.h"

@class SGClosableOverlayView;
@class SLComposeViewController;

@protocol SGClosableOverlayViewDelegate

- (void) overlayClosed: (SGClosableOverlayView*)overlay;
- (void) presentSocialViewController:(SLComposeViewController*)composeViewController;
- (void) dismissSocialMailController;

@end

@interface SGClosableOverlayView : SGOverlayView
@property (nonatomic, weak) UIButton* closeButton;
@property (nonatomic, weak) id<SGClosableOverlayViewDelegate> delegate;

- (void)pressedClose:(UIButton*)sender;

@end
