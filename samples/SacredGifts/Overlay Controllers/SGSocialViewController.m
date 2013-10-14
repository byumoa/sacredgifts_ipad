//
//  SGShareViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/3/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGSocialViewController.h"

@interface SGSocialViewController ()

@end

@implementation SGSocialViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 720);
        self.moduleType = kModuleTypeSocial;
    }
    
    return self;
}

- (IBAction)pressedSocialBtn:(id)sender {
}
@end
