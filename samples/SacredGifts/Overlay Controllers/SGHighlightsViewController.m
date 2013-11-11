//
//  SGHighlightsViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/25/13.
//
//

#import "SGHighlightsViewController.h"
#import "SGPanoramaOverlayViewController.h"

@implementation SGHighlightsViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 670);
        self.moduleType = kModuleTypeHighlights;
        _moduleTypeStr = (NSString*)kHighlightsStr;
    }
    
    return self;
}

-(void)pressedHighlightBtn:(UIButton *)sender
{
    [super pressedHighlightBtn:sender];
    
    if( ![self.childOverlay isKindOfClass:[SGPanoramaOverlayViewController class]] )
    {
        CGPoint center = self.childOverlay.view.center;
        center.y -= 111;
        self.childOverlay.view.center = center;
    }
}

@end
