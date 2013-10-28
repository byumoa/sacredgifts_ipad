//
//  SGHighlightsViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/25/13.
//
//

#import "SGHighlightsViewController.h"
#import "SGPanoramaOverlayViewController.h"
#import "SGVideoOverlayViewController.h"
#import "SGAudioViewController.h"

@interface SGHighlightsViewController ()
- (void)loadPanoramaWithFolderPath: (NSString*)panoFolderPath;
- (void)loadVideoWithFolderPath: (NSString*)videoFolderPath;
- (void)loadAudioWithFolderPath: (NSString*)audioFolderPath;
- (void)loadTextWithFolderPath: (NSString*)textFolderPath;
@end

@implementation SGHighlightsViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 670);
        self.moduleType = kModuleTypeHighlights;
    }
    
    return self;
}

-(void)configureWithPath:(NSString *)folderPath
{
    self.rootFolderPath = folderPath;
    for( int i = 1; i <= 10; i++ )
    {
        NSString* buttonConfigDir = [NSString stringWithFormat:@"%@/highlights_%i", folderPath, i];
        
        NSString* buttonConfigPath = [[NSBundle mainBundle] pathForResource:@"ButtonPlacement" ofType:@"plist" inDirectory:buttonConfigDir];
        
        if( buttonConfigPath )
        {
            NSDictionary* buttonDict = [NSDictionary dictionaryWithContentsOfFile:buttonConfigPath];
            UIButton* button = [self buttonForHighlightIndex:i];
            button.center = CGPointMake([[buttonDict objectForKey:@"xPos"] intValue], [[buttonDict objectForKey:@"yPos"] intValue]);
            [self.view addSubview:button];
        }
        else
            break;
    }
}

-(UIButton *)buttonForHighlightIndex:(int)highlightIndex
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* normalBtnImg = [UIImage imageNamed:@"childrens_btn-on.png"];
    UIImage* highlightBtnImg = [UIImage imageNamed:@"childrens_btn.png"];
    [button setImage:normalBtnImg forState:UIControlStateNormal];
    [button setImage:highlightBtnImg forState:UIControlStateHighlighted];
    
    button.frame = CGRectMake(0, 0, normalBtnImg.size.width, normalBtnImg.size.height);
    button.tag = highlightIndex;
    [button addTarget:self action:@selector(pressedHighlightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

-(void)pressedHighlightBtn:(UIButton *)sender
{
    NSString* btnFolderPath = [NSString stringWithFormat:@"%@/highlights_%i", self.rootFolderPath, sender.tag];
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
    NSLog(@"loadPanoramaWithFolderPath: %@", panoFolderPath);
    [overlay addBackgroundImgWithPath:overlayPath];
    overlay.rootFolderPath = panoFolderPath;
    [((SGPanoramaOverlayViewController*)overlay) startPanoWithPath:panoFolderPath];
}

-(void)loadVideoWithFolderPath:(NSString *)videoFolderPath
{
    SGOverlayViewController* overlay = [self.delegate overlay:self triggersNewOverlayName:(NSString*)kVideoStr];
    NSString *overlayPath = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@"png" inDirectory:videoFolderPath];
    NSLog(@"loadVideoWithFolderPath: %@", videoFolderPath);
    [overlay addBackgroundImgWithPath:overlayPath];
    [((SGVideoOverlayViewController*)overlay) playPerspectiveMovieWithRootFolderPath:videoFolderPath];
}

-(void)loadAudioWithFolderPath:(NSString *)audioFolderPath
{
    SGOverlayViewController* overlay = [self.delegate overlay:self triggersNewOverlayName:(NSString*)kAudioStr];
    NSString *overlayPath = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@"png" inDirectory:audioFolderPath];
    NSLog(@"loadAudioWithFolderPath: %@", audioFolderPath);
    [overlay addBackgroundImgWithPath:overlayPath];
    [((SGAudioViewController*)overlay) configureAudioWithPath:audioFolderPath];
}

-(void)loadTextWithFolderPath:(NSString *)textFolderPath
{
    SGOverlayViewController* overlay = [self.delegate overlay:self triggersNewOverlayName:(NSString*)kTextStr];
    NSString *overlayPath = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@"png" inDirectory:textFolderPath];
    NSLog(@"loadTextWithFolderPath: %@", textFolderPath);
    [overlay addBackgroundImgWithPath:overlayPath];
}

@end
