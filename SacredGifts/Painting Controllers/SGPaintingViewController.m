//
//  SGPaintingViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/23/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGPaintingViewController.h"

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
- (void)addNewOverlayOfType:(NSString*)moduleStr forPainting:(NSString *)paintingStr;
- (void)removeCurrentOverlay;
- (void)addTombstoneDelayed: (NSTimer*)timer;
@end

@implementation SGPaintingViewController
-(void)configWithPaintingName:(NSString *)paintingStr;
{
    //Main Painting
    _paintingNameStr = paintingStr;
    [self addMainPainting:_paintingNameStr];
    [NSTimer scheduledTimerWithTimeInterval:self.frameOverlayDelay target:self selector:@selector(addTombstoneDelayed:) userInfo:nil repeats:NO];
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
    if( sender.direction == UISwipeGestureRecognizerDirectionRight )
        swipeDir = (NSString*)kAnimTypeSwipeRight;
    
    [self.delegate transitionFromController:self toPaintingNamed:@"temple" fromButtonRect:CGRectZero withAnimType:swipeDir];
}

-(void)addFooterButtonsForPainting:(NSString *)paintingNameStr
{
    NSArray* buttonTypeStrArr = [NSArray arrayWithObjects:kGiftsStr, kSummaryStr,kPerspectiveStr, kMusicStr, kChildrensStr, kDetailsStr, nil];
    
    for( NSString* buttonTypeStr in buttonTypeStrArr)
    {
        NSString* overlayPath = [[NSBundle mainBundle] pathForResource:buttonTypeStr ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@/%@/", @"PaintingResources", paintingNameStr, buttonTypeStr]];
        
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

-(void)addNewOverlayOfType:(NSString*)moduleStr forPainting:(NSString *)paintingStr
{
    //Transition current overlay off
    [self removeCurrentOverlay];
    
    //Create new overlay veiwController
    self.overlayController = [self.storyboard instantiateViewControllerWithIdentifier:moduleStr];
    //Transition new overlay on
    [self.view insertSubview:self.overlayController.view belowSubview:self.footerView];
    self.overlayController.view.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.overlayController.view.alpha = 1;
    }];
    
    //Configure new overlay viewController
    if( self.overlayController.moduleType == kModuleTypePerspective){
        
    }
    else if( self.overlayController.moduleType == kModuleTypeSocial ){
        [self.overlayController addBackgroundImgWithImgName:@"SG_General_Module_Overlay.png"];
    }
    else{
        NSString *overlayPath = [[NSBundle mainBundle] pathForResource:moduleStr ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@/%@", kPaintingResourcesStr, paintingStr, moduleStr]];
        [self.overlayController addBackgroundImgWithPath:overlayPath];
    }
}

-(void)removeCurrentOverlay
{
    if( self.overlayController != nil ){
        SGOverlayViewController* exitingOverlay = self.overlayController;
        [UIView animateWithDuration:0.25 animations:^{
            exitingOverlay.view.alpha = 0;
        } completion:^(BOOL finished) {
            [exitingOverlay.view removeFromSuperview];
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
    }];
}

@end
