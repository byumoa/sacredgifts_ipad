//
//  SGPaintingImageView.h
//  SacredGifts
//
//  Created by Ontario on 9/24/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SGPaintingImageView;

@protocol SGPaintingImageViewDelegate <NSObject>
- (void)paintingTapped: (SGPaintingImageView*) paintingView;
@end

@interface SGPaintingImageView : UIImageView
@property (weak, nonatomic) UIViewController<SGPaintingImageViewDelegate>* delegate;
@property (nonatomic) BOOL isDown;
- (void)animateDownWithDelay: (float)delay;
- (void)animateUpWithDelay: (float)delay;
@end