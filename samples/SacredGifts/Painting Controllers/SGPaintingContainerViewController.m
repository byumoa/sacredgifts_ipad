//
//  SGPaintingContainerViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/23/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGPaintingContainerViewController.h"
#import "SGPaintingViewController.h"
#import "SGConstants.h"
#import "SGMusicManager.h"

@implementation SGPaintingContainerViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    SGPaintingViewController* toController = [self.storyboard instantiateViewControllerWithIdentifier:(NSString*)kControllerIDPaintingStr];
    [self displayContentController:toController];
    toController.delegate = self;
}

-(void)transitionFromController:(UIViewController *)fromController toPaintingNamed:(NSString *)paintingName fromButtonRect:(CGRect)frame withAnimType:(const NSString *)animType
{
    SGMusicManager* musicManager = [SGMusicManager sharedManager];
    [musicManager pauseAudio];
    
    SGPaintingViewController* toController = [self.storyboard instantiateViewControllerWithIdentifier:(NSString*)kControllerIDPaintingStr];
    toController.delegate = self;
    toController.frameOverlayDelay = 0.5;
 
    int dir = animType == kAnimTypeSwipeLeft ? 1 : -1;
    
    CGPoint targetCenter = toController.view.center;
    CGPoint startCenter = targetCenter;
    startCenter.x += 768 * dir;
    CGPoint exitCenter = targetCenter;
    exitCenter.x -= 768 * dir;
    toController.view.center = startCenter;
    animTransitionBlock = ^(void){
        toController.view.alpha = 1;
        toController.view.center = targetCenter;
        fromController.view.center = exitCenter;
    };
    
    [self cycleFromViewController:(UIViewController*)self.currentContentController toViewController:toController fromButtonRect:CGRectZero falling:kAnimTypeZoomIn];
    [toController configWithPaintingName:paintingName];
}

-(void)contentController:(UIViewController *)contentController viewsForBlurredBacking:(NSArray*)views blurredImgName:(NSString *)blurredImgName
{
    _allBlurredViews = [NSMutableArray new];
    [super contentController:contentController viewsForBlurredBacking:views blurredImgName:blurredImgName];
}

-(void)contentController:(UIViewController *)contentController viewsForBlurredBacking:(NSArray *)views blurredImgPath:(NSString *)blurredImgPath
{
    _allBlurredViews = [NSMutableArray new];
    [super contentController:contentController viewsForBlurredBacking:views blurredImgPath:blurredImgPath];
}

@end
