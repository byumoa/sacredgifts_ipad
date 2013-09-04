//
//  SGPaintingImageView.h
//  SacredGifts
//
//  Created by Ontario on 8/28/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SGPaintingImageView;

@protocol SGPaintingImageViewDelegate <NSObject>
- (void)paintingTapped: (SGPaintingImageView*) paintingView;
@end

@interface SGPaintingImageView : UIImageView
@property (weak, nonatomic) UIViewController<SGPaintingImageViewDelegate>* delegate;
@property (nonatomic) BOOL isDown;
- (void)animateDown;
- (void)animateUp;
@end
