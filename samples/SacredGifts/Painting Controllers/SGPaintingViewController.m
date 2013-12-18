//
//  SGPaintingViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/23/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGPaintingViewController.h"
#import "SGPersepectivesOverlayViewController.h"
#import "SGOverlayView.h"
#import "SGChildrensOverlayViewController.h"
#import "SGNarrationManager.h"
#import "SGGiftOverlayViewController.h"
#import "SGNarrationOverlayViewController.h"
#import "SGHighlightsViewController.h"
#import "SGSocialViewController.h"
#import "SGVideoOverlayViewController.h"
#import "SGConvenienceFunctionsManager.h"
#import "SGNavigationContainerViewController.h"
#import "SGPaintingContainerViewController.h"

const int kFooterBtnOffset = 140;
const int kFooterBtnY = 35;

const int kGeneralButtonWidth = 120;
const int kSummaryButtonWidth = 128;
const int kPerspectivesButtonWidth = 161;

NSString* const kPaintingNameTemple = @"temple";
NSString* const kPaintingNameTempleNY = @"temple-ny";

NSString* const kBlochSocialBGStr = @"SG_Social_Module_Overlay_Bloch";
NSString* const kHofmannSocialBGStr = @"SG_Social_Module_Overlay_Hofmann";
NSString* const kSchwartzSocialBGStr = @"SG_Social_Module_Overlay_Schwartz";

NSString* const kCastleBtnNrmStr = @"SG_General_painting-castleBtn";
NSString* const kCastleBtnHilStr = @"SG_General_painting-castleBtn-on";

CGSize const kCastleBtnSize = {768, 41};

CGRect const kPaintingFrameLandscape = {0,20,1024,768};
CGRect const kPaintingFramePortrait = {0,66,768,892};

CGRect const kVideoFrameLandscape = {0, -210,1024,768};
CGRect const kVideoFramePortrait = {0, 45, 768, 432};

NSString* const kTempleDefaultKey = @"templeVersion";

@interface SGPaintingViewController (PrivateAPIs)
- (void) addMainPainting:(NSString*)paintingName;
- (void) addFooterButtonsForPainting: (NSString*)paintingNameStr;
- (UIButton*)footerBtnForTag:(ModuleType)moduleType;
- (IBAction)pressedModuleBtn:(UIButton *)sender;
- (ModuleType)getModuleTypeForStr: (NSString*)moduleStr;
- (SGOverlayViewController*)addNewOverlayOfType:(NSString*)moduleStr forPainting:(NSString *)paintingStr;
- (int)calcCurrentPaintingIndex;
- (void)navigateToCastle: (UIButton*)sender;
- (BOOL)shouldShowCastleButton;
- (void)setChromeAlpha: (int)targetAlpha isTurning: (BOOL)isTurning;
@end

@implementation SGPaintingViewController


-(void)paintingTapped:(SGPaintingImageView *)paintingView
{
    if( UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) return;
    
    float targetAlpha = 1;
    
    if( self.footerView.alpha == 1 )    targetAlpha = 0;
    //else                                [self addTombstoneDelayed:0];
    
    chromeHidden = (self.footerView.alpha == 1);
    [self setChromeAlpha:targetAlpha isTurning:NO];
}


-(void)configWithPaintingName:(NSString *)paintingStr;
{
//    if( [paintingStr isEqualToString:@"temple"] ||
//        [paintingStr isEqualToString:@"temple-ny"] )
//    {
//        NSString* lastPainting = [[NSUserDefaults standardUserDefaults] stringForKey:kTempleDefaultKey];
//        if( lastPainting )
//            paintingStr = lastPainting;
//    }
    
    self.screenName = [NSString stringWithFormat:@"painting: %@", paintingStr];
    
    //Main Painting
    _paintingNameStr = paintingStr;
    [self addMainPainting:_paintingNameStr];
    if( chromeHidden )
    {
        self.headerView.alpha = 0;
        self.footerView.alpha = 0;
    }
    
    [NSTimer scheduledTimerWithTimeInterval:self.frameOverlayDelay target:self selector:@selector(addTombstoneDelayed:) userInfo:nil repeats:NO];
    
    if( [paintingStr isEqualToString:kPaintingNameTemple] || [paintingStr isEqualToString:kPaintingNameTempleNY])
    {
        self.templeButtonsView.hidden = NO;
        
        self.templeBtn1880.selected = [paintingStr isEqualToString:kPaintingNameTemple];
        self.templeBtnLater.selected = [paintingStr isEqualToString:kPaintingNameTempleNY];
    }
    else
        self.templeButtonsView.hidden = YES;
    
    if([paintingStr isEqualToString:@"castle"])
        self.shareBtn.hidden = YES;
    else
        self.shareBtn.hidden = NO;
    
    UIView* blackBacking = [[UIView alloc] initWithFrame:CGRectMake(-1000, -1000, 3000, 3000)];
    blackBacking.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:blackBacking atIndex:0];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    BOOL isTurningToLandscape = UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
    [self setChromeAlpha:isTurningToLandscape?0:1 isTurning:YES];
    
    self.paintingImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.paintingImageView.frame = isTurningToLandscape ? kPaintingFrameLandscape : kPaintingFramePortrait;
    
    if( [_paintingNameStr isEqualToString:@"temple"] ||
        [_paintingNameStr isEqualToString:@"temple-ny"] )
    {
        self.templeButtonsView.alpha = isTurningToLandscape ? 0 : 1;
    }
    /*
    if([_paintingNameStr isEqualToString:@"aalborg"] ||
       [_paintingNameStr isEqualToString:@"capture"] ||
       [_paintingNameStr isEqualToString:@"ruler"] ||
       [_paintingNameStr isEqualToString:@"temple"] ||
       [_paintingNameStr isEqualToString:@"temple-ny"])
    {
        NSString* paintingPath;
        if( isTurningToLandscape )
            paintingPath = [[NSBundle mainBundle] pathForResource:@"MainPainting-landscape" ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@", kPaintingResourcesStr, _paintingNameStr]];
        else
            paintingPath = [[NSBundle mainBundle] pathForResource:@"MainPainting" ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@", kPaintingResourcesStr, _paintingNameStr]];
        self.paintingImageView.image = [UIImage imageWithContentsOfFile:paintingPath];
    }
     */
    
    if([self.overlayController respondsToSelector:@selector(childOverlay)] &&
       ((SGMediaSelectionViewController*)self.overlayController).childOverlay.moduleType == kModuleTypeVideo)
    {
        CGRect frame = isTurningToLandscape ? kVideoFrameLandscape : kVideoFramePortrait;
        ((SGVideoOverlayViewController*)((SGMediaSelectionViewController*)self.overlayController).childOverlay).moviePlayer.view.frame = frame;
    }
    
    if([self.overlayController respondsToSelector:@selector(moviePlayer)])
    {
        NSLog(@"Turning gift");
        CGRect frame = isTurningToLandscape ? kVideoFrameLandscape : kVideoFramePortrait;
        ((SGVideoOverlayViewController*)self.overlayController).moviePlayer.view.frame = frame;
    }
}

- (IBAction)pressedTempleToggle:(id)sender
{
    if( ((UIButton*)sender).tag == 0 && [_paintingNameStr isEqualToString:kPaintingNameTempleNY])
        [self.delegate transitionFromController:self toPaintingNamed:kPaintingNameTemple fromButtonRect:((UIButton*)sender).frame withAnimType:kAnimTypeFade];
    else if( ((UIButton*)sender).tag == 1 && [_paintingNameStr isEqualToString:kPaintingNameTemple])
        [self.delegate transitionFromController:self toPaintingNamed:kPaintingNameTempleNY fromButtonRect:((UIButton*)sender).frame withAnimType:kAnimTypeFade];
}

-(int)calcCurrentPaintingIndex
{
    if( [self.fromArtist isEqualToString:@"bloch"])
    {
        for( int i = 0; i < kTotalPaintingsBloch; i++ )
            if( [_paintingNameStr isEqualToString:(NSString*)kPaintingNamesBloch[i]])
                return i;
    }
    else if( [self.fromArtist isEqualToString:@"schwartz"])
    {
        for( int i = 0; i < kTotalPaintingsSchwartz; i++ )
            if( [_paintingNameStr isEqualToString:(NSString*)kPaintingNamesSchwartz[i]])
                return i;
    }
    else if( [self.fromArtist isEqualToString:@"hofmann"])
    {
        for( int i = 0; i < kTotalPaintingsHofmann; i++ )
            if( [_paintingNameStr isEqualToString:(NSString*)kPaintingNamesHofmann[i]])
                return i;
    }
    else
    {
        for( int i = 0; i < kTotalPaintings; i++ )
            if( [_paintingNameStr isEqualToString:(NSString*)kPaintingNames[i]])
                return i;
    }

    return 0;
}

-(void)addTombstoneDelayed:(NSTimer *)timer
{
    _tombstoneShown = YES;
    
    if( !chromeHidden )
    {
        [self addNewOverlayOfType:(NSString*)kTombstoneStr forPainting:_paintingNameStr];
        NSArray* blurredViews = [NSArray arrayWithObject:self.overlayController.view];
        NSString *blurredPaintingPath = [[NSBundle mainBundle] pathForResource:@"MainPainting Blurred" ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@", kPaintingResourcesStr, _paintingNameStr]];
        [self.delegate contentController:self viewsForBlurredBacking:blurredViews blurredImgPath:blurredPaintingPath];
    }
    
    _currentFooterBtnX = 0;
    [self addFooterButtonsForPainting:_paintingNameStr];
    self.overlayController.closeButton.hidden = YES;
    
    self.currentPaintingIndex = [self calcCurrentPaintingIndex];
}

static BOOL chromeHidden = NO;

+ (BOOL)chromeHidden
{
    return chromeHidden;
}

+ (void)setChromeHidden:(BOOL)val
{
    chromeHidden = val;
}

- (IBAction)swipeRecognized:(UISwipeGestureRecognizer *)sender
{
    if( !_tombstoneShown || UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) return;
    
    NSString* swipeDir = sender.direction == UISwipeGestureRecognizerDirectionRight ? (NSString*)kAnimTypeSwipeRight : (NSString*)kAnimTypeSwipeLeft;
    int nextPaintingIndex = self.currentPaintingIndex + (sender.direction == UISwipeGestureRecognizerDirectionRight ? -1 : 1);
    if( [_paintingNameStr isEqualToString:@"temple-ny"] ) nextPaintingIndex++;
    
    int totalPaintings = kTotalPaintings;
    if( [self.fromArtist isEqualToString:@"bloch"])
        totalPaintings = kTotalPaintingsBloch;
    else if( [self.fromArtist isEqualToString:@"schwartz"])
        totalPaintings = kTotalPaintingsSchwartz;
    else if( [self.fromArtist isEqualToString:@"hofmann"])
        totalPaintings = kTotalPaintingsHofmann;
    if( nextPaintingIndex < 0 )
        nextPaintingIndex += totalPaintings;
    nextPaintingIndex %= totalPaintings;
    
    NSString* nextPaintingName = (NSString*)kPaintingNames[nextPaintingIndex];
    if( [self.fromArtist isEqualToString:@"bloch"])
        nextPaintingName = (NSString*)kPaintingNamesBloch[nextPaintingIndex];
    else if( [self.fromArtist isEqualToString:@"schwartz"])
        nextPaintingName = (NSString*)kPaintingNamesSchwartz[nextPaintingIndex];
    else if( [self.fromArtist isEqualToString:@"hofmann"])
        nextPaintingName = (NSString*)kPaintingNamesHofmann[nextPaintingIndex];
    
    ((SGNavigationContainerViewController*)((SGPaintingContainerViewController*)self.delegate).delegate).hasSwiped = YES;
    
    SGPaintingViewController* paintingViewController = (SGPaintingViewController*)[self.delegate transitionFromController:self toPaintingNamed:nextPaintingName fromButtonRect:CGRectZero withAnimType:swipeDir];
    paintingViewController.fromArtist = self.fromArtist;
}

-(void)addFooterButtonsForPainting:(NSString *)paintingNameStr
{
    NSArray* buttonTypeStrArr = [NSArray arrayWithObjects: kSummaryStr, kPerspectiveStr, kGiftsStr, kChildrensStr, kHighlightsStr, kMusicStr, nil];
    
    for( NSString* buttonTypeStr in buttonTypeStrArr)
    {
        NSString* overlayDirectory = [NSString stringWithFormat: @"%@/%@/%@/", @"PaintingResources", paintingNameStr, buttonTypeStr];
        
        NSString* overlayPath = [[NSBundle mainBundle] pathForResource:buttonTypeStr ofType:@"png" inDirectory:overlayDirectory];
        
        //Handle different perspectives folder structure
        if([buttonTypeStr isEqualToString:kPerspectiveStr])
            overlayPath = [[NSBundle mainBundle] pathForResource:@"perspectives_Btn1" ofType:@"png" inDirectory:overlayDirectory];
        else if([buttonTypeStr isEqualToString:kHighlightsStr])
            overlayPath = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@"png" inDirectory:[NSString stringWithFormat:@"%@/%@", overlayDirectory, @"highlights_1"]];
        else if([buttonTypeStr isEqualToString:kGiftsStr])
        {
            overlayPath = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@"png" inDirectory:overlayDirectory];
        }
        
        if( overlayPath != nil)
        {
            ModuleType moduleType = [self getModuleTypeForStr:buttonTypeStr];
            UIButton* overlayBtn = [self footerBtnForTag:moduleType];
            CGRect frame = overlayBtn.frame;
            frame.origin.x = _currentFooterBtnX;
            overlayBtn.frame = frame;
            [self.footerView addSubview:overlayBtn];
            _currentFooterBtnX += overlayBtn.frame.size.width;
        }
    }
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

-(void)addMainPainting:(NSString*)paintingName
{
    NSString *paintingPath = [[NSBundle mainBundle] pathForResource:@"MainPainting" ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@", kPaintingResourcesStr, paintingName]];
    self.paintingImageView.image = [UIImage imageWithContentsOfFile:paintingPath];
    self.paintingImageView.delegate = self;
}

-(UIButton *)footerBtnForTag:(ModuleType)moduleType
{
    UIButton* returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString* btnImgStrNrm = @"";
    NSString* btnImgStrHil = @"";
    
    switch( moduleType )
    {
        case kModuleTypeSummary:
            btnImgStrNrm = (NSString*)kModuleBtnSummaryImageNrm;
            btnImgStrHil = (NSString*)kModuleBtnSummaryImageSel;
            break;
        case kModuleTypePerspective:
            btnImgStrNrm = (NSString*)kModuleBtnPerspectiveImageNrm;
            btnImgStrHil = (NSString*)kModuleBtnPerspectiveImageSel;
            break;
        case kModuleTypeChildrens:
            btnImgStrNrm = (NSString*)kModuleBtnChildrensImageNrm;
            btnImgStrHil = (NSString*)kModuleBtnChildrensImageSel;
            break;
        case kModuleTypeMusic:
            btnImgStrNrm = (NSString*)kModuleBtnMusicImageNrm;
            btnImgStrHil = (NSString*)kModuleBtnMusicImageSel;
            break;
        case kModuleTypeGifts:
            btnImgStrNrm = (NSString*)kModuleBtnGiftsImageNrm;
            btnImgStrHil = (NSString*)kModuleBtnGiftsImageSel;
            break;
        case kModuleTypeHighlights:
            btnImgStrNrm = (NSString*)kModuleBtnHighlightsImageNrm;
            btnImgStrHil = (NSString*)kModuleBtnHighlightsImageSel;
            break;
        default:
            break;
    }
    
    [returnBtn setImage:[UIImage imageNamed:btnImgStrNrm] forState:UIControlStateNormal];
    [returnBtn setImage:[UIImage imageNamed:btnImgStrHil] forState:UIControlStateHighlighted];
    [returnBtn setImage:[UIImage imageNamed:btnImgStrHil] forState:UIControlStateSelected];
    
    CGSize s = returnBtn.imageView.image.size;
    returnBtn.frame = CGRectMake(0, 0, s.width, s.height);
    returnBtn.tag = moduleType;
    [returnBtn addTarget:self action:@selector(pressedModuleBtn:) forControlEvents:UIControlEventTouchUpInside];
    return returnBtn;
}

- (IBAction)pressedModuleBtn:(UIButton *)sender
{
    ModuleType moduleType = sender.tag;
    if( moduleType == self.overlayController.moduleType )
    {
        sender.selected = NO;
        [self removeCurrentOverlay];
    }
    else
    {
        [self addNewOverlayOfType:[SGConvenienceFunctionsManager getStringForModule:moduleType] forPainting:_paintingNameStr];
        [self deselectAllModuleBtns];
        sender.selected = YES;
    }
}

-(void)deselectAllModuleBtns
{
    SEL setSelectedSelector = sel_registerName("setSelected:");
    for( UIView *subview in self.footerView.subviews )
        if( [subview respondsToSelector:setSelectedSelector])
            ((UIButton*)subview).selected = NO;
}

-(SGOverlayViewController*)addNewOverlayOfType:(NSString*)moduleStr forPainting:(NSString *)paintingStr
{
    //Transition current overlay off
    [self removeCurrentOverlay];
    
    if( ![moduleStr isEqualToString:kGiftsStr])
    {
        //Create new overlay veiwController
        self.overlayController = [self.storyboard instantiateViewControllerWithIdentifier:moduleStr];
        self.overlayController.delegate = self;
        self.overlayController.paintingName = _paintingNameStr;
        
        //Transition new overlay on
        if( [moduleStr isEqualToString:(NSString*)kPanoramaStr] )
            [self.view addSubview:self.overlayController.view];
        else
            [self.view insertSubview:self.overlayController.view belowSubview:self.footerView];
    
        self.overlayController.rootFolderPath = [NSString stringWithFormat: @"%@/%@/%@", @"PaintingResources", _paintingNameStr, moduleStr];
    }
    
    //Configure new overlay viewController
    switch ([self getModuleTypeForStr:moduleStr]) {
        case kModuleTypePerspective:{
            NSString* perspectivesPath = [NSString stringWithFormat: @"%@/%@/%@/", @"PaintingResources", _paintingNameStr, @"perspectives"];
            int totalBtns = [((SGPersepectivesOverlayViewController*)self.overlayController) configurePerspectiveOverlayWithPath:perspectivesPath];
            ((SGPersepectivesOverlayViewController*)self.overlayController).tappedPaintingDelegate = self;
            NSString* overlayImageStr = totalBtns < 4 ? @"SG_General_Module_OverlayHalf_%@.png" : @"SG_General_Module_Overlay_%@.png";
            if( totalBtns >= 4 )
                ((SGMediaSelectionViewController*)self.overlayController).extendePlacement = YES;
            overlayImageStr = [NSString stringWithFormat:overlayImageStr, ((NSString*)[SGConvenienceFunctionsManager artistForPainting:_paintingNameStr abbreviated:YES]).capitalizedString];
            [self.overlayController addBackgroundImgWithImgName:overlayImageStr];
        }
            break;
        case kModuleTypeSocial:{
            //Do we have the right painting name string for the two paintings?
            ((SGSocialViewController*)self.overlayController).paintingName = _paintingNameStr;
            NSString* socialOverlayBGStr = kBlochSocialBGStr;
            
            NSString* artistName = [SGConvenienceFunctionsManager artistForPainting:_paintingNameStr abbreviated:YES];
            if( [artistName isEqualToString:@"hofmann"] )
                socialOverlayBGStr = kHofmannSocialBGStr;
            else if( [artistName isEqualToString:@"schwartz"] )
                socialOverlayBGStr = kSchwartzSocialBGStr;
            
            [self.overlayController addBackgroundImgWithImgName:socialOverlayBGStr];
        }
            break;
        case kModuleTypeVideo:{
            
        }
            break;
        case kModuleTypeNarration:{
            NSString* perspectivesPath = [NSString stringWithFormat: @"PaintingResources/%@/perspectives/perspectives_%i", _paintingNameStr, 1];
            [((SGNarrationOverlayViewController*)self.overlayController) configureAudioWithPath:perspectivesPath];
        }
            break;
        case kModuleTypeGifts:
        {
            NSString* overlayDir = [NSString stringWithFormat: @"%@/%@/%@/", @"PaintingResources", _paintingNameStr, @"gift"];
            NSString* overlayPath = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@".png" inDirectory:overlayDir];
            NSString* videoPath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4" inDirectory:overlayDir];
            NSString* audioPath = [[NSBundle mainBundle] pathForResource:@"audio" ofType:@"mp3" inDirectory:overlayDir];

            if( videoPath )
            {
                self.overlayController = [self.storyboard instantiateViewControllerWithIdentifier:kVideoStr];
                self.overlayController.delegate = self;
                self.overlayController.rootFolderPath = overlayDir;
                [self.view insertSubview:self.overlayController.view belowSubview:self.footerView];
                [self.overlayController addBackgroundImgWithPath:overlayPath];
                [((SGVideoOverlayViewController*)self.overlayController) playPerspectiveMovieWithRootFolderPath:overlayDir];
                self.overlayController.screenName = [NSString stringWithFormat:@"%@: gifts video", paintingStr];
            }      
            else if( audioPath )
            {
                self.overlayController = [self.storyboard instantiateViewControllerWithIdentifier:kNarrationStr];
                self.overlayController.delegate = self;
                self.overlayController.rootFolderPath = overlayDir;
                [self.view insertSubview:self.overlayController.view belowSubview:self.footerView];
                [self.overlayController addBackgroundImgWithPath:overlayPath];
                [((SGNarrationOverlayViewController*)self.overlayController) configureAudioWithPath:overlayDir];
                self.overlayController.screenName = [NSString stringWithFormat:@"%@: gifts audio", paintingStr];
            }
            else
            {
                self.overlayController = [self.storyboard instantiateViewControllerWithIdentifier:kTextStr];
                self.overlayController.delegate = self;
                self.overlayController.rootFolderPath = overlayDir;
                [self.view insertSubview:self.overlayController.view belowSubview:self.footerView];
                [self.overlayController addBackgroundImgWithPath:overlayPath];
                self.overlayController.screenName = [NSString stringWithFormat:@"%@: gifts text", paintingStr];
            }
            
            self.overlayController.moduleType = kModuleTypeGifts;
            self.overlayController.paintingName = _paintingNameStr;
        }
            break;
        case kModuleTypeChildrens:
        {
            NSString* paintingDir = [NSString stringWithFormat: @"%@/%@/%@/", @"PaintingResources", _paintingNameStr, @"childrens"];
            ((SGChildrensOverlayViewController*)self.overlayController).paintingName = _paintingNameStr;
            NSString* paintingPath = [[NSBundle mainBundle] pathForResource:@"childrens" ofType:@".png" inDirectory:paintingDir];
            [((SGChildrensOverlayViewController*)self.overlayController) addBackgroundImgWithPath:paintingPath forgroundImage:self.paintingImageView.image];
            [((SGChildrensOverlayViewController*)self.overlayController) configureWithPath:self.overlayController.rootFolderPath];
            [UIView animateWithDuration:0.25 animations:^{
                self.templeButtonsView.alpha = 0;
            }];
            
            self.overlayController.paintingName = _paintingNameStr;
            self.overlayController.screenName = [NSString stringWithFormat:@"%@: childrens", paintingStr];
        }
            break;
        case kModuleTypeHighlights:
        {
            [((SGHighlightsViewController*)self.overlayController) configureWithPath:self.overlayController.rootFolderPath];
        }
            break;
        default:{
            NSString *overlayPath = [[NSBundle mainBundle] pathForResource:moduleStr ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@/%@", kPaintingResourcesStr, paintingStr, moduleStr]];
            [self.overlayController addBackgroundImgWithPath:overlayPath];
            
            if( [self shouldShowCastleButton] && self.overlayController.moduleType == kModuleTypeSummary )
            {
                UIButton* castleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [castleBtn setImage:[UIImage imageNamed:kCastleBtnNrmStr] forState:UIControlStateNormal];
                [castleBtn setImage:[UIImage imageNamed:kCastleBtnHilStr] forState:UIControlStateHighlighted];
                [castleBtn addTarget:self action:@selector(navigateToCastle:) forControlEvents:UIControlEventTouchUpInside];
                castleBtn.frame = CGRectMake(0, self.overlayController.view.frame.size.height - kCastleBtnSize.height, kCastleBtnSize.width, kCastleBtnSize.height);
                [self.overlayController.view addSubview:castleBtn];
            }
        }
            break;
    }
    
    if( self.overlayController.moduleType != kModuleTypeTombstone &&
        self.overlayController.moduleType != kModuleTypePanorama  &&
        self.overlayController.moduleType != kModuleTypeHighlights &&
        self.overlayController.moduleType != kModuleTypeChildrens )
        [self.delegate contentController:self addBlurBackingForView:self.overlayController.view];
    
    //Overlay frame size is CGSizeZero
    CGRect frame = self.overlayController.view.frame;
    ((SGOverlayView*)self.overlayController.view).myBlurredBacking.frame = frame;

    ((SGOverlayView*)self.overlayController.view).myBlurredBacking.alpha = 0;
    self.overlayController.view.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.overlayController.view.alpha = 1;
        ((SGOverlayView*)self.overlayController.view).myBlurredBacking.alpha = 1;
    }];
    
    return self.overlayController;
}

-(BOOL)shouldShowCastleButton
{
    return ([_paintingNameStr isEqualToString:@"healing"] ||
            [_paintingNameStr isEqualToString:@"sermon"] ||
            [_paintingNameStr isEqualToString:@"cleansing"] ||
            [_paintingNameStr isEqualToString:@"shepherds"] ||
            [_paintingNameStr isEqualToString:@"children"] ||
            [_paintingNameStr isEqualToString:@"burial"] ||
            [_paintingNameStr isEqualToString:@"cross"] ||
            [_paintingNameStr isEqualToString:@"denial"]);
}

-(void)navigateToCastle:(UIButton *)sender
{
    [self.delegate transitionFromController:self toPaintingNamed:@"castle" fromButtonRect:CGRectZero withAnimType:kAnimTypeSwipeLeft];
}

-(void)removeCurrentOverlay
{
    if( self.overlayController != nil ){
        SGOverlayViewController* exitingOverlay = self.overlayController;
        if( [exitingOverlay respondsToSelector:@selector(moviePlayer)])
        {
            MPMoviePlayerController* moviePlayer = [exitingOverlay performSelector:@selector(moviePlayer)];
            [moviePlayer stop];
        }
        [UIView animateWithDuration:0.25 animations:^{
            exitingOverlay.view.alpha = 0;
            ((SGOverlayView*)exitingOverlay.view).myBlurredBacking.alpha = 0;
        } completion:^(BOOL finished) {
            [exitingOverlay.view removeFromSuperview];
            [((SGOverlayView*)exitingOverlay.view).myBlurredBacking removeFromSuperview];
            ((SGOverlayView*)exitingOverlay.view).myBlurredBacking = nil;
        }];
    }
    self.overlayController = nil;
    SGNarrationManager* narrationManager = [SGNarrationManager sharedManager];
    [narrationManager pauseAudio];
    
    if ([_paintingNameStr isEqualToString:kPaintingNameTemple] ||
        [_paintingNameStr isEqualToString:kPaintingNameTempleNY]) {
        [UIView animateWithDuration:0.25 animations:^{
            self.templeButtonsView.alpha = 1;
        }];
    }
}

-(void)setChromeAlpha:(int)targetAlpha isTurning:(BOOL)isTurning
{
    [UIView animateWithDuration:0.25 animations:^{
        self.footerView.alpha = targetAlpha;
        self.headerView.alpha = targetAlpha;
        
        if( isTurning &&
           [self.overlayController respondsToSelector:@selector(childOverlay)] &&
           ((SGMediaSelectionViewController*)self.overlayController).childOverlay.moduleType == kModuleTypeVideo)
        {
            for( UIView* view in ((SGMediaSelectionViewController*)self.overlayController).childOverlay.view.subviews )
                if( view != ((SGVideoOverlayViewController*)((SGMediaSelectionViewController*)self.overlayController).childOverlay).moviePlayer.view)
                view.alpha = targetAlpha;
        }
        else if( isTurning && [self.overlayController respondsToSelector:@selector(moviePlayer)])
        {
            for( UIView* view in self.overlayController.view.subviews )
                if( view != ((SGVideoOverlayViewController*)self.overlayController).moviePlayer.view)
                    view.alpha = targetAlpha;
        }
        else
        {
            if( [self.overlayController respondsToSelector:@selector(childOverlay)] &&
               ((SGMediaSelectionViewController*)self.overlayController).childOverlay )
            {
                ((SGMediaSelectionViewController*)self.overlayController).childOverlay.view.alpha = targetAlpha;
                ((SGOverlayView*)((SGMediaSelectionViewController*)self.overlayController).childOverlay.view).myBlurredBacking.alpha = targetAlpha;
            }
            else
            {
                self.overlayController.view.alpha = targetAlpha;
                ((SGOverlayView*)self.overlayController.view).myBlurredBacking.alpha = targetAlpha;
            }
        }
    }];
}

-(SGOverlayViewController *)overlay:(SGOverlayViewController *)overlay triggersNewOverlayName:(NSString *)overlayName
{
    return [self addNewOverlayOfType:overlayName forPainting:_paintingNameStr];
}

//Close suboverlay
-(void)closeOverlay:(SGOverlayViewController *)overlay
{
    [self removeCurrentOverlay];
    [self deselectAllModuleBtns];
}

-(void)dismissChrome
{
    self.footerView.alpha = 0;
    self.headerView.alpha = 0;
}

-(void)turnOnChrome
{
    self.footerView.alpha = 1;
    self.headerView.alpha = 1;
}

@end
