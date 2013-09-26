//
//  SGContentViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGContentViewController.h"
#import "SGBlurManager.h"
#import "SGConstants.h"

const CGRect headerBackerFrame = {0,0,768,62};

@implementation SGContentViewController

-(void)viewDidLoad
{    
    [super viewDidLoad];
    
    SGBlurManager* blurManager = [SGBlurManager sharedManager];
    [[SGBlurManager sharedManager] setBlurImageWithName:(NSString*)_blurImageName andFrame:kBlurFrame];

    NSArray* containersBlurredViews = [self.delegate viewsForBlurredBackingInController:self];
    _allBlurredViews = [NSMutableArray new];
    [_allBlurredViews addObjectsFromArray:containersBlurredViews];
    [_allBlurredViews addObjectsFromArray:self.blurredViews];
    
    for( UIView* blurredView in _allBlurredViews )
    {
        UIView* blurBacking = [blurManager blurBackingForView:blurredView];
        [self.view insertSubview:blurBacking belowSubview:blurredView];
    }
}

@end
