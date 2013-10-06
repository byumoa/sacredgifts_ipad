//
//  SGPersepectivesOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGPersepectivesOverlayViewController.h"
#import "SGVideoOverlayViewController.h"

@interface SGPersepectivesOverlayViewController ()
- (UIButton*)buttonForPerspectiveNumber: (int)perspectiveIndex atPath: (NSString*)folderPath;
- (void)pressedPerspectiveBtn: (UIButton*)sender;
- (void)loadPanoramaWithFolderPath: (NSString*)panoFolderPath;
- (void)loadVideoWithFolderPath: (NSString*)videoFolderPath;
@end

@implementation SGPersepectivesOverlayViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 700);
        self.moduleType = kModuleTypePerspective;
    }
    
    return self;
}

-(void)configurePerspectiveOverlayWithPath:(NSString *)folderPath
{
    self.rootFolderPath = folderPath;
    for( int i = 1; i <= 6; i++ )
    {
        NSString* buttonName = [NSString stringWithFormat:@"perspectives_Btn%i", i];
        NSString* buttonPath = [[NSBundle mainBundle] pathForResource:buttonName ofType:@"png" inDirectory:folderPath];
     
        if( buttonPath )
        {
            UIButton* button = [self buttonForPerspectiveNumber:i atPath:folderPath];
            CGPoint center = CGPointMake(155 + 230 * ((i-1) % 3), 125 + 170 * ((i-1)/3));
            button.center = center;
            [self.view addSubview:button];
        }
        else
            break;
    }
}

-(UIButton *)buttonForPerspectiveNumber:(int)perspectiveIndex atPath:(NSString *)folderPath
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString* btnImgName = [NSString stringWithFormat:@"perspectives_Btn%i", perspectiveIndex];
    NSString* btnPath = [[NSBundle mainBundle] pathForResource:btnImgName ofType:@"png" inDirectory:folderPath];
    UIImage* btnImage = [UIImage imageWithContentsOfFile:btnPath];
    [button setImage:btnImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, btnImage.size.width, btnImage.size.height);
    button.tag = perspectiveIndex;
    [button addTarget:self action:@selector(pressedPerspectiveBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

-(void)pressedPerspectiveBtn:(UIButton *)sender
{
    NSString* btnFolderPath = [NSString stringWithFormat:@"%@perspectives_%i", self.rootFolderPath, sender.tag];
    NSLog(@"pressedPerspectiveBtn, btnFolderPath: %@", btnFolderPath);
    NSString* btnPath = [[NSBundle mainBundle] pathForResource:@"panorama" ofType:@"png" inDirectory:btnFolderPath];
    
    if( btnPath )
        [self loadPanoramaWithFolderPath:btnFolderPath];
    else{
        btnPath = [[NSBundle mainBundle] pathForResource:@"perspectives_video" ofType:@"mov" inDirectory:btnFolderPath];
        if( btnPath )
            [self loadVideoWithFolderPath:btnFolderPath];
    }
}

-(void)loadPanoramaWithFolderPath:(NSString *)panoFolderPath
{
    NSLog(@"Panorama: %@", panoFolderPath);
}

-(void)loadVideoWithFolderPath:(NSString *)videoFolderPath
{
    NSLog(@"Video: %@", videoFolderPath);
    SGOverlayViewController* overlay = [self.delegate overlay:self triggersNewOverlayName:(NSString*)kVideoStr];
    //Dir: PaintingResources/consolator/perspectives/perspectives_3/
    NSString* folder = @"perspectives_3";
    NSString *overlayPath = [[NSBundle mainBundle] pathForResource:@"perspectives_video_overlay" ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@", self.rootFolderPath, folder]];
    [overlay addBackgroundImgWithPath:overlayPath];
    [((SGVideoOverlayViewController*)overlay) playPerspectiveMovieWithRootFolderPath:videoFolderPath];
}

@end
