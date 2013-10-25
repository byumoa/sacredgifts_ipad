//
//  SGPersepectivesOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGPersepectivesOverlayViewController.h"
#import "SGVideoOverlayViewController.h"
#import "SGAudioViewController.h"
#import "SGEAGLView.h"
#import "SGPanoramaOverlayViewController.h"

@interface SGPersepectivesOverlayViewController ()
- (UIButton*)buttonForPerspectiveNumber: (int)perspectiveIndex atPath: (NSString*)folderPath;
- (void)pressedPerspectiveBtn: (UIButton*)sender;
- (void)loadPanoramaWithFolderPath: (NSString*)panoFolderPath;
- (void)loadVideoWithFolderPath: (NSString*)videoFolderPath;
- (void)loadAudioWithFolderPath: (NSString*)audioFolderPath;
- (void)loadTextWithFolderPath: (NSString*)textFolderPath;
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
    NSString* panoPath = [[NSBundle mainBundle] pathForResource:@"pano_b" ofType:@"jpg" inDirectory:btnFolderPath];
    NSString* videoPath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4" inDirectory:btnFolderPath];
    NSString* audioPath = [[NSBundle mainBundle] pathForResource:@"audio" ofType:@"mp3" inDirectory:btnFolderPath];
    
    if( panoPath )
        [self loadPanoramaWithFolderPath:btnFolderPath];
    else if( videoPath )
        [self loadVideoWithFolderPath:btnFolderPath];
    else if( audioPath )
        [self loadAudioWithFolderPath:btnFolderPath];
    else
        [self loadTextWithFolderPath:btnFolderPath];
}

-(void)loadPanoramaWithFolderPath:(NSString *)panoFolderPath
{
    SGOverlayViewController* overlay = [self.delegate overlay:self triggersNewOverlayName:(NSString*)kPanoramaStr];
    NSString *overlayPath = [[NSBundle mainBundle] pathForResource:@"pano_f" ofType:@"jpg" inDirectory:panoFolderPath];
    [overlay addBackgroundImgWithPath:overlayPath];
    overlay.rootFolderPath = panoFolderPath;
    [((SGPanoramaOverlayViewController*)overlay) startPanoWithPath:panoFolderPath];
}

-(void)loadVideoWithFolderPath:(NSString *)videoFolderPath
{
    SGOverlayViewController* overlay = [self.delegate overlay:self triggersNewOverlayName:(NSString*)kVideoStr];
    
    NSString *overlayPath = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@"png" inDirectory:videoFolderPath];
    [overlay addBackgroundImgWithPath:overlayPath];
    [((SGVideoOverlayViewController*)overlay) playPerspectiveMovieWithRootFolderPath:videoFolderPath];
}

-(void)loadAudioWithFolderPath:(NSString *)audioFolderPath
{
    SGOverlayViewController* overlay = [self.delegate overlay:self triggersNewOverlayName:(NSString*)kAudioStr];
    
    NSString *overlayPath = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@"png" inDirectory:audioFolderPath];
    [overlay addBackgroundImgWithPath:overlayPath];
    [((SGAudioViewController*)overlay) configureAudioWithPath:audioFolderPath];
}

-(void)loadTextWithFolderPath:(NSString *)textFolderPath
{
    SGOverlayViewController* overlay = [self.delegate overlay:self triggersNewOverlayName:(NSString*)kTextStr];
    NSString *overlayPath = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@"png" inDirectory:textFolderPath];
    [overlay addBackgroundImgWithPath:overlayPath];
}

@end
