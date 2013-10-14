//
//  SGBlurManager.m
//  SacredGifts
//
//  Created by Ontario on 9/25/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGBlurManager.h"

const CGRect kBlurredPaintingFrame = {0,62,768,892};

@implementation SGBlurManager

+(id)sharedManager
{
    static SGBlurManager *sharedSGBlurManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedSGBlurManager = [self new];
    });
    
    return  sharedSGBlurManager;
}

-(void)setBlurImageWithName:(NSString *)imageNameStr andFrame:(CGRect)frame{
    _currentBlurImg = [UIImage imageNamed:imageNameStr];
    _blurFrame = frame;
}

-(void)setBlurImageWithPath:(NSString *)imagePathStr
{
    _currentBlurImg = [UIImage imageWithContentsOfFile:imagePathStr];
    _blurFrame = kBlurredPaintingFrame;
}

-(UIView *)blurBackingForView:(UIView *)view
{
    UIView* blurBacking = [UIView new];
    blurBacking.clipsToBounds = YES;
    blurBacking.frame = view.frame;
    blurBacking.backgroundColor = [UIColor clearColor];
    
    UIImageView* blurImageView = [[UIImageView alloc] initWithImage:_currentBlurImg];
    [blurBacking addSubview:blurImageView];
    CGPoint blurOffset;
    blurOffset.x = _blurFrame.origin.x - view.frame.origin.x;
    blurOffset.y = _blurFrame.origin.y - view.frame.origin.y;
    blurImageView.frame = CGRectMake(blurOffset.x, blurOffset.y, blurImageView.frame.size.width, blurImageView.frame.size.height);
    
    return blurBacking;
}

@end
