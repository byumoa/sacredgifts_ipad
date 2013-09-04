//
//  SGParallaxManager.h
//  SacredGifts
//
//  Created by Ontario on 9/3/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SGOverlayView;

@interface SGParallaxManager : NSObject{
    NSMutableArray* m_parallaxingOverlays;
}

@property(nonatomic, weak) UIImage* sharedBlurredImg;
- (void) addOverlay: (SGOverlayView*)overlay;
@end
