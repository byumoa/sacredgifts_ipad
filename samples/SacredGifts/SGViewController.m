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
{
    NSTimer* _donorsTimer;
    NSTimer* _splashTimer;
}
- (void)fadeSplash: (NSTimer*)timer;
- (void)fadeInDonors: (NSTimer*)timer;
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
        [self resetSplash];
    }
}

-(void)pressedBack:(UIButton *)sender
{
    if( [self.currentContentController.restorationIdentifier isEqualToString:(NSString*)kControllerIDHomeStr])
        [self resetSplash];
    else
        [super pressedBack:sender];
}

-(void)resetSplash
{
    NSLog(@"resetSplash self.splashArtists: %@", self.splashArtists);
    [self.view bringSubviewToFront:_splash];
    [self.view bringSubviewToFront:_splashArtists];
    [self.view bringSubviewToFront:_splashDonors];
    _splash.alpha = 1;
    
    [UIView animateWithDuration:1 animations:^{
        self.splashArtists.alpha = 1;
    }];
    
    _donorsTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(fadeInDonors:) userInfo:nil repeats:NO];
    _splashTimer = [NSTimer scheduledTimerWithTimeInterval:63 target:self selector:@selector(fadeSplash:) userInfo:nil repeats:NO];
}

-(void)fadeInDonors:(NSTimer *)timer
{
    [_donorsTimer invalidate];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.splashDonors.alpha = 1;
    }];
}

-(void)fadeSplash:(NSTimer *)timer
{
    [_splashTimer invalidate];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.splash.alpha = 0;
        self.splashArtists.alpha = 0;
        self.splashDonors.alpha = 0;
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( self.splash.alpha == 1 && self.splashDonors.alpha == 0 )
        [self fadeInDonors:nil];
    else if( self.splash.alpha > 0 )
        [self fadeSplash:nil];
}
@end
