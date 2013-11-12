//
//  SGNarrationOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 11/6/13.
//
//

#import "SGNarrationOverlayViewController.h"

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
    
}

-(void)updateProgressBar:(NSTimer*)timer
{
    CGRect frame = self.playOverlay.frame;
    frame.origin = CGPointMake(0, 0);
    if( _narrationManager.player.duration > 0 )
        frame.size.width = _narrationManager.player.currentTime / _narrationManager.player.duration * 635.0;
    
    self.playOverlay.frame = frame;
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

@end
