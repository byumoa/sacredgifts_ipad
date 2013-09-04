//
//  SGTitleView.m
//  SacredGifts
//
//  Created by Ontario on 8/31/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import "SGTitleView.h"

@implementation SGTitleView

-(id)initWithTextImage:(UIImage *)textImage
{
    CGRect frame = CGRectMake(0, 0, textImage.size.width, textImage.size.height);
    
    if( self = [super initWithFrame:frame])
    {
        self.clipsToBounds = YES;
        
        UIImage* backImg = [UIImage imageNamed:@"SG_General_Module_overlay.png"];
        UIImageView* backingView = [[UIImageView alloc] initWithImage:backImg];
        [self addSubview:backingView];
        
        UIImageView* textView = [[UIImageView alloc] initWithImage:textImage];
        textView.frame = frame;
        [self addSubview:textView];
        
        self.blurredImageCenter = CGPointMake(-10, -800);
        self.blurredOverlay.center = self.blurredImageCenter;
    }
    
    return self;
}
@end
