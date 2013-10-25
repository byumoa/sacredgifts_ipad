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

@interface SGChildrensOverlayViewController : SGOverlayViewController
@property(nonatomic, weak) IBOutlet SGFingerPaintView* fingerPaintView;
@property(nonatomic, weak) IBOutlet UIImageView* maskedImageView;
@property(nonatomic, strong) SGSecondaryOverlayViewController* currentSubOverlay;

- (void)addBackgroundImgWithPath: (NSString*)bgImgPath forgroundImage: (UIImage*)foregroundImg;

@end
