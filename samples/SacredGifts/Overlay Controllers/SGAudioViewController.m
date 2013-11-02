//
//  SGAudioViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/23/13.
//
//

#import "SGAudioViewController.h"

@interface SGAudioViewController ()

- (void) updateProgressBar: (NSTimer*)timer;

@end

@implementation SGAudioViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 700);
        self.moduleType = kModuleTypeMusic;
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(updateProgressBar:) userInfo:nil repeats:YES];
}

-(void)updateProgressBar:(NSTimer*)timer
{
    CGRect frame = self.playOverlay.frame;
    if( _narrationManager.player.duration > 0 )
        frame.size.width = _narrationManager.player.currentTime / _narrationManager.player.duration * 635.0;
    
    self.playOverlay.frame = frame;
}

-(void)addBackgroundImgWithPath:(NSString *)bgImgPath
{
    [super addBackgroundImgWithPath:bgImgPath];
}

-(void)configureAudioWithPath:(NSString *)rootFolderPath
{
    self.rootFolderPath = rootFolderPath;
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
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Missing Asset" message:@"audio.mp3 has not been added for this overlay" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

@end

