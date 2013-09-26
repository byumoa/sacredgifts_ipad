//
//  SGContentViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGContentViewController.h"

const CGRect headerBackerFrame = {0,0,768,62};

@implementation SGContentViewController

-(void)viewDidLoad
{    
    [super viewDidLoad];
    
    [self.delegate contentController:self viewsForBlurredBacking:self.blurredViews blurredImgName:_blurImageName];
}

@end
