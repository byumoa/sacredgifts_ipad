//
//  SGAboutTheExhibitionViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/21/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGAboutTheExhibitionViewController.h"

@implementation SGAboutTheExhibitionViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( [super initWithCoder:aDecoder])
    {
        _backgroundPatternStr = @"SG_General_BG_Pattern.png";
        _blurredBackgroundPatternStr = @"SG_General_BG_Pattern_Blur.png";
    }
    
    return self;
}

@end
