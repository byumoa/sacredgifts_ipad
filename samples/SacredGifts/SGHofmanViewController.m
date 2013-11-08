//
//  SGHofmanViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/9/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGHofmanViewController.h"

@interface SGHofmanViewController ()

@end

@implementation SGHofmanViewController

-(void)loadView
{
    [super loadView];
    
    _scrollContentSize = CGSizeMake(768, 1320);
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _narrationStr = @"Hofman Bio.mp3";
}

@end
