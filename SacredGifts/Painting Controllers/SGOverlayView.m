//
//  SGOverlayView.m
//  SacredGifts
//
//  Created by Ontario on 9/24/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayView.h"

@interface SGOverlayView()
- (void)setupView;
@end

@implementation SGOverlayView
@synthesize blurredOverlay = _blurredOverlay;

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        [self setupView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if( self = [super initWithFrame:frame]){
        [self setupView];
    }
    return self;
}

-(id)init{
    if( self = [super init]){
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    self.autoresizesSubviews = YES;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"SG_General_BG_Pattern_Blur.png"]];
    self.blurredOverlay = [UIImageView new];
    self.blurredOverlay.contentMode = UIViewContentModeScaleAspectFill;
    self.blurredOverlay.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self insertSubview:self.blurredOverlay atIndex:0];
}

-(void)animateOnWithPaintingTargetSize:(CGSize)targetSize
{
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x - 80, frame.origin.y - 160, frame.size.width + 160, frame.size.height + 160);
    self.alpha = 0;
    self.blurredOverlay.alpha = 0;
    CGRect blurredOriginalFrame = self.blurredOverlay.frame;
    CGPoint blurredCenter = self.blurredOverlay.center;
    blurredCenter.y += 40;
    self.blurredOverlay.center = blurredCenter;
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = frame;
        self.alpha = 1;
        CGRect bof = blurredOriginalFrame;
        bof.size = targetSize;
        bof.origin.x += 20;
        bof.origin.y += 20;
        self.blurredOverlay.frame = bof;
        self.blurredOverlay.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            UIButton* closeBtn = (UIButton*)[self viewWithTag:9876];
            closeBtn.alpha = 1;
            [self bringSubviewToFront:closeBtn];
        }];
    }];
}

- (void)animateOffWithPaintingTargetSize: (CGSize)targetSize{}

- (void)fadeIn
{
    [UIView animateWithDuration:0.8 animations:^{
        self.alpha = 1.0;
    }];
}

-(void)fadeOut
{
    [UIView animateWithDuration:0.8 animations:^{
        self.alpha = 0.0;
    }];
}

-(void)turnOffNoFade
{
    self.alpha = 0.0;
}

-(void)dismissWithAnim:(OverlayAnimation)overlayAnim
{
    [self removeFromSuperview];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetPatternPhase(context, self.parallaxOffset);
    
    CGColorRef color = self.backgroundColor.CGColor;
    CGContextSetFillColorWithColor(context, color);
    CGContextFillRect(context, self.bounds);
    
    CGContextRestoreGState(context);
}

@end
