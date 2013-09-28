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
const CGPoint kTombstoneCenter = {384, 850};
const CGPoint kSummaryCenter = {384, 670};

@interface SGPaintingViewController (PrivateAPIs)
- (void) addMainPainting:(NSString*)paintingName;
- (void) addFooterButtonsForPainting: (NSString*)paintingNameStr;
- (UIButton*)footerBtnForTag:(ModuleType)moduleType;
- (void)pressedModuleBtn:(UIButton *)sender;
- (ModuleType)getModuleTypeForStr: (NSString*)moduleStr;
- (void)addNewOverlayOfType: (ModuleType)moduleType forPainting: (NSString*)paintingStr;
@end

@implementation SGPaintingViewController
-(void)configWithInfo:(NSDictionary *)userInfo
{
    //Main Painting
    _paintingNameStr = (NSString*)[userInfo objectForKey:@"paintingName"];
    [self addMainPainting:_paintingNameStr];
    [self addNewOverlayOfType:kModuleTypeTitle forPainting:_paintingNameStr];
    
    NSArray* blurredViews = [NSArray arrayWithObject:self.overlayController.view];
    NSString *blurredPaintingPath = [[NSBundle mainBundle] pathForResource:@"MainPainting Blurred" ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@", kPaintingResourcesStr, _paintingNameStr]];
    [self.delegate contentController:self viewsForBlurredBacking:blurredViews blurredImgPath:blurredPaintingPath];
    
    [self addFooterButtonsForPainting:_paintingNameStr];
}

-(void)addFooterButtonsForPainting:(NSString *)paintingNameStr
{
    int currentBtnIndex = 0;
    NSArray* buttonTypeStrArr = [NSArray arrayWithObjects:kSummaryStr,/*kPerspectiveStr,*/ kGiftsStr, kMusicStr, kChildrensStr, nil];
    
    for( NSString* buttonTypeStr in buttonTypeStrArr)
    {
        NSString* overlayPath = [[NSBundle mainBundle] pathForResource:buttonTypeStr ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@/%@", kPaintingResourcesStr, paintingNameStr, buttonTypeStr]];
        
        if( overlayPath != nil)
        {
            UIButton* overlayBtn = [self footerBtnForTag:[self getModuleTypeForStr:buttonTypeStr]];
            int xOffset = 70 + currentBtnIndex++ * kFooterBtnOffset;
            overlayBtn.center = CGPointMake(xOffset, kFooterBtnY);
            [self.footerView addSubview:overlayBtn];
        }
    }
}

- (ModuleType) getModuleTypeForStr: (NSString*)moduleStr
{
    if(  [moduleStr isEqualToString: (NSString*)kSummaryStr] )
        return kModuleTypeSummary;
    else if( [moduleStr isEqualToString: (NSString*)kChildrensStr] )
        return kModuleTypeChildrens;
    else if( [moduleStr isEqualToString: (NSString*)kPerspectiveStr] )
        return kModuleTypePerspective;
    else if( [moduleStr isEqualToString: (NSString*)kMusicStr] )
        return kModuleTypeMusic;
    else return kModuleTypeGifts;
}

-(void)addMainPainting:(NSString*)paintingName
{
    NSString *paintingPath = [[NSBundle mainBundle] pathForResource:@"MainPainting" ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@", kPaintingResourcesStr, paintingName]];
    self.paintingImageView.image = [UIImage imageWithContentsOfFile:paintingPath];
}

-(UIButton *)footerBtnForTag:(ModuleType)moduleType
{
    UIButton* returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    switch( moduleType )
    {
        case kModuleTypeSummary:
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnSummaryImageNrm] forState:UIControlStateNormal];
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnSummaryImageSel] forState:UIControlStateSelected];
            break;
        case kModuleTypePerspective:
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnPerspectiveImageNrm] forState:UIControlStateNormal];
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnPerspectiveImageSel] forState:UIControlStateSelected];
            break;
        case kModuleTypeChildrens:
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnChildrensImageNrm] forState:UIControlStateNormal];
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnChildrensImageSel] forState:UIControlStateSelected];
            break;
        case kModuleTypeMusic:
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnMusicImageNrm] forState:UIControlStateNormal];
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnMusicImageSel] forState:UIControlStateSelected];
            break;
        case kModuleTypeGifts:
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnGiftsImageNrm] forState:UIControlStateNormal];
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnGiftsImageSel] forState:UIControlStateSelected];
            break;
        case kModuleTypeDetails:
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnDetailsImageNrm] forState:UIControlStateNormal];
            [returnBtn setImage:[UIImage imageNamed:(NSString*)kModuleBtnDetailsImageSel] forState:UIControlStateSelected];
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

- (void)pressedModuleBtn:(UIButton *)sender
{
    ModuleType moduleType = sender.tag;
    if( moduleType == _currentModule ) return;
    _currentModule = moduleType;
    
    [self addNewOverlayOfType:moduleType forPainting:_paintingNameStr];
}

-(void)addNewOverlayOfType:(ModuleType)moduleType forPainting:(NSString *)paintingStr
{
    if( self.overlayController != nil )
    {
        SGOverlayViewController* dyingController = self.overlayController;
        [UIView animateWithDuration:0.25 animations:^{
            dyingController.view.alpha = 0;
        } completion:^(BOOL finished) {
            [dyingController.view removeFromSuperview];
        }];
    }
    
    switch (moduleType) {
        case kModuleTypeTitle:
        {
            NSString *tombstonePath = [[NSBundle mainBundle] pathForResource:@"tombstone" ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@", kPaintingResourcesStr, paintingStr]];
            self.overlayController = [self.storyboard instantiateViewControllerWithIdentifier:(NSString *)kOverlayControllerIDTombstone];
            [self.overlayController addBackgroundImgWithPath:tombstonePath];
            self.overlayController.view.center = kTombstoneCenter;
        }
            break;
        case kModuleTypeSummary:
        {
            NSString *summaryPath = [[NSBundle mainBundle] pathForResource:@"summary" ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@/%@", kPaintingResourcesStr, paintingStr, @"summary"]];
            self.overlayController = [self.storyboard instantiateViewControllerWithIdentifier:(NSString *)kOverlayControllerIDTombstone];
            [self.overlayController addBackgroundImgWithPath:summaryPath];
            self.overlayController.view.center = kSummaryCenter;
        }
            
        default:
            break;
    }
    
    [self.view addSubview:self.overlayController.view];
    self.overlayController.view.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.overlayController.view.alpha = 1;
    }];
}

@end
