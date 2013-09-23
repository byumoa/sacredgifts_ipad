//
//  SGContainerViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/23/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGContainerViewController.h"
#import "SGContentViewController.h"

@implementation SGContainerViewController

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

@end
