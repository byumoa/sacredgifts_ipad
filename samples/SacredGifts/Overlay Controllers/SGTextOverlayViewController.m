//
//  SGTextOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/23/13.
//
//

#import "SGTextOverlayViewController.h"

@interface SGTextOverlayViewController ()

@end

@implementation SGTextOverlayViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 850);
        self.moduleType = kModuleTypeText;
    }
    
    return self;
}

@end