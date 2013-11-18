//
//  SGContainerViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/23/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGContainerViewController.h"
#import "SGContentViewController.h"
#import "SGBlurManager.h"
#import "SGConstants.h"
#import "SGOverlayView.h"
#import "SGMusicManager.h"
#import "SGNarrationManager.h"

@interface SGContainerViewController(BlurUtlities)

- (void)insertBlursForViews: (NSArray*)views;
- (void)insertBlurForView: (UIView*)view;
- (void)removeBlurForView: (UIView*)view;

@end

@implementation SGContainerViewController

-(void)stopAudio
{
    SGMusicManager* musicManager = [SGMusicManager sharedManager];
    [musicManager pauseAudio];
    SGNarrationManager* narrationManager = [SGNarrationManager sharedManager];
    [narrationManager pauseAudio];
}

#pragma mark Navigation
-(void)displayContentController:(UIViewController *)content
{
    self.currentContentController = (SGContentViewController*)content;
    [self addChildViewController:content];
    content.view.frame = self.view.frame;
    [self.view insertSubview:content.view atIndex:0];
    [content didMoveToParentViewController:self];
}

- (void)cycleFromViewController: (UIViewController*)oldC toViewController: (UIViewController*)newC fromButtonRect:(CGRect)frame falling:(const NSString *)animType
{
    [oldC willMoveToParentViewController:nil];
    [self addChildViewController:newC];
    self.currentContentController = (SGContentViewController*)newC;
    newC.view.alpha = 0;
    
    [self transitionFromViewController:oldC toViewController:newC duration:0.25 options:0 animations: animTransitionBlock completion:^(BOOL finished) {
        [oldC removeFromParentViewController];
        [newC didMoveToParentViewController:self];
    }];
}

-(void)contentController:(UIViewController *)contentController viewsForBlurredBacking:(NSArray*)views blurredImgName:(NSString *)blurredImgName
{
    [[SGBlurManager sharedManager] setBlurImageWithName:blurredImgName andFrame:kBlurFrame];
    [self insertBlursForViews:views];
}

-(void)contentController:(UIViewController *)contentController viewsForBlurredBacking:(NSArray *)views blurredImgPath:(NSString *)blurredImgPath
{
    [[SGBlurManager sharedManager] setBlurImageWithPath:blurredImgPath];
    [self insertBlursForViews:views];
}

-(void)insertBlursForViews:(NSArray *)views
{
    [_allBlurredViews addObjectsFromArray:views];
    
    for( UIView* blurredView in _allBlurredViews ){
        UIView* blurBacking = [[SGBlurManager sharedManager] blurBackingForView:blurredView];
        if( [blurredView isKindOfClass:[SGOverlayView class]])
            ((SGOverlayView*)blurredView).myBlurredBacking = blurBacking;

        [self.currentContentController.view insertSubview:blurBacking belowSubview:blurredView];
        if( [self.currentContentController respondsToSelector:@selector(parallaxViews)])
            [self.currentContentController.parallaxViews addObject:blurBacking.subviews[0]];
    }
}

-(void)contentController:(UIViewController *)contentController addBlurBackingForView:(UIView *)view
{
    UIView* blurBacking = [[SGBlurManager sharedManager] blurBackingForView:view];
    if( [view isKindOfClass:[SGOverlayView class]])
        ((SGOverlayView*)view).myBlurredBacking = blurBacking;
    
    [self.currentContentController.view insertSubview:blurBacking belowSubview:view];
    if( [self.currentContentController respondsToSelector:@selector(parallaxViews)])
        [self.currentContentController.parallaxViews addObject:blurBacking.subviews[0]];
}

-(void)contentController:(UIViewController *)contentController removeBlurBacking:(UIView *)view{}

@end
