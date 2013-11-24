//
//  SGContentViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "GAITrackedViewController.h"
#import "SGContentControllerDelegate.h"
#import <CoreMotion/CoreMotion.h>

@interface SGContentViewController : GAITrackedViewController
{
    NSString* _blurImageName;
    CMMotionManager *_motionManager;
}

@property(strong, nonatomic) id<SGContentControllerDelegate> delegate;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *blurredViews;

@property (weak, nonatomic) IBOutlet UIImageView* background;
@property (strong, nonatomic) IBOutlet NSMutableArray* parallaxViews;

- (void)startParallaxing;
- (void)stopParallaxing;

@end
