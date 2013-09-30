//
//  SGOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/27/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayViewController.h"

@interface SGOverlayViewController ()

@end

@implementation SGOverlayViewController

- (void)addBackgroundImgWithPath: (NSString*)bgImgPath
{
    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:bgImgPath]];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.bgImageView.image.size.width, self.bgImageView.image.size.height);
    [self.view addSubview:self.bgImageView];
    self.view.center = _centerPos;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
