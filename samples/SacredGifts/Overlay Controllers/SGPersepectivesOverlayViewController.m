//
//  SGPersepectivesOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGPersepectivesOverlayViewController.h"
#import "SGSermonShapesOverlayViewController.h"

@interface SGPersepectivesOverlayViewController ()
- (UIButton*)buttonForPerspectiveNumber: (int)perspectiveIndex atPath: (NSString*)folderPath;
- (void)pressedPerspectiveBtn: (UIButton*)sender;
- (void)loadComposition;
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

-(int)configurePerspectiveOverlayWithPath:(NSString *)folderPath
{
    self.rootFolderPath = folderPath;
    for( int i = 1; i <= 7; i++ )
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
            return i-1;
    }
    
    return 0;
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
    if( [self.paintingName isEqualToString:@"sermon"] && sender.tag == 3){
        [self loadComposition];
        return;     }
    
    NSString* btnFolderPath = [NSString stringWithFormat:@"%@perspectives_%i", self.rootFolderPath, sender.tag];
    NSString* panoPath = [[NSBundle mainBundle] pathForResource:@"pano_b" ofType:@"jpg" inDirectory:btnFolderPath];
    NSString* videoPath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4" inDirectory:btnFolderPath];
    NSString* audioPath = [[NSBundle mainBundle] pathForResource:@"audio" ofType:@"mp3" inDirectory:btnFolderPath];
    
    if( panoPath )
        [self loadPanoramaWithFolderPath:btnFolderPath].screenName = [NSString stringWithFormat:@"%@: persp panorama", self.paintingName];
    else if( videoPath )
        [self loadVideoWithFolderPath:btnFolderPath].screenName = [NSString stringWithFormat:@"%@: persp video", self.paintingName];
    else if( audioPath )
        [self loadAudioWithFolderPath:btnFolderPath].screenName = [NSString stringWithFormat:@"%@: persp audio", self.paintingName];
    else
        [self loadTextWithFolderPath:btnFolderPath].screenName = [NSString stringWithFormat:@"%@: persp text", self.paintingName];
}

-(void)loadComposition
{
    NSString* btnFolderPath = [NSString stringWithFormat:@"%@perspectives_%i", self.rootFolderPath, 3];
    SGOverlayViewController* overlay = [self addChildOverlay:@"composition"];
    overlay.view.frame = CGRectMake(0, -self.view.frame.origin.y - 50, 768, 1024);
    self.childOverlay.rootFolderPath = btnFolderPath;
}

@end
