//
//  SGFindAPaintingViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGFindAPaintingViewController.h"
#import "SGConstants.h"

@implementation SGFindAPaintingViewController

-(void)viewDidLoad
{
    _blurImageName = @"sg_home_bg-findpainting_blur.png";
    [super viewDidLoad];
}

- (IBAction)touchedPainting:(UIButton *)sender
{
    NSString* paintingName = (NSString*)kPaintingNames[sender.tag-1];
    [self.delegate transitionFromController:self toPaintingNamed:paintingName fromButtonRect:sender.frame withAnimType:kAnimTypeZoomIn];
}
@end
