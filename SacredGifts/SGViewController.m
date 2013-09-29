//
//  SGViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGViewController.h"
#import "SGHomeViewController.h"
#import "SGConstants.h"

@interface SGViewController ()

@end

@implementation SGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        SGHomeViewController* homeC = [self.storyboard instantiateViewControllerWithIdentifier:(NSString*)kControllerIDHomeStr];
        homeC.delegate = self;
    
        [self displayContentController:homeC];
    
        [UIView animateWithDuration:1.0 animations:^{
            self.splash.alpha = 0;
        }];
    }
}

@end
