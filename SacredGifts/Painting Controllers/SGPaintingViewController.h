//
//  SGPaintingViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/23/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPaintingImageView.h"
#import "SGClosableOverlayView.h"
#import "SGContentControllerDelegate.h"
@class SGOverlayViewController;

@interface SGPaintingViewController : UIViewController
{
    ModuleType _currentModule;
    CGRect _lastPortraitFrame;
    NSString* _paintingNameStr;
}

@property (weak, nonatomic) IBOutlet SGPaintingImageView *paintingImageView;
@property (strong, nonatomic) SGOverlayViewController* overlayController;
@property (weak, nonatomic) id<SGContentControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *footerView;

-(void)configWithInfo:(NSDictionary *)userInfo;

@end
