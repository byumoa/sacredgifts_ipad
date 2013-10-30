//
//  SGOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/27/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayViewController.h"

@interface SGOverlayViewController ()
- (void)configureBGImage;
@end

@implementation SGOverlayViewController
@synthesize rootFolderPath = _rootFolderPath;

- (void)addBackgroundImgWithPath: (NSString*)bgImgPath
{
    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:bgImgPath]];
    [self configureBGImage];
}

-(void)addBackgroundImgWithImgName:(NSString *)bgImgName
{
    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bgImgName]];
    [self configureBGImage];
}

-(void)configureBGImage
{
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.bgImageView.image.size.width, self.bgImageView.image.size.height);
    [self.view insertSubview:self.bgImageView atIndex:0];
    self.view.center = _centerPos;
    
    //Place view 41px above footer bar
    if( self.moduleType != kModuleTypeChildrens )
    {
        int yHeight = 1024 - 70 - 41 - self.view.frame.size.height/2;
        self.view.center = CGPointMake(768/2, yHeight);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.closeButton = [self createCloseButton];
    [self.view addSubview:self.closeButton];
}

-(UIButton *)createCloseButton
{
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* closeBtnNrmImg = [UIImage imageNamed:@"SG_General_Module_CloseBtn.png"];
    UIImage* closeBtnHilImg = [UIImage imageNamed:@"SG_General_Module_CloseBtn-on.png"];
    
    [closeButton setImage:closeBtnNrmImg forState:UIControlStateNormal];
    [closeButton setImage:closeBtnHilImg forState:UIControlStateHighlighted];
    
    [closeButton addTarget:self action:@selector(pressedClose:) forControlEvents:UIControlEventTouchUpInside];
    
    return closeButton;
}

-(void)pressedClose:(UIButton *)sender
{
    NSLog(@"pressedClose");
}
@end
