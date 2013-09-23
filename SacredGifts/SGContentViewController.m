//
//  SGContentViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGContentViewController.h"

const CGRect headerBackerFrame = {0,0,768,62};

@implementation SGContentViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder])
    {
        _backgroundPatternStr = @"SG_Home_BG-Home_Pattern.png";
        _blurredBackgroundPatternStr = @"SG_Home_BG-Home_Pattern_Blurred.png";
    }
    
    return self;
}

@end
