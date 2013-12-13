//
//  SGNarrationOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 11/6/13.
//
//

#import "SGNarrationOverlayViewController.h"
#import "SGConvenienceFunctionsManager.h"

const CGRect kNarrationFrame = {0, 713, 768, 200};

@interface SGNarrationOverlayViewController ()
- (void) updateProgressBar: (NSTimer*)timer;
@end

@implementation SGNarrationOverlayViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 700);
        self.moduleType = kModuleTypeNarration;
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = kNarrationFrame;
    self.playPauseButton.selected = YES;
    
    [self.playOverlay removeFromSuperview];
    [self.playUnderlay addSubview:self.playOverlay];
    
    self.playhead.startX = self.playUnderlay.frame.origin.x;
    self.playhead.endX = self.playUnderlay.frame.origin.x + self.playUnderlay.frame.size.width;
    
    CGPoint center = self.playhead.center;
    center.y = self.playPauseButton.center.y+3;
    center.x = self.playUnderlay.frame.origin.x;
    self.playhead.center = center;
    
    center = self.playUnderlay.center;
    center.y = self.playPauseButton.center.y+5;
    self.playUnderlay.center = center;
}

-(void)updateProgressBar:(NSTimer*)timer
{
    if( !_narrationManager.player.isPlaying )return;
    CGRect frame = self.playOverlay.frame;
    frame.origin = CGPointZero;
    
    CGPoint center = CGPointZero;
    if( _narrationManager.player.duration > 0.0 )
    {
        frame.size.width = _narrationManager.player.currentTime / _narrationManager.player.duration * self.playUnderlay.frame.size.width;
        
        center = self.playhead.center;
        center.x = self.playUnderlay.frame.origin.x + frame.size.width;
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.playhead.center = center;
        } completion:nil];
    }
    
    if( !isnan(frame.size.width) && !isnan(frame.size.height))
    {
        self.playOverlay.frame = frame;
    }
}

-(void)addBackgroundImgWithPath:(NSString *)bgImgPath
{
    [super addBackgroundImgWithPath:bgImgPath];
    
    _narrationManager = [SGNarrationManager sharedManager];
    [self updateProgressBar:nil];
    self.playPauseButton.selected = !_narrationManager.player.isPlaying;
}

- (IBAction)pressedPlayPause:(id)sender
{
    NSString *narrationPath = [[NSBundle mainBundle] pathForResource:@"audio" ofType:@".mp3" inDirectory:self.rootFolderPath];
    
    if( narrationPath )
    {
        _narrationManager = [SGNarrationManager sharedManager];
        if( _narrationManager.player.isPlaying )
            [_narrationManager pauseAudio];
        else
            [_narrationManager playAudioWithPath:narrationPath];
        
        ((UIButton*)sender).selected = !_narrationManager.player.isPlaying;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_progressTimer invalidate];
}

-(void)configureAudioWithPath:(NSString *)rootFolderPath
{
    self.rootFolderPath = rootFolderPath;
    self.screenName = [NSString stringWithFormat:@"%@: %@", self.paintingName, [SGConvenienceFunctionsManager getStringForModule:self.moduleType]];
}

#pragma mark delegate methods
-(void)playhead:(SGMediaPlayhead *)playhead seekingStartedAtPoint:(CGPoint)pt
{
    _isPlaying = _narrationManager.player.isPlaying;
    [_narrationManager.player pause];
}

-(void)playhead:(SGMediaPlayhead *)playhead seekingMovedAtPoint:(CGPoint)pt
{
    float percentComplete = (playhead.center.x - self.playUnderlay.frame.origin.x)/self.playUnderlay.frame.size.width;
    _narrationManager.player.currentTime = _narrationManager.player.duration * percentComplete;
    CGRect frame = self.playOverlay.frame;
    frame.size.width = self.playUnderlay.frame.size.width * percentComplete;
    self.playOverlay.frame = frame;
}

-(void)playhead:(SGMediaPlayhead *)playhead seekingEndedAtPoint:(CGPoint)pt
{
    if( _isPlaying )
        [_narrationManager.player play];
}

@end
