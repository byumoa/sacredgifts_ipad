//
//  SGTextOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/23/13.
//
//

#import "SGTextOverlayViewController.h"

//Y-Pos = screenHeight - footerHeight - buffer - overlayHeight
//Needs to be variable
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
    
    //self.view.frame = kTextFrame;
}

-(void)addBackgroundImgWithPath:(NSString *)bgImgPath
{
    [super addBackgroundImgWithPath:bgImgPath];
    CGPoint center = self.closeButton.center;
    if( self.view.frame.size.height == 800 )
        center.y = self.view.frame.size.height - 30;
    else
        center.y = 20;
    
    self.closeButton.center = center;
}

@end