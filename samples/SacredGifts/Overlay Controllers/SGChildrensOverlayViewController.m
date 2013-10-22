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
        
        NSLog(@"SGChilds initWithCoder: %@", aDecoder);
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 66, 768, 892);
    NSLog(@"SGChilds viewDidLoad");
}

- (void)addBackgroundImgWithPath: (NSString*)bgImgPath forgroundImage:(UIImage *)foregroundImg
{
    NSLog(@"SGChilds addBackgroundImgWithPath");
    
    self.fingerPaintView.originalImage = [foregroundImg CGImage];
    self.fingerPaintView.originalImage = [[UIImage imageNamed:@"MainPainting.png"] CGImage];
    
    [super addBackgroundImgWithPath:bgImgPath];
    [self.bgImageView removeFromSuperview];
    [self.view insertSubview:self.bgImageView aboveSubview:self.fingerPaintView];
    [self.fingerPaintView removeFromSuperview];
    [self.view insertSubview:self.fingerPaintView atIndex:0];
}

@end