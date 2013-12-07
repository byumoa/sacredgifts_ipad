//
//  SGPanoramaOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/7/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGPanoramaOverlayViewController.h"
#import "SGEAGLView.h"

const CGPoint kStartPt = {1392, 512};
const CGPoint kMidPt = {368, 512};
const CGPoint kEndPt = {-656, 512};

@interface SGPanoramaOverlayViewController()

@end

@implementation SGPanoramaOverlayViewController

-(void)addBackgroundImgWithPath:(NSString *)bgImgPath
{
    [super addBackgroundImgWithPath:bgImgPath];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.bgImageView.image.size.width, self.bgImageView.image.size.height);
    self.view.center = self.view.superview.center;
    [self.bgImageView removeFromSuperview];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 512);
        self.moduleType = kModuleTypePanorama;
    }
    
    return self;
}

- (IBAction)pressedClose:(id)sender
{
    [((SGEAGLView*)self.view) stopPano];
    [super pressedClose:sender];
}

-(void)startPanoWithPath: (NSString*)panoFolder
{
    [((SGEAGLView*)self.view) startPanoWithPath:panoFolder];
    NSString* infoImgStr = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@"png" inDirectory:panoFolder];
    self.infoStripImgView.image = [UIImage imageWithContentsOfFile:infoImgStr];
    [self.closeButton removeFromSuperview];
    [self.infoStripImgView addSubview:self.closeButton];
    self.closeButton.center = CGPointMake(self.infoStripImgView.frame.size.width - 15, self.infoStripImgView.frame.size.height/2);
}
@end
