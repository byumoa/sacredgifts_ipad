//
//  SGOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/27/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGOverlayViewController : UIViewController
{
    NSString* _bgImagePath;
    CGPoint _centerPos;
}
@property(nonatomic, strong) UIImageView* bgImageView;

- (void)addBackgroundImgWithPath: (NSString*)bgImgPath;
- (void)addBackgroundImgWithImgName: (NSString*)bgImgName;

@end
