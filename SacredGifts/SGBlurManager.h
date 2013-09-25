//
//  SGBlurManager.h
//  SacredGifts
//
//  Created by Ontario on 9/25/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGBlurManager : NSObject
{
    UIImage* _currentBlurImg;
    CGRect _blurFrame;
}

+ (id)sharedManager;

- (void)setBlurImageWithName: (NSString*)imageNameStr andFrame:(CGRect)frame;
- (void)setBlurImageWithPath: (NSString*)imagePathStr;
- (UIView*)blurBackingForView: (UIView*)view;

@end
