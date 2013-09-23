//
//  SGFindAPaintingViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGFindAPaintingViewController.h"
#import "SGConstants.h"

@implementation SGFindAPaintingViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder])
    {
        _backgroundPatternStr = @"SG_Home_BG-FindPainting_Pattern.png";
        _blurredBackgroundPatternStr = @"SG_Home_BG-FindPainting_Pattern_Blurred.png";
    }
    
    return self;
}

- (IBAction)touchedPainting:(UIButton *)sender {
    //[self.delegate transitionFromController:self toControllerID:kControllerIDPaintingContainerStr fromButtonRect:sender.frame withAnimType:kAnimTypeZoomIn];
    [self.delegate transitionFromController:self toPaintingID:@"Dummy ID" fromButtonRect:sender.frame withAnimType:kAnimTypeZoomIn];
}
@end
