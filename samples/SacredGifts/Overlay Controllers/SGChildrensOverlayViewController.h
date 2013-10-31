//
//  SGChildrensOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayViewController.h"
#import "SGFingerPaintView.h"
#import "SGSecondaryOverlayViewController.h"
@class ScratchableView;

@interface SGChildrensOverlayViewController : SGOverlayViewController
@property(nonatomic, strong) SGSecondaryOverlayViewController* currentSubOverlay;
@property(nonatomic, weak) IBOutlet ScratchableView* scratchableView;

- (void)addBackgroundImgWithPath: (NSString*)bgImgPath forgroundImage: (UIImage*)foregroundImg;

@end
