//
//  SGHighlightsViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/25/13.
//
//

#import "SGHighlightsViewController.h"
#import "SGPanoramaOverlayViewController.h"
#import "SGOverlayView.h"
#import "SGBlurManager.h"

@interface SGHighlightsViewController()

- (void)animateButtonsOn;

@end

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

-(void)configureWithPath:(NSString *)folderPath
{
    [super configureWithPath:folderPath];
    
    [self animateButtonsOn];
}

-(void)animateButtonsOn
{
    for( int i = 0; i < _buttons.count; i++ )
    {
        UIButton* button = _buttons[i];
        
        CGRect frame = button.frame;
        CGPoint center = button.center;
        
        CGRect startFrame = frame;
        startFrame.size.width *= 0.9;
        startFrame.size.height *= 0.9;
        CGRect bounceFrame = frame;
        bounceFrame.size.width *= 1.1;
        bounceFrame.size.height *= 1.1;
        
        button.frame = startFrame;
        button.center = center;
        [UIView animateWithDuration:0.4 delay:i*0.1 options:Nil animations:^{
            button.frame = bounceFrame;
            button.center = center;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                button.frame = frame;
                button.center = center;
            }];
        }];
    }
}

-(void)pressedHighlightBtn:(UIButton *)sender
{
    [super pressedHighlightBtn:sender];

    NSString* btnFolderPath = [NSString stringWithFormat:@"%@/%@_%i", self.rootFolderPath, _moduleTypeStr, sender.tag];
    NSString* highlightImgPath = [[NSBundle mainBundle] pathForResource:@"highlight" ofType:@"png" inDirectory:btnFolderPath];
    
    self.currentHighlightView = [[UIView alloc] initWithFrame:self.view.frame];
    self.currentHighlightView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [self.view insertSubview:self.currentHighlightView belowSubview:self.childOverlay.view];
    
    UIImageView *highlightImgView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:highlightImgPath]];
    [self.currentHighlightView addSubview:highlightImgView];
    highlightImgView.center = self.currentHighlightView.center;
    
    //Accessing BlurManager
    SGBlurManager* blurManager = [SGBlurManager sharedManager];
    NSString* highlightBlurImgPath = [[NSBundle mainBundle] pathForResource:@"highlight-blur" ofType:@"png" inDirectory:btnFolderPath];
    [blurManager setBlurImageWithPath:highlightBlurImgPath];
    UIView* blurBacking = [blurManager blurBackingForView:self.childOverlay.view];
    [self.currentHighlightView addSubview:blurBacking];
    //blurBacking.center = [self.currentHighlightView convertPoint:self.childOverlay.view.center toView:self.view];
    CGRect frame = self.childOverlay.view.frame;
    frame.origin.y -= 131;
    blurBacking.frame = frame;
    
     self.currentHighlightView.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.currentHighlightView.alpha = 1;
    }];
    
    if( ![self.childOverlay isKindOfClass:[SGPanoramaOverlayViewController class]] )
    {
        CGPoint center = self.childOverlay.view.center;
        center.y -= 111;
        self.childOverlay.view.center = center;
        
        ((SGOverlayView*)self.childOverlay.view).myBlurredBacking.center = center;
    }
}

-(void)prepareForMediaStart
{
    [UIView animateWithDuration:0.25 animations:^{
        for( UIButton* button in _buttons )
            button.alpha = 0;
    }];
    
    NSString* detailImgPath = [[NSBundle mainBundle] pathForResource:@"highlight" ofType:@"png" inDirectory:self.childOverlay.rootFolderPath];
    UIImageView* highlightImgView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:detailImgPath]];
    [self.view addSubview:highlightImgView];
    highlightImgView.center = self.view.center;
}

-(void)prepareForMediaEnd
{
    [super prepareForMediaEnd];
    [self animateButtonsOn];
    [UIView animateWithDuration:0.25 animations:^{
        self.currentHighlightView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.currentHighlightView removeFromSuperview];
    }];
}

@end
