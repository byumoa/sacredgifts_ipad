//
//  SGBlochViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/9/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGBlochViewController.h"
#import "SGConstants.h"

@interface SGBlochViewController ()

@end

@implementation SGBlochViewController

-(void)loadView
{
    [super loadView];
    
    _scrollContentSize = CGSizeMake(768, 1530);
    self.screenName = @"bloch bio";
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _narrationStr = @"Bloch Bio.mp3";
}

- (IBAction)pressedCastle:(UIButton *)sender
{
    [self.delegate transitionFromController:self toPaintingNamed:@"castle" fromButtonRect:sender.frame withAnimType:kAnimTypeZoomIn];
}
@end
