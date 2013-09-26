//
//  SGContentControllerDelegate.h
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SGContentControllerDelegate <NSObject>
@optional
- (UIViewController*)transitionFromController: (UIViewController*)fromController toControllerID: (const NSString*)toControllerID fromButtonRect: (CGRect)frame withAnimType: (const NSString*)animType;
- (void)transitionFromController: (UIViewController*)fromController toPaintingNamed: (const NSString*)paintingName fromButtonRect: (CGRect)frame withAnimType: (const NSString*)animType;
- (void)contentController:(UIViewController *)contentController viewsForBlurredBacking:(NSArray*)views blurredImgName:(NSString*)blurredImgName;
- (void)contentController:(UIViewController *)contentController viewsForBlurredBacking:(NSArray*)views blurredImgPath:(NSString*)blurredImgPath;
@end
