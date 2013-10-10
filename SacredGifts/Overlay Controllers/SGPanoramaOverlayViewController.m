//
//  SGPanoramaOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/7/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGPanoramaOverlayViewController.h"

const CGPoint kStartPt = {1392, 512};
const CGPoint kMidPt = {368, 512};
const CGPoint kEndPt = {-656, 512};

@interface SGPanoramaOverlayViewController()
{
    NSArray* _panoImgArr;
    BOOL _isAniamting;
    int _currentImgIndex;
    UIImageView* _currentImageView;
}
- (void)tempPanoStrafing;
- (void)animateNextImageOn;
@end

@implementation SGPanoramaOverlayViewController

-(void)tempPanoStrafing
{
    if( !_isAniamting )
        [self animateNextImageOn];
}

-(void)animateNextImageOn
{
    _currentImgIndex = (_currentImgIndex + 1) % _panoImgArr.count;
    
    NSString* fileStr = [[NSBundle mainBundle] pathForResource:_panoImgArr[_currentImgIndex] ofType:@"jpg" inDirectory:self.rootFolderPath];
    
    UIImageView* nextImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:fileStr]];
    [self.view insertSubview:nextImageView aboveSubview:self.bgImageView];
    nextImageView.center = kStartPt;
    
    [UIView animateWithDuration:6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        if( !_isAniamting )
        {
            
        }
        nextImageView.center = kMidPt;
        _currentImageView.center = kEndPt;
    } completion:^(BOOL finished) {
        [_currentImageView removeFromSuperview];
        _currentImageView = nextImageView;
        [self animateNextImageOn];
    }];

    _isAniamting = YES;
}

-(void)addBackgroundImgWithPath:(NSString *)bgImgPath
{
    [super addBackgroundImgWithPath:bgImgPath];
    [self tempPanoStrafing];
    self.view.center = self.view.superview.center;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 512);
        self.moduleType = kModuleTypePanorama;
        
        _panoImgArr = [NSArray arrayWithObjects:@"pano_f", @"pano_r", @"pano_b", @"pano_l", nil];
    }
    
    return self;
}

- (IBAction)pressedClose:(id)sender
{
    [self.delegate closeOverlay:self];
}
@end
