//
//  SGViewController.m
//  SacredGifts
//
//  Created by Ontario on 8/27/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import "SGViewController.h"

const NSString* kPaintingNameChristAndTheRichYoungRulerStr = @"christ_and_the_rich_young_ruler";

@interface SGViewController ()
- (void)transitionToPainting: (const NSString*)paintingName;
@end

@implementation SGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIView animateWithDuration:0.5 animations:^{
        self.spalshImgView.alpha = 0;
    }];
}

@end
