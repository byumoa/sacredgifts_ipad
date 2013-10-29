//
//  SGChildrensOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGChildrensOverlayViewController.h"

@interface SGChildrensOverlayViewController()
- (void)placeButtons;
@end

@implementation SGChildrensOverlayViewController
@synthesize fingerPaintView = _fingerPaintView;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 512);
        self.moduleType = kModuleTypeChildrens;
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 66, 768, 892);
}

- (void)addBackgroundImgWithPath: (NSString*)bgImgPath forgroundImage:(UIImage *)foregroundImg
{
    self.fingerPaintView.originalImage = [foregroundImg CGImage];
    
    [super addBackgroundImgWithPath:bgImgPath];
    [self.view bringSubviewToFront:self.bgImageView];
    [self.view sendSubviewToBack:self.fingerPaintView];
}

@end