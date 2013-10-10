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

const int kFooterBtnOffset = 140;
const int kFooterBtnY = 35;

const int kGeneralButtonWidth = 120;
const int kSummaryButtonWidth = 128;
const int kPerspectivesButtonWidth = 161;

@interface SGPaintingViewController (PrivateAPIs)
- (void) addMainPainting:(NSString*)paintingName;
- (void) addFooterButtonsForPainting: (NSString*)paintingNameStr;
- (UIButton*)footerBtnForTag:(ModuleType)moduleType;
- (IBAction)pressedModuleBtn:(UIButton *)sender;
- (ModuleType)getModuleTypeForStr: (NSString*)moduleStr;
- (NSString*)getStringForModule: (ModuleType)moduleType;
- (SGOverlayViewController*)addNewOverlayOfType:(NSString*)moduleStr forPainting:(NSString *)paintingStr;
- (void)removeCurrentOverlay;
- (void)addTombstoneDelayed: (NSTimer*)timer;
- (int)calcCurrentPaintingIndex;
@end

@implementation SGPaintingViewController
-(void)configWithPaintingName:(NSString *)paintingStr;
{
    //Main Painting
    _paintingNameStr = paintingStr;
    [self addMainPainting:_paintingNameStr];
    [NSTimer scheduledTimerWithTimeInterval:self.frameOverlayDelay target:self selector:@selector(addTombstoneDelayed:) userInfo:nil repeats:NO];
    self.currentPaintingIndex = [self calcCurrentPaintingIndex];
}

-(int)calcCurrentPaintingIndex
{
    for( int i = 0; i < kTotalPaintings; i++ )
    {
        if( [_paintingNameStr isEqualToString:(NSString*)kPaintingNames[i]])
            return i;
    }
    
    return 0;
}

-(void)addTombstoneDelayed:(NSTimer *)timer
{
    [self addNewOverlayOfType:(NSString*)kTombstoneStr forPainting:_paintingNameStr];
    NSArray* blurredViews = [NSArray arrayWithObject:self.overlayController.view];
    NSString *blurredPaintingPath = [[NSBundle mainBundle] pathForResource:@"MainPainting Blurred" ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@", kPaintingResourcesStr, _paintingNameStr]];
    [self.delegate contentController:self viewsForBlurredBacking:blurredViews blurredImgPath:blurredPaintingPath];
    
    _currentFooterBtnX = -kGeneralButtonWidth / 2;
    [self addFooterButtonsForPainting:_paintingNameStr];
}

- (IBAction)swipeRecognized:(UISwipeGestureRecognizer *)sender
{
    NSString* swipeDir = (NSString*)kAnimTypeSwipeLeft;
    int nextPaintingIndex = self.currentPaintingIndex + 1;
    if( sender.direction == UISwipeGestureRecognizerDirectionRight )
    {
        swipeDir = (NSString*)kAnimTypeSwipeRight;
        nextPaintingIndex -= 2;
        if( nextPaintingIndex < 0 )
            nextPaintingIndex += kTotalPaintings;
    }
    nextPaintingIndex %= kTotalPaintings;
    NSString* nextPaintingName = (NSString*)kPaintingNames[nextPaintingIndex];
    [self.delegate transitionFromController:self toPaintingNamed:nextPaintingName fromButtonRect:CGRectZero withAnimType:swipeDir];
}

-(void)addFooterButtonsForPainting:(NSString *)paintingNameStr
{
    NSArray* buttonTypeStrArr = [NSArray arrayWithObjects:kGiftsStr, kSummaryStr, kPerspectiveStr, kMusicStr, kChildrensStr, kDetailsStr, nil];
    
    for( NSString* buttonTypeStr in buttonTypeStrArr)
    {
        NSString* overlayPath = [[NSBundle mainBundle] pathForResource:buttonTypeStr ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@/%@/", @"PaintingResources", paintingNameStr, buttonTypeStr]];
        
        //Handle different perspectives folder structure
        if([buttonTypeStr isEqualToString:@"perspectives"])
            overlayPath = [[NSBundle mainBundle] pathForResource:@"perspectives_Btn1" ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@/%@/", @"PaintingResources", paintingNameStr, buttonTypeStr]];
        
        if( overlayPath != nil)
        {
            ModuleType moduleType = [self getModuleTypeForStr:buttonTypeStr];
            UIButton* overlayBtn = [self footerBtnForTag:moduleType];
            int offset = kGeneralButtonWidth;
            if( moduleType == kModuleTypePerspective )      offset = kPerspectivesButtonWidth;
            else if( moduleType == kSummaryButtonWidth )    offset = kSummaryButtonWidth;
            _currentFooterBtnX += offset;
            overlayBtn.center = CGPointMake(_currentFooterBtnX, kFooterBtnY);
            [self.footerView addSubview:overlayBtn];
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
    else return kModuleTypeGifts;
}

-(NSString *)getStringForModule:(ModuleType)moduleType
{
    switch (moduleType) {
        case kModuleTypeChildrens:      return (NSString*)kChildrensStr;    break;
        case kModuleTypeDetails:        return (NSString*)kDetailsStr;      break;
        case kModuleTypeGifts:          return (NSString*)kGiftsStr;        break;
        case kModuleTypeMusic:          return (NSString*)kMusicStr;        break;
        case kModuleTypePerspective:    return (NSString*)kPerspectiveStr;  break;
        case kModuleTypeSocial:         return (NSString*)kSocialStr;       break;
        case kModuleTypeSummary:        return (NSString*)kSummaryStr;      break;
        case kModuleTypeTombstone:      return (NSString*)kTombstoneStr;    break;
        case kModuleTypeNone:           default:                            break;
    }
    
    return nil;
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
        case kModuleTypeDetails:
            btnImgStrNrm = (NSString*)kModuleBtnDetailsImageNrm;
            btnImgStrHil = (NSString*)kModuleBtnDetailsImageSel;
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
        [self addNewOverlayOfType:[self getStringForModule:moduleType] forPainting:_paintingNameStr];
        
        SEL setSelectedSelector = sel_registerName("setSelected:");
        for( UIView *subview in self.footerView.subviews ){
            if( [subview respondsToSelector:setSelectedSelector])
                ((UIButton*)subview).selected = NO;
        }
        sender.selected = YES;
    }
}

-(SGOverlayViewController*)addNewOverlayOfType:(NSString*)moduleStr forPainting:(NSString *)paintingStr
{
    //Transition current overlay off
    [self removeCurrentOverlay];
    
    //Create new overlay veiwController
    self.overlayController = [self.storyboard instantiateViewControllerWithIdentifier:moduleStr];
    self.overlayController.delegate = self;
    //Transition new overlay on
    if( [moduleStr isEqualToString:(NSString*)kPanoramaStr] )
        [self.view addSubview:self.overlayController.view];
    else{
        [self.view insertSubview:self.overlayController.view belowSubview:self.footerView];
    }
    
    self.overlayController.rootFolderPath = [NSString stringWithFormat: @"%@/%@/%@", @"PaintingResources", _paintingNameStr, moduleStr];
    
    //Configure new overlay viewController
    switch (self.overlayController.moduleType) {
        case kModuleTypePerspective:{
            [self.overlayController addBackgroundImgWithImgName:@"SG_General_Module_Overlay.png"];
            NSString* perspectivesPath = [NSString stringWithFormat: @"%@/%@/%@/", @"PaintingResources", _paintingNameStr, @"perspectives"];
            [((SGPersepectivesOverlayViewController*)self.overlayController) configurePerspectiveOverlayWithPath:perspectivesPath];
        }
            break;
        case kModuleTypeSocial:{
            [self.overlayController addBackgroundImgWithImgName:@"SG_General_Module_Overlay.png"];
        }
            break;
        case kModuleTypeVideo:{
            //Configured in perspectives
        }
            break;
        case kModuleTypeChildrens:
        {
            NSString* paintingDir = [NSString stringWithFormat: @"%@/%@/%@/", @"PaintingResources", _paintingNameStr, @"childrens"];
            NSString* paintingPath = [[NSBundle mainBundle] pathForResource:@"childrens" ofType:@".png" inDirectory:paintingDir];
            [((SGChildrensOverlayViewController*)self.overlayController) addBackgroundImgWithPath:paintingPath forgroundImage:self.paintingImageView.image];
        }
        default:{
            NSString *overlayPath = [[NSBundle mainBundle] pathForResource:moduleStr ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@/%@", kPaintingResourcesStr, paintingStr, moduleStr]];
            [self.overlayController addBackgroundImgWithPath:overlayPath];
        }
            break;
    }
    
    if( ![moduleStr isEqualToString:(NSString*)kTombstoneStr] )
    {
        [self.delegate contentController:self addBlurBackingForView:self.overlayController.view];
    }
    
    ((SGOverlayView*)self.overlayController.view).myBlurredBacking.alpha = 0;
    self.overlayController.view.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.overlayController.view.alpha = 1;
        ((SGOverlayView*)self.overlayController.view).myBlurredBacking.alpha = 1;
    }];
    
    return self.overlayController;
}

-(void)removeCurrentOverlay
{
    if( self.overlayController != nil ){
        SGOverlayViewController* exitingOverlay = self.overlayController;
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
}

-(void)paintingTapped:(SGPaintingImageView *)paintingView
{
    float targetAlpha = 1;
    if( self.footerView.alpha == 1 )
        targetAlpha = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.footerView.alpha = targetAlpha;
        self.overlayController.view.alpha = targetAlpha;
        ((SGOverlayView*)self.overlayController.view).myBlurredBacking.alpha = targetAlpha;
    }];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if( UIInterfaceOrientationIsPortrait( self.interfaceOrientation ))
        _lastPortraitFrame = self.paintingImageView.frame;
    
    if( UIInterfaceOrientationIsPortrait(toInterfaceOrientation)){
        self.paintingImageView.frame = _lastPortraitFrame;
        [UIView animateWithDuration:duration animations:^{
            self.footerView.alpha = 1;
            self.overlayController.view.alpha = 1;
        }];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
    else{
        self.paintingImageView.frame = CGRectMake(0, -20, 1024, 768);
        [UIView animateWithDuration:duration animations:^{
            self.footerView.alpha = 0;
            self.overlayController.view.alpha = 0;
        }];
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }
}

-(SGOverlayViewController *)overlay:(SGOverlayViewController *)overlay triggersNewOverlayName:(NSString *)overlayName
{
    return [self addNewOverlayOfType:overlayName forPainting:_paintingNameStr];
}

-(void)closeOverlay:(SGOverlayViewController *)overlay
{
    [self addNewOverlayOfType:(NSString*)kPerspectiveStr forPainting:_paintingNameStr];
}

@end
