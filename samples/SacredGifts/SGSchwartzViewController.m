//
//  SGSchwartzViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/9/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGSchwartzViewController.h"

@interface SGSchwartzViewController ()

@end

@implementation SGSchwartzViewController

-(void)loadView
{
    [super loadView];
    
    _scrollContentSize = CGSizeMake(768, 1470);
    self.screenName = @"schwartz bio";
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _narrationStr = @"Schwartz Bio.mp3";
}

@end
