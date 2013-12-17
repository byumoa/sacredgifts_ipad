//
//  SGPaintingImageView.h
//  SacredGifts
//
//  Created by Ontario on 9/24/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPaintingImageViewDelegate.h"
@class SGPaintingImageView;

@interface SGPaintingImageView : UIImageView
@property (weak, nonatomic) UIViewController<SGPaintingImageViewDelegate>* delegate;
@property (nonatomic) BOOL isDown;
- (void)animateDownWithDelay: (float)delay;
- (void)animateUpWithDelay: (float)delay;
@end