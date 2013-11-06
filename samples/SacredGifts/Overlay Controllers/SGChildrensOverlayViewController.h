//
//  SGChildrensOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGMediaSelectionViewController.h"
#import "SGFingerPaintView.h"
@class ScratchableView;

@interface SGChildrensOverlayViewController : SGMediaSelectionViewController
@property(nonatomic, strong) SGOverlayViewController* currentSubOverlay;
@property(nonatomic, weak) IBOutlet ScratchableView* scratchableView;

- (void)addBackgroundImgWithPath: (NSString*)bgImgPath forgroundImage: (UIImage*)foregroundImg;

@end
