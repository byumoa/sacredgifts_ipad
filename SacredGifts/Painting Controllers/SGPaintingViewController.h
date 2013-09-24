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

@interface SGPaintingViewController : UIViewController
{
    ModuleType m_currentModule;
    CGRect m_lastPortraitFrame;
}

@property (weak, nonatomic) IBOutlet SGPaintingImageView *paintingImageView;

-(void)configWithInfo:(NSDictionary *)userInfo;

@end
