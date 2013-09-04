//
//  SGPaintingViewController.h
//  SacredGifts
//
//  Created by Ontario on 8/28/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPaintingImageView.h"
#import "SGClosableOverlayView.h"

@class SGPhasedBackgroundView;
@class SGOverlayView;
@class SGParallaxManager;

typedef enum
{
    kModuleTypeNone = 0,
    kModuleTypeTitle = 1,
    kModuleTypeSummary = 2,
    kModuleTypeContext = 3,
    kModuleTypeDetails = 4,
    kModuleTypeCommentary = 5,
    kModuleTypeMusic = 6,
    kModuleTypeChildrens = 7,
    kModuleTypeSocial = 8
}ModuleType;

@interface SGPaintingViewController : UIViewController<SGPaintingImageViewDelegate, SGClosableOverlayViewDelegate>
{
    ModuleType m_currentModule;
    CGRect m_lastPortraitFrame;
    SGParallaxManager* m_parallaxManager;
}
@property (weak, nonatomic) IBOutlet SGPhasedBackgroundView *phasedBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *blackBacking;
@property (weak, nonatomic) IBOutlet SGPaintingImageView *paintingImageView;
@property (weak, nonatomic) IBOutlet SGOverlayView *topBarView;
@property (weak, nonatomic) IBOutlet SGOverlayView *bottomBarView;
@property (strong, nonatomic) SGOverlayView* currentOverlayView;

- (void)configWithDictionary:(NSDictionary*)config;
- (IBAction)pressedModuleBtn: (UIButton*)sender;

@end
