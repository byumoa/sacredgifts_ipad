//
//  SGPaintingViewController.m
//  SacredGifts
//
//  Created by Ontario on 8/28/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import "SGPaintingViewController.h"
#import "SGPaintingImageView.h"
#import "SGPhasedBackgroundView.h"
#import "SGOverlayView.h"
#import "SGParallaxManager.h"

#import "SGSummaryView.h"
#import "SGTitleView.h"
#import "SGSocialView.h"

const CGPoint kModuleButtonPosArr[] = {{70,35},{210,35},{350,35},{490,35},{630,35}};

const NSString* kModuleTypeSummaryStr = @"moduleTypeSummary";
const NSString* kModuleTypeContextStr = @"moduleTypeContext";
const NSString* kModuleTypeDetailsStr = @"moduleTypeDetails";
const NSString* kModuleTypeCommentaryStr = @"moduleTypeCommentary";
const NSString* kModuleTypeMusicStr = @"moduleTypeMusic";
const NSString* kModuleTypeChildrensStr = @"moduleTypeChildrens";

const NSString* kModuleBtnSummaryImageNrm = @"SG_General_Painting_SummaryBtn";
const NSString* kModuleBtnSummaryImageSel = @"SG_General_Painting_SummaryBtn-on";
const NSString* kModuleBtnContextImageNrm = @"SG_General_Painting_ContextBtn";
const NSString* kModuleBtnContextImageSel = @"SG_General_Painting_ContextBtn-on";
const NSString* kModuleBtnDetailsImageNrm = @"SG_General_Painting_DetailsBtn";
const NSString* kModuleBtnDetailsImageSel = @"SG_General_Painting_DetailsBtn-on";
const NSString* kModuleBtnCommentaryImageNrm = @"SG_General_Painting_CommentaryBtn";
const NSString* kModuleBtnCommentaryImageSel = @"SG_General_Painting_CommentaryBtn-on";
const NSString* kModuleBtnMusicImageNrm = @"SG_General_Painting_MusicBtn";
const NSString* kModuleBtnMusicImageSel = @"SG_General_Painting_MusicBtn-on";
const NSString* kModuleBtnChildrensImageNrm = @"SG_General_Painting_ChildrensBtn";
const NSString* kModuleBtnChildrensImageSel = @"SG_General_Painting_ChildrensBtn-on";

const CGPoint kTitleCenter = {384, 857};
const CGPoint kSummaryCenter = {384, 714};
const CGPoint kSocialCenter = {384, 795};

@interface SGPaintingViewController (BuildUI)

- (void)populateModuleButtonsWithArray: (NSArray*)modules;
- (UIButton*) bottomBarButtonForTag: (ModuleType)moduleType;
- (ModuleType) getModuleTypeForStr: (NSString*)moduleStr;
- (void) addMainPainting:(NSDictionary*)config;
@end

@interface SGPaintingViewController (Overlay)
-(void)addOverlayType:(ModuleType)moduleType pushesPaintingDown:(BOOL)push;
- (void)dismissOverlay;
@end

@implementation SGPaintingViewController

//-------------------------------------------------- Creation ----------
- (void)viewDidLoad
{
    NSLog(@"SGPaintingViewController viewDidLoad");
    [super viewDidLoad];
    
    [self configWithDictionary:self.config];
    
    [self addOverlayType:kModuleTypeTitle pushesPaintingDown:NO];
    m_lastPortraitFrame = CGRectMake(0, -40, 768, 1004);
}

- (void)configWithDictionary:(NSDictionary*)config
{
    NSLog(@"SGPaintingViewController configWithDictionary");
    
    [self addMainPainting:config];
    [self populateModuleButtonsWithArray:(NSArray*)[config objectForKey:@"Modules"]];
    
    m_parallaxManager = [SGParallaxManager new];
    
    NSString* paintingName = (NSString*)[config objectForKey:@"paintingName"];
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"MainPainting Blurred" ofType:@"png" inDirectory:[NSString stringWithFormat: @"PaintingResources/%@", paintingName]];
    m_parallaxManager.sharedBlurredImg = [UIImage imageWithContentsOfFile:fullPath];
    [m_parallaxManager addOverlay:self.topBarView];
    [m_parallaxManager addOverlay:self.bottomBarView];
    [m_parallaxManager addOverlay:self.currentOverlayView];
}

//----------------------------------------------- Interaction ----------
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if( UIInterfaceOrientationIsPortrait( self.interfaceOrientation ))
        m_lastPortraitFrame = self.paintingImageView.frame;
    
    int blackBackingAlpha = 0.0;
    if( UIInterfaceOrientationIsPortrait(toInterfaceOrientation)){
        self.phasedBackgroundView.frame = CGRectMake(0, -40, 768, 1024);
        self.paintingImageView.frame = m_lastPortraitFrame;
        
        [self.topBarView fadeIn];
        [self.bottomBarView fadeIn];
        [self.currentOverlayView fadeIn];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
    else{
        self.phasedBackgroundView.frame = CGRectMake(0, -40, 1024, 768);
        self.paintingImageView.frame = CGRectMake(0, -20, 1024, 768);
        blackBackingAlpha = 1.0;
        [self.topBarView turnOffNoFade];
        [self.bottomBarView turnOffNoFade];
        [self.currentOverlayView turnOffNoFade];
        self.blackBacking.hidden = NO;
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.blackBacking.alpha = blackBackingAlpha;
    }];
}

-(void)paintingTapped:(SGPaintingImageView *)paintingView
{
    if( UIInterfaceOrientationIsPortrait(self.interfaceOrientation) )
    {
        if (self.currentOverlayView == nil) {
            if( self.topBarView.alpha == 0.0 )
            {
                [self.topBarView fadeIn];
                [self.bottomBarView fadeIn];
            }
            else
            {
                [self.topBarView fadeOut];
                [self.bottomBarView fadeOut];
            }
        }
        else
        {
            [self dismissOverlay];
        }
    }
}

//-------------------------------------------------- Build UI ----------
-(void)addMainPainting:(NSDictionary *)config
{
    NSString* paintingName = (NSString*)[config objectForKey:@"paintingName"];
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"MainPainting" ofType:@"png" inDirectory:[NSString stringWithFormat: @"PaintingResources/%@", paintingName]];
    self.paintingImageView.image = [UIImage imageWithContentsOfFile:fullPath];
    self.paintingImageView.delegate = self;
}

- (ModuleType) getModuleTypeForStr: (NSString*)moduleStr
{
    if(  [moduleStr isEqualToString: (NSString*)kModuleTypeSummaryStr] )
        return kModuleTypeSummary;
    else if( [moduleStr isEqualToString: (NSString*)kModuleTypeChildrensStr] )
        return kModuleTypeChildrens;
    else if( [moduleStr isEqualToString: (NSString*)kModuleTypeContextStr] )
        return kModuleTypeContext;
    else if( [moduleStr isEqualToString: (NSString*)kModuleTypeDetailsStr] )
        return kModuleTypeDetails;
    else if( [moduleStr isEqualToString: (NSString*)kModuleTypeMusicStr] )
        return kModuleTypeMusic;
    else return kModuleTypeCommentary;
}

- (IBAction)pressedModuleBtn: (UIButton*)sender
{
    [self addOverlayType:sender.tag pushesPaintingDown:YES];
}

- (void)populateModuleButtonsWithArray:(NSArray*)modules
{
    for( int i = 0; i < modules.count; i++ )
    {
        ModuleType moduleType = [self getModuleTypeForStr:(NSString*)[modules objectAtIndex:i]];
        
        UIButton* button = [self bottomBarButtonForTag:moduleType];
        [self.bottomBarView addSubview:button];
        button.center = kModuleButtonPosArr[i];
    }
}

-(UIButton *)bottomBarButtonForTag:(ModuleType)moduleType
{
    UIButton* returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    switch( moduleType )
    {
        case kModuleTypeSummary:
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnSummaryImageNrm] forState:UIControlStateNormal];
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnSummaryImageSel] forState:UIControlStateSelected];
            break;
        case kModuleTypeContext:
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnContextImageNrm] forState:UIControlStateNormal];
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnContextImageSel] forState:UIControlStateSelected];
            break;
        case kModuleTypeChildrens:
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnChildrensImageNrm] forState:UIControlStateNormal];
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnChildrensImageSel] forState:UIControlStateSelected];
            break;
        case kModuleTypeCommentary:
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnCommentaryImageNrm] forState:UIControlStateNormal];
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnCommentaryImageSel] forState:UIControlStateSelected];
            break;
        case kModuleTypeDetails:
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnDetailsImageNrm] forState:UIControlStateNormal];
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnDetailsImageSel] forState:UIControlStateSelected];
            break;
        case kModuleTypeMusic:
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnMusicImageNrm] forState:UIControlStateNormal];
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnMusicImageSel] forState:UIControlStateSelected];
            break;
        default:
            break;
    }
    
    CGSize s = returnBtn.imageView.image.size;
    returnBtn.frame = CGRectMake(0, 0, s.width, s.height);
    returnBtn.tag = moduleType;
    [returnBtn addTarget:self action:@selector(pressedModuleBtn:) forControlEvents:UIControlEventTouchUpInside];
    return returnBtn;
}

//Overlay
-(void)addOverlayType:(ModuleType)moduleType pushesPaintingDown:(BOOL)push
{
    if( m_currentModule == moduleType ) return;
    
    [self.currentOverlayView dismissWithAnim:kOverlayAnimationNone];
    self.currentOverlayView = nil;
    
    m_currentModule = moduleType;
    
    if( push && !self.paintingImageView.isDown )
        [self.paintingImageView animateDown];
    
    switch (moduleType) {
        case kModuleTypeTitle:
        {
            UIImage* textImg = [UIImage imageNamed:@"SG_General_TitleText_MOCKUP.png"];
            self.currentOverlayView = [[SGTitleView alloc] initWithTextImage:textImg];
            self.currentOverlayView.center = kTitleCenter;
        }
            break;
        case kModuleTypeCommentary:
            NSLog(@"Pressed Commentary");
            break;
        case kModuleTypeChildrens:
            NSLog(@"Pressed Childrens");
            break;
        case kModuleTypeContext:
            NSLog(@"Pressed Context");
            break;
        case kModuleTypeDetails:
            NSLog(@"Pressed Details");
            break;
        case kModuleTypeMusic:
            NSLog(@"Pressed Music");
            break;
        case kModuleTypeSummary:
        {
            UIImage* textImg = [UIImage imageNamed:@"SG_General_SummaryText_MOCKUP.png"];
            self.currentOverlayView = [[SGSummaryView alloc] initWithTextImage:textImg];
            self.currentOverlayView.center = kSummaryCenter;
            ((SGSummaryView*)self.currentOverlayView).delegate = self;
        }
            break;
        case kModuleTypeSocial:
        {
            UIImage* thumbImg = [UIImage imageNamed:@"thumbnail.png"];
            self.currentOverlayView = [[SGSocialView alloc] initWithThumbnail:thumbImg];
            self.currentOverlayView.center = kSocialCenter;
            ((SGSocialView*)self.currentOverlayView).delegate = self;
        }
            break;
        default:
            break;
    }
    
    [self.view addSubview:self.currentOverlayView];
    [m_parallaxManager addOverlay:self.currentOverlayView];
    
    CGRect f = self.paintingImageView.frame;
    if( push )
        [self.currentOverlayView animateOnWithPaintingTargetSize:f.size];
}

-(void)presentSocialViewController:(SLComposeViewController *)composeViewController{
    [self presentViewController:composeViewController animated:YES completion:^{}];
}

-(void)dismissSocialMailController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)overlayClosed:(SGClosableOverlayView *)overlay{
    [self dismissOverlay];
}

-(void)dismissOverlay{
    if( self.paintingImageView.isDown )
        [self.paintingImageView animateUp];
    [self.currentOverlayView dismissWithAnim:kOverlayAnimationNone];
    self.currentOverlayView = nil;
    m_currentModule = kModuleTypeNone;
}

@end
