//
//  SGOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/27/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "GAITrackedViewController.h"
#import "SGConstants.h"

@class SGOverlayViewController;

@protocol SGOverlayViewControllerDelegate <NSObject>

- (SGOverlayViewController*)overlay: (SGOverlayViewController*)overlay triggersNewOverlayName: (NSString*)overlayName;
- (void) closeOverlay: (SGOverlayViewController*)overlay;
- (void) dismissChrome;
- (void) turnOnChrome;

@end

@interface SGOverlayViewController : GAITrackedViewController
{
    NSString* _bgImagePath;
    CGPoint _centerPos;
}
@property(nonatomic, strong) UIImageView* bgImageView;
@property(nonatomic) ModuleType moduleType;
@property(nonatomic, weak) id<SGOverlayViewControllerDelegate> delegate;
@property(nonatomic, strong) NSString* rootFolderPath;
@property(nonatomic, strong) IBOutlet UIButton* closeButton;
@property(nonatomic, strong) NSString* paintingName;

- (void)addBackgroundImgWithPath: (NSString*)bgImgPath;
- (void)addBackgroundImgWithImgName: (NSString*)bgImgName;
- (void)pressedClose: (UIButton*)sender;

@end
