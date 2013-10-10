//
//  SGPanoramaOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/7/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGPanoramaOverlayViewController.h"

@interface SGPanoramaOverlayViewController()
{
    NSArray* _panoImgArr;
}
- (void)tempPanoStrafing;
@end

@implementation SGPanoramaOverlayViewController

-(void)tempPanoStrafing
{
    NSLog(@"tempPanoStrafing");
}

-(void)addBackgroundImgWithPath:(NSString *)bgImgPath
{
    [super addBackgroundImgWithPath:bgImgPath];
    [self tempPanoStrafing];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 512);
        self.moduleType = kModuleTypePanorama;
        
        _panoImgArr = [NSArray arrayWithObjects:@"pano_f.jpg", @"pano_l.jpg", @"pano_b.jpg", @"pano_r.jpg", nil];
    }
    
    return self;
}

- (IBAction)pressedClose:(id)sender
{
    [self.delegate closeOverlay:self];
}
@end
