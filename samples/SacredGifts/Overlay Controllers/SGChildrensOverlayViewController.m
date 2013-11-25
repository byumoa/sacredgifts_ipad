//
//  SGChildrensOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGChildrensOverlayViewController.h"
#import "ScratchableView.h"
#import "SGConvenienceFunctionsManager.h"
#import "SGPanoramaOverlayViewController.h"
#import "SGOverlayView.h"

const float kTriggerDistance = 80;
NSString* const kArtistInstructionStr = @"childrens_%@_prompt.png";

@interface SGChildrensOverlayViewController()

- (float) calcDistanceBetween: (CGPoint)pt1 and: (CGPoint)pt2;
- (void)animateButtonOn:(UIButton*)button;

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
    
    _buttonNrmImgStr = @"childrens_btn.png";
    _buttonHilImgStr = @"childrens_btn-on.png";
}

-(SGOverlayViewController*)pressedHighlightBtn:(UIButton *)sender
{
    SGOverlayViewController* childGAIViewController = [super pressedHighlightBtn:sender];
    NSString* moduleStr = [SGConvenienceFunctionsManager getStringForModule:childGAIViewController.moduleType];
    childGAIViewController.screenName = [NSString stringWithFormat:@"%@: childrens %@", self.paintingName, moduleStr];
    
    if( ![self.childOverlay isKindOfClass:[SGPanoramaOverlayViewController class]] )
    {
        CGPoint center = self.childOverlay.view.center;
        center.y -= 45;
        self.childOverlay.view.center = center;
        
        ((SGOverlayView*)self.childOverlay.view).myBlurredBacking.center = center;
    }
    
    return self.childOverlay;
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
    
    NSString* artistName = [SGConvenienceFunctionsManager artistForPainting:self.paintingName abbreviated:YES];
    NSString* promptImgStr = [NSString stringWithFormat:kArtistInstructionStr, artistName];
    self.instructionPrompt.image = [UIImage imageNamed:promptImgStr];
    
    if( self.closeButton )
        self.closeButton.center = CGPointMake(self.view.frame.size.width - 21, self.view.frame.size.height - 875);
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLoc = [((UITouch*)[touches anyObject]) locationInView:self.scratchableView];
    
    for( UIButton* button in _buttons )
    {
        if( [self calcDistanceBetween:touchLoc and:button.center] < kTriggerDistance && button.alpha < 1 )
            [self animateButtonOn:button];
    }
}

-(void)animateButtonOn:(UIButton *)button
{
    CGRect frame = button.frame;
    CGPoint center = button.center;
    
    CGRect startFrame = frame;
    startFrame.size.width *= 0.25;
    startFrame.size.height *= 0.25;
    CGRect bounceFrame = frame;
    bounceFrame.size.width *= 2.0;
    bounceFrame.size.height *= 2.0;
    
    button.frame = startFrame;
    button.center = center;
    [UIView animateWithDuration:0.5 animations:^{
        button.alpha = 1;
        button.frame = bounceFrame;
        button.center = center;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            button.frame = frame;
            button.center = center;
        }];
    }];
}

-(float)calcDistanceBetween:(CGPoint)pt1 and:(CGPoint)pt2
{
    return sqrtf((pt1.x-pt2.x)*(pt1.x-pt2.x) + (pt1.y-pt2.y)*(pt1.y-pt2.y));
}

-(void)prepareForMediaStart
{
    for( UIButton* button in _buttons )
        button.hidden = YES;
    
    self.instructionPrompt.hidden = YES;
}

-(void)prepareForMediaEnd
{
    for( UIButton* button in _buttons )
        button.hidden = NO;
    
    self.instructionPrompt.hidden = NO;
}

@end