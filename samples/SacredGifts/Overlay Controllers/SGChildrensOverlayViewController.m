//
//  SGChildrensOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGChildrensOverlayViewController.h"
#import "ScratchableView.h"

const float kTriggerDistance = 40;

@interface SGChildrensOverlayViewController()

- (float) calcDistanceBetween: (CGPoint)pt1 and: (CGPoint)pt2;

@end

@implementation SGChildrensOverlayViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 512);
        self.moduleType = kModuleTypeChildrens;
        _moduleTypeStr = (NSString*)kChildrensStr;
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 66, 768, 892);
}

- (void)addBackgroundImgWithPath: (NSString*)bgImgPath forgroundImage:(UIImage *)foregroundImg
{
    [self.scratchableView configWithGreyscaleOverlay:bgImgPath]; 
}

-(void)configureWithPath:(NSString *)folderPath
{
    [super configureWithPath:folderPath];
    for( UIButton* button in _buttons )
        button.alpha = 0;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLoc = [((UITouch*)[touches anyObject]) locationInView:self.scratchableView];
    
    for( UIButton* button in _buttons )
    {
        if( [self calcDistanceBetween:touchLoc and:button.center] < kTriggerDistance )
            [UIView animateWithDuration:0.25 animations:^{
                button.alpha = 1;
            }];
    }
}

-(float)calcDistanceBetween:(CGPoint)pt1 and:(CGPoint)pt2
{
    return sqrtf((pt1.x-pt2.x)*(pt1.x-pt2.x) + (pt1.y-pt2.y)*(pt1.y-pt2.y));
}

@end