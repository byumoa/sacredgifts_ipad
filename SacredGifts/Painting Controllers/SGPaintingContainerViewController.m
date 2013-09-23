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
    
    SGPaintingViewController* toController = [self.storyboard instantiateViewControllerWithIdentifier:(NSString *)kControllerIDPaintingStr];
    [self displayContentController:toController];
}

-(void)configWithInfo:(NSDictionary *)userInfo
{
    //Get config working now!
    
}

@end
