//
//  SGTopBarView.m
//  SacredGifts
//
//  Created by Ontario on 9/3/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import "SGTopBarView.h"

@implementation SGTopBarView

-(id)initWithCoder:(NSCoder *)aDecoder{
    if( self = [super initWithCoder:aDecoder]){
        self.blurredImageCenter = CGPointMake(-10, 200);
        self.blurredOverlay.center = self.blurredImageCenter;
    }
    
    return self;
}

@end
