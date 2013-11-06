//
//  SGMediaSelectionViewController.m
//  SacredGifts
//
//  Created by Ontario on 11/6/13.
//
//

#import "SGMediaSelectionViewController.h"
#import "SGVideoOverlayViewController.h"
#import "SGNarrationOverlayViewController.h"
#import "SGPanoramaOverlayViewController.h"

@implementation SGMediaSelectionViewController

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
    SGOverlayViewController* overlay = [self.delegate overlay:self triggersNewOverlayName:(NSString*)kNarrationStr];
    NSString *overlayPath = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@"png" inDirectory:audioFolderPath];
    [overlay addBackgroundImgWithPath:overlayPath];
    [((SGNarrationOverlayViewController*)overlay) configureAudioWithPath:audioFolderPath];
}

-(void)loadTextWithFolderPath:(NSString *)textFolderPath
{
    SGOverlayViewController* overlay = [self.delegate overlay:self triggersNewOverlayName:(NSString*)kTextStr];
    NSString *overlayPath = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@"png" inDirectory:textFolderPath];
    [overlay addBackgroundImgWithPath:overlayPath];
}

@end
