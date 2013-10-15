//
//  SGOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/27/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGConstants.h"
#import <AVFoundation/AVFoundation.h>

@class SGOverlayViewController;

@protocol SGOverlayViewControllerDelegate <NSObject>

- (SGOverlayViewController*)overlay: (SGOverlayViewController*)overlay triggersNewOverlayName: (NSString*)overlayName;
- (void) closeOverlay: (SGOverlayViewController*)overlay;

@end

@interface SGOverlayViewController : UIViewController
{
    NSString* _bgImagePath;
    CGPoint _centerPos;
}
@property(nonatomic, strong) UIImageView* bgImageView;
@property(nonatomic) ModuleType moduleType;
@property(nonatomic, weak) id<SGOverlayViewControllerDelegate> delegate;
@property(nonatomic, strong) NSString* rootFolderPath;
@property (strong, nonatomic) AVAudioPlayer* player;

- (void)addBackgroundImgWithPath: (NSString*)bgImgPath;
- (void)addBackgroundImgWithImgName: (NSString*)bgImgName;
- (BOOL) playAudioNamed: (NSString*)audioName;

@end
