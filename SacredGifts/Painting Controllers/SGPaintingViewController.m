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

@interface SGPaintingViewController (PrivateAPIs)
- (void) addMainPainting:(NSString*)paintingName;
- (void) addFooterButtonsForPainting: (NSString*)paintingNameStr;
- (UIButton*)footerBtnForTag:(ModuleType)moduleType;
- (void)pressedModuleBtn:(UIButton *)sender;
- (ModuleType)getModuleTypeForStr: (NSString*)moduleStr;
@end

@implementation SGPaintingViewController
-(void)configWithInfo:(NSDictionary *)userInfo
{
    //Main Painting
    NSString* paintingName = (NSString*)[userInfo objectForKey:@"paintingName"];
    [self addMainPainting:paintingName];
    
    /*
    NSArray* blurredViews = [NSArray arrayWithObject:self.overlayController];
    NSString *blurredPaintingPath = [[NSBundle mainBundle] pathForResource:@"MainPainting Blurred" ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@", kPaintingResourcesStr, paintingName]];
    [self.delegate contentController:self viewsForBlurredBacking:blurredViews blurredImgPath:blurredPaintingPath];
    */
    
    [self addFooterButtonsForPainting:paintingName];
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
    
    NSString *tombstonePath = [[NSBundle mainBundle] pathForResource:@"tombstone" ofType:@"png" inDirectory:[NSString stringWithFormat: @"%@/%@", kPaintingResourcesStr, paintingName]];
    self.overlayController = [self.storyboard instantiateViewControllerWithIdentifier:(NSString *)kOverlayControllerIDTombstone];
    
    [self.overlayController addBackgroundImgWithPath:tombstonePath];
    [self.view addSubview:self.overlayController.view];
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
    switch (sender.tag) {
        case kModuleTypeGifts:
            NSLog(@"Pressed Gifts");
            break;
        case kModuleTypeChildrens:
            NSLog(@"Pressed Childrens");
            break;
        case kModuleTypeDetails:
            NSLog(@"Pressed Details");
            break;
        case kModuleTypeMusic:
            NSLog(@"Pressed Music");
            break;
        case kModuleTypeSummary:
            NSLog(@"Pressed Summary");
            break;
        case kModuleTypePerspective:
            NSLog(@"Pressed Perspective");
            break;
            
        default:
            break;
    }
    /*
    if( self.overlay == nil )
    {
        [self.paintingView animateDown];
        SGOverlayView *overlayView = [SGOverlayView new];
        self.overlay = overlayView;
        [self.view addSubview:self.overlay];
        
        CGRect f = self.paintingView.mainPainting.frame;
        [overlayView animateOnWithPaintingTargetSize:f.size];
        overlayView.delegate = self;
    }
     */
}

@end
