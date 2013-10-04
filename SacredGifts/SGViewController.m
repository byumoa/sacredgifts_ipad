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
- (void)fadeSplash: (NSTimer*)timer;
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
    
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(fadeSplash:) userInfo:nil repeats:NO];
    }
}

-(void)fadeSplash:(NSTimer *)timer
{
    [UIView animateWithDuration:0.5 animations:^{
        self.splash.alpha = 0;
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( self.splash.alpha > 0 )
        [self fadeSplash:nil];
}

@end
