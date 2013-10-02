//
//  SGPaintingViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/23/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGPaintingViewController.h"
#import "SGOverlayViewController.h"

const int kFooterBtnOffset = 140;
const int kFooterBtnY = 35;

const int kGeneralButtonWidth = 120;
const int kSummaryButtonWidth = 128;
const int kPerspectivesButtonWidth = 161;

@interface SGPaintingViewController (PrivateAPIs)
- (void) addMainPainting:(NSString*)paintingName;
- (void) addFooterButtonsForPainting: (NSString*)paintingNameStr;
- (UIButton*)footerBtnForTag:(ModuleType)moduleType;
- (void)pressedModuleBtn:(UIButton *)sender;
- (ModuleType)getModuleTypeForStr: (NSString*)moduleStr;
- (NSString*)getStringForModule: (ModuleType)moduleType;
-(void)addNewOverlayOfType:(NSString*)moduleStr forPainting:(NSString *)paintingStr;
@end

@implementation SGPaintingViewController
-(void)configWithPaintingName:(NSString *)paintingStr;
{
    //Main Painting
    _paintingNameStr = paintingStr;
    [self addMainPainting:_paintingNameStr];
    [self addNewOverlayOfType:(NSString*)kTombstoneStr forPainting:_paintingNameStr];
    
    NSArray* blurredViews = [NSArray arrayWithObject:self.overlayController.view];
    NSString *blurredPaintingPath = [[NSBundle mainBundle] pathForResource:@"MainPainting Blurred" ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@", kPaintingResourcesStr, _paintingNameStr]];
    [self.delegate contentController:self viewsForBlurredBacking:blurredViews blurredImgPath:blurredPaintingPath];
    
    _currentFooterBtnX = -kGeneralButtonWidth / 2;
    [self addFooterButtonsForPainting:_paintingNameStr];
}

-(void)addFooterButtonsForPainting:(NSString *)paintingNameStr
{
    int currentBtnIndex = 0;
    NSArray* buttonTypeStrArr = [NSArray arrayWithObjects:kGiftsStr, kSummaryStr,kPerspectiveStr, kMusicStr, kChildrensStr, kDetailsStr, nil];
    
    for( NSString* buttonTypeStr in buttonTypeStrArr)
    {
        NSString* overlayPath = [[NSBundle mainBundle] pathForResource:buttonTypeStr ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@/%@/", @"PaintingResources", paintingNameStr, buttonTypeStr]];
        
        if( overlayPath != nil)
        {
            ModuleType moduleType = [self getModuleTypeForStr:buttonTypeStr];
            UIButton* overlayBtn = [self footerBtnForTag:moduleType];
            //int xOffset = 70 + currentBtnIndex++ * kFooterBtnOffset;
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
    
    CGSize s = returnBtn.imageView.image.size;
    returnBtn.frame = CGRectMake(0, 0, s.width, s.height);
    returnBtn.tag = moduleType;
    [returnBtn addTarget:self action:@selector(pressedModuleBtn:) forControlEvents:UIControlEventTouchUpInside];
    return returnBtn;
}

- (void)pressedModuleBtn:(UIButton *)sender
{
    ModuleType moduleType = sender.tag;
    if( moduleType == _currentModule ) return;
    _currentModule = moduleType;
    
    [self addNewOverlayOfType:[self getStringForModule:moduleType] forPainting:_paintingNameStr];
}

-(void)addNewOverlayOfType:(NSString*)moduleStr forPainting:(NSString *)paintingStr
{
    //Transition current overlay off
    if( self.overlayController != nil ){
        SGOverlayViewController* exitingOverlay = self.overlayController;
        [UIView animateWithDuration:0.25 animations:^{
            exitingOverlay.view.alpha = 0;
        } completion:^(BOOL finished) {
            [exitingOverlay.view removeFromSuperview];
        }];
    }
    
    //Create new overlay veiwController
    self.overlayController = [self.storyboard instantiateViewControllerWithIdentifier:moduleStr];
    
    //Transition new overlay on
    [self.view insertSubview:self.overlayController.view belowSubview:self.footerView];
    self.overlayController.view.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.overlayController.view.alpha = 1;
    }];
    
    //Configure new overlay viewController
    if( [moduleStr isEqualToString:(NSString*)kPerspectiveStr]){
        
    }
    else{
        NSString *overlayPath = [[NSBundle mainBundle] pathForResource:moduleStr ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@/%@", kPaintingResourcesStr, paintingStr, moduleStr]];
        [self.overlayController addBackgroundImgWithPath:overlayPath];
    }
}

@end
