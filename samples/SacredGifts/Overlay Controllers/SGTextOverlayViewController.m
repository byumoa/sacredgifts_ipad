//
//  SGTextOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/23/13.
//
//

#import "SGTextOverlayViewController.h"

//Y-Pos = screenHeight - footerHeight - buffer - overlayHeight
//Height = 1024 - 70 - 41 - 183
const CGRect kTextFrame = {0, 730, 768, 183};

@implementation SGTextOverlayViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 850);
        self.moduleType = kModuleTypeText;
    }
    
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.frame = kTextFrame;
}

-(void)addBackgroundImgWithPath:(NSString *)bgImgPath
{
    [super addBackgroundImgWithPath:bgImgPath];
    self.view.frame = kTextFrame;
}

@end