//
//  SGChildrensOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGChildrensOverlayViewController.h"

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
    
    _fingerPaintView = [SGFingerPaintView new];
    _fingerPaintView.frame = self.view.frame;
    _fingerPaintView.userInteractionEnabled = YES;
    _fingerPaintView.backgroundColor = [UIColor redColor];
    _fingerPaintView.maskThis = self.bgImageView;
    _fingerPaintView.backgroundColor = [UIColor clearColor];
    self.bgImageView.userInteractionEnabled = NO;
    [self.view addSubview:_fingerPaintView];
}

- (void)addBackgroundImgWithPath: (NSString*)bgImgPath
{
    [super addBackgroundImgWithPath:bgImgPath];
}

@end
