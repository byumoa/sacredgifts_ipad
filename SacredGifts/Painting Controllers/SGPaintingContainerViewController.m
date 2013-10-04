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
