//
//  SGContainerViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/23/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGContentControllerDelegate.h"

@class SGContentViewController;

@interface SGContainerViewController : UIViewController<SGContentControllerDelegate>{
    void (^animTransitionBlock)(void);
    NSMutableArray* _allBlurredViews;
}
@property (weak, nonatomic) SGContentViewController* currentContentController;

#pragma mark Navigation
- (void)displayContentController:(UIViewController *)content;
- (void)cycleFromViewController: (UIViewController*)oldC toViewController: (UIViewController*)newC fromButtonRect:(CGRect)frame falling:(const NSString *)animType;
- (void)stopAudio;

@end
