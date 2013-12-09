//
//  SGContentViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGContentViewController.h"

const CGRect headerBackerFrame = {0,0,768,62};
const float kUpdateFrequency = 1.0/40;
const float kOffsetMultiplier = 60.0;
const float kBackgroundDepth = 1.0;
const float kWall = 0.25;

@interface SGContentViewController()
- (void)setupMotionManager;
- (void)update: (CGPoint)attitude;
@end

@implementation SGContentViewController

-(void)viewDidLoad
{    
    [super viewDidLoad];
    [self.delegate contentController:self viewsForBlurredBacking:self.blurredViews blurredImgName:_blurImageName];
    [self startParallaxing];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder])
    {
        [self setupMotionManager];
        self.parallaxViews = [NSMutableArray new];
    }
    
    return self;
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)setupMotionManager
{
    _motionManager = [CMMotionManager new];
    _motionManager.deviceMotionUpdateInterval = kUpdateFrequency;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stopParallaxing];
}

-(void)startParallaxing
{
    if( ![_motionManager isDeviceMotionAvailable] )
        return;
    
    __block CGFloat referencePitch = 0.8f;
    __block CGFloat referenceRoll = 0.0f;
    
    [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        CGFloat pitch = [[motion attitude] pitch]/2 - referencePitch;
        CGFloat roll = [[motion attitude] roll]/2 - referenceRoll;
        
        [self update:CGPointMake(pitch, -roll)];
    }];
}

-(void)update:(CGPoint)attitude
{
    if( attitude.x > kWall ) attitude.x = kWall;
    else if( attitude.x < -kWall ) attitude.x = -kWall;
    if( attitude.y > kWall ) attitude.y = kWall;
    else if( attitude.y < -kWall ) attitude.y = -kWall;
    
    float x = 0;//attitude.x * kBackgroundDepth;
    float y = attitude.y * kBackgroundDepth;

    [UIView animateWithDuration:kUpdateFrequency animations:^{
        self.background.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, kOffsetMultiplier * y, kOffsetMultiplier * x);
        
        for (UIImageView* blurredBacking in self.parallaxViews)
            blurredBacking.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, kOffsetMultiplier * y, kOffsetMultiplier * x);
    }];
}

-(void)stopParallaxing
{
    if([_motionManager isDeviceMotionAvailable])
        [_motionManager stopDeviceMotionUpdates];
}


@end
