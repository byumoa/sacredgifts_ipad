//
//  SGTombstoneOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGTombstoneOverlayViewController.h"

@interface SGTombstoneOverlayViewController ()

@end

@implementation SGTombstoneOverlayViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 850);
        self.moduleType = kModuleTypeTombstone;
    }
    
    return self;
}

@end
