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

@implementation SGPaintingContainerViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    SGPaintingViewController* toController = [self.storyboard instantiateViewControllerWithIdentifier:(NSString*)kControllerIDPaintingStr];
    [self displayContentController:toController];
    toController.delegate = self;
}

-(UIViewController*)transitionFromController:(UIViewController *)fromController toPaintingNamed:(NSString *)paintingName fromButtonRect:(CGRect)frame withAnimType:(const NSString *)animType
{
    [self stopAudio];
    if( [fromController respondsToSelector:@selector(removeCurrentOverlay)] )
        [fromController performSelector:@selector(removeCurrentOverlay)];
    
    SGPaintingViewController* toController = [self.storyboard instantiateViewControllerWithIdentifier:(NSString*)kControllerIDPaintingStr];
    toController.delegate = self;
    toController.frameOverlayDelay = 0.5;
    
    NSString* headerName = [NSString stringWithFormat:@"header_%@", paintingName];
    
    ((SGPaintingViewController*)toController).headerTitleImgView = ((SGPaintingViewController*)self.currentContentController).headerTitleImgView;
    ((SGPaintingViewController*)self.currentContentController).headerTitleImgView.image = [UIImage imageNamed:headerName];
    
    int dir = animType == kAnimTypeSwipeLeft ? 1 : -1;
    
    if( [animType isEqualToString:(NSString*)kAnimTypeFade] )
    {
        toController.view.center = CGPointMake(768/2, 1024/2);
        animTransitionBlock = ^(void)
        {
            toController.view.alpha = 1;
            fromController.view.alpha = 0;
        };
    }
    else
    {
        CGPoint targetCenter = toController.view.center;
        CGPoint startCenter = targetCenter;
        startCenter.x += 768 * dir;
        CGPoint exitCenter = targetCenter;
        exitCenter.x -= 768 * dir;
        toController.view.center = startCenter;
        animTransitionBlock = ^(void)
        {
            toController.view.alpha = 1;
            fromController.view.alpha = 0;
            toController.view.alpha = 1;
            toController.view.center = targetCenter;
            fromController.view.center = exitCenter;
        };
    }
    
    [self cycleFromViewController:(UIViewController*)self.currentContentController toViewController:toController fromButtonRect:CGRectZero falling:kAnimTypeZoomIn];
    [toController configWithPaintingName:paintingName];
    ((SGPaintingViewController*)toController).headerView = ((SGPaintingViewController*)fromController).headerView;
    
    return toController;
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
