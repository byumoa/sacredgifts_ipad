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

- (void)addBackgroundImgWithPath: (NSString*)bgImgPath;

@end
