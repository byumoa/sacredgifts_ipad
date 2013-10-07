//
//  SGPanoramaOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/7/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGPanoramaOverlayViewController.h"

@implementation SGPanoramaOverlayViewController

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
    [self.delegate closeOverlay:self];
}
@end
