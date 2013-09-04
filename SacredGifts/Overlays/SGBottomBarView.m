//
//  SGBottomBarView.m
//  SacredGifts
//
//  Created by Ontario on 9/3/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import "SGBottomBarView.h"

@implementation SGBottomBarView

-(id)initWithCoder:(NSCoder *)aDecoder{
    if( self = [super initWithCoder:aDecoder]){
        self.blurredImageCenter = CGPointMake(-10, -800);
        self.blurredOverlay.center = self.blurredImageCenter;
    }
    
    return self;
}

@end
