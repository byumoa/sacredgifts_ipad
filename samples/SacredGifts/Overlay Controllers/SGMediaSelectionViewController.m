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
#import "SGOverlayView.h"
#import "SGBlurManager.h"

const int kVideoStartPositionY = -80;
const int kIncreasedVideoOffset = 260;
const int kAudioStartPositionY = 160;
const int kTextStartPositionY = 102;

@interface SGMediaSelectionViewController()
- (ModuleType)getModuleTypeForStr: (NSString*)moduleStr;
- (UIView*)addBlurredBackingForChildView;
- (void)positionViews;
@end

@implementation SGMediaSelectionViewController

-(SGOverlayViewController*)loadPanoramaWithFolderPath:(NSString *)panoFolderPath
{
    SGOverlayViewController* overlay = [self addChildOverlay:(NSString*)kPanoramaStr];
    NSString *overlayPath = [[NSBundle mainBundle] pathForResource:@"pano_f" ofType:@"jpg" inDirectory:panoFolderPath];
    [overlay addBackgroundImgWithPath:overlayPath];
    [((SGPanoramaOverlayViewController*)overlay) startPanoWithPath:panoFolderPath];
    
    overlay.view.frame = [self.view convertRect:CGRectMake(0, 0, 768, 1024) fromView:self.view.superview];
    [self.delegate dismissChrome];
    
    return overlay;
}

-(SGOverlayViewController*)loadVideoWithFolderPath:(NSString *)videoFolderPath
{
    SGOverlayViewController* overlay = [self addChildOverlay:kVideoStr];
    NSString *overlayPath = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@"png" inDirectory:videoFolderPath];
    [overlay addBackgroundImgWithPath:overlayPath];
    [((SGVideoOverlayViewController*)overlay) playPerspectiveMovieWithRootFolderPath:videoFolderPath];
    
    [self positionViews];
    
    return overlay;
}

-(SGOverlayViewController*)loadAudioWithFolderPath:(NSString *)audioFolderPath
{
    SGOverlayViewController* overlay = [self addChildOverlay:kNarrationStr];
    NSString *overlayPath = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@"png" inDirectory:audioFolderPath];
    [overlay addBackgroundImgWithPath:overlayPath];
    [((SGNarrationOverlayViewController*)overlay) configureAudioWithPath:audioFolderPath];
    
    [self positionViews];
    
    return overlay;
}

-(SGOverlayViewController*)loadTextWithFolderPath:(NSString *)textFolderPath
{
    SGOverlayViewController* overlay = [self addChildOverlay:kTextStr];
    NSString *overlayPath = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@"png" inDirectory:textFolderPath];
    [overlay addBackgroundImgWithPath:overlayPath];
 
    self.childOverlay.rootFolderPath = textFolderPath;
    [self positionViews];
    
    return overlay;
}

-(SGOverlayViewController*)addChildOverlay:(NSString *)moduleStr
{
    //Create new overlay veiwController
    self.childOverlay = [self.storyboard instantiateViewControllerWithIdentifier:moduleStr];
    self.childOverlay.delegate = self;
    [self.view addSubview:self.childOverlay.view];
        
    self.childOverlay.rootFolderPath = [NSString stringWithFormat: @"%@/%@/%@", @"PaintingResources", self.paintingName, moduleStr];

    //Configure new overlay viewController
    switch ([self getModuleTypeForStr:moduleStr]) {
        case kModuleTypeVideo:
            break;
        case kModuleTypeNarration:{
            NSString* audioPath = [NSString stringWithFormat: @"PaintingResources/%@/perspectives/perspectives_%i", self.paintingName, 1];
            [((SGNarrationOverlayViewController*)self.childOverlay) configureAudioWithPath:audioPath];
        }
            break;
        default:{
            NSString *overlayPath = [[NSBundle mainBundle] pathForResource:moduleStr ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@/%@", kPaintingResourcesStr, self.paintingName, moduleStr]];
            [self.childOverlay addBackgroundImgWithPath:overlayPath];
        }
            break;
    }
    
    [self prepareForMediaStart];
    self.childOverlay.paintingName = self.paintingName;
    
    return self.childOverlay;
}

-(void)positionViews
{
    UIView* blurredBacking = [self addBlurredBackingForChildView];
    CGRect frame = self.childOverlay.view.frame;
    frame.origin.y = self.view.frame.size.height - self.childOverlay.view.frame.size.height;
    self.childOverlay.view.frame = frame;
    blurredBacking.frame = frame;
}

-(UIView*)addBlurredBackingForChildView
{
    UIView* blurredBacking = [[SGBlurManager sharedManager] blurBackingForView:self.childOverlay.view];
    ((SGOverlayView*)self.childOverlay.view).myBlurredBacking = blurredBacking;
    
    [self.view insertSubview:blurredBacking belowSubview:self.childOverlay.view];
    
    blurredBacking.alpha = 0;
    self.childOverlay.view.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.childOverlay.view.alpha = 1;
        blurredBacking.alpha = 1;
    }];
    
    return blurredBacking;
}

- (ModuleType) getModuleTypeForStr: (NSString*)moduleStr
{
    if( [moduleStr isEqualToString: (NSString*)kSummaryStr] )
        return kModuleTypeSummary;
    else if( [moduleStr isEqualToString: (NSString*)kChildrensStr] )
        return kModuleTypeChildrens;
    else if( [moduleStr isEqualToString: (NSString*)kPerspectiveStr] )
        return kModuleTypePerspective;
    else if( [moduleStr isEqualToString: (NSString*)kMusicStr] )
        return kModuleTypeMusic;
    else if( [moduleStr isEqualToString: (NSString*)kHighlightsStr] )
        return kModuleTypeHighlights;
    else if( [moduleStr isEqualToString: (NSString*)kTombstoneStr] )
        return kModuleTypeTombstone;
    else if( [moduleStr isEqualToString:(NSString *)kSocialStr])
        return kModuleTypeSocial;
    else if( [moduleStr isEqualToString:(NSString *)kTextStr])
        return kModuleTypeText;
    else return kModuleTypeGifts;
}

-(void)prepareForMediaStart
{
    [UIView animateWithDuration:0.25 animations:^{
        for( UIView* view in self.view.subviews)
            if( view != self.childOverlay.view && view != ((SGOverlayView*)self.childOverlay.view).myBlurredBacking )
                view.alpha = 0;
                
        ((SGOverlayView*)self.view).myBlurredBacking.alpha = 0;
    }];
}

-(void)prepareForMediaEnd
{
    [UIView animateWithDuration:0.25 animations:^{
        for( UIView* view in self.view.subviews)
            if( view != self.childOverlay.view )
                view.alpha = 1;
        ((SGOverlayView*)self.view).myBlurredBacking.alpha = 1;
    }];
}

-(void)closeOverlay:(SGOverlayViewController *)overlay
{
    [((SGOverlayView*)self.childOverlay.view).myBlurredBacking removeFromSuperview];
    ((SGOverlayView*)self.childOverlay.view).myBlurredBacking = nil;
    [self.childOverlay.view removeFromSuperview];
    self.childOverlay = nil;
    [self prepareForMediaEnd];
    
    if( [overlay respondsToSelector:@selector(moviePlayer)] )
    {
        MPMoviePlayerController* moviePlayer = [overlay performSelector:@selector(moviePlayer)];
        [moviePlayer stop];
    }
    
    [[SGNarrationManager sharedManager] pauseAudio];
    [self.delegate turnOnChrome];
}

-(SGOverlayViewController *)overlay:(SGOverlayViewController *)overlay triggersNewOverlayName:(NSString *)overlayName
{
    return nil;
}

-(void)turnOnChrome{}
-(void)dismissChrome{}

@end
