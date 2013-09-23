//
//  SGMeetTheArtistsViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/21/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGMeetTheArtistsViewController.h"

@implementation SGMeetTheArtistsViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( [super initWithCoder:aDecoder])
    {
        _backgroundPatternStr = @"SG_Home_BG-MeetArtists_Pattern.png";
        _blurredBackgroundPatternStr = @"SG_Home_BG-MeetArtists_Pattern_Blurred.png";
    }
    
    return self;
}

@end
