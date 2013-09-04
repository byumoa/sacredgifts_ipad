//
//  SGSummaryView.m
//  SacredGifts
//
//  Created by Ontario on 8/31/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import "SGSummaryView.h"

@implementation SGSummaryView

-(id)initWithTextImage:(UIImage *)textImage
{
    CGRect frame = CGRectMake(0, 0, textImage.size.width, textImage.size.height);
    
    if( self = [super initWithFrame:frame] )
    {
        self.clipsToBounds = YES;
        self.autoresizesSubviews = YES;
        
        UIImage* backImg = [UIImage imageNamed:@"SG_General_Module_Overlay_Hofmann.png"];
        UIImageView* backingView = [[UIImageView alloc] initWithImage:backImg];
        backingView.contentMode = UIViewContentModeScaleAspectFill;
        backingView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        backingView.frame = frame;
        [self addSubview:backingView];
        
        UIImageView* textView = [[UIImageView alloc] initWithImage:textImage];
        textView.frame = frame;
        textView.contentMode = UIViewContentModeScaleAspectFill;
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self addSubview:textView];
        
        /*
        CGRect frame =  self.blurredOverlay.frame;
        frame.origin.x += 10;
        frame.origin.y += 10;
        
        self.blurredImageCenter = CGPointMake(-10, -600);
        self.blurredOverlay.center = self.blurredImageCenter;
         */
        self.blurredOverlay.hidden = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

@end
