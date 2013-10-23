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
    
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgressBar:) userInfo:nil repeats:YES];
}

-(void)updateProgressBar:(NSTimer*)timer
{
    float progressLength = _musicManager.player.currentTime / _musicManager.player.duration * 635.0;
    CGRect frame = self.playOverlay.frame;
    frame.size.width = progressLength;
    
    self.playOverlay.frame = frame;
}

-(void)addBackgroundImgWithPath:(NSString *)bgImgPath
{
    [super addBackgroundImgWithPath:bgImgPath];
    
    SGMusicManager* musicManager = [SGMusicManager sharedManager];
    if( !musicManager.player.isPlaying )
        [self pressedPlayPause:nil];
}

- (IBAction)pressedPlayPause:(id)sender
{
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"audio" ofType:@".mp3" inDirectory:self.rootFolderPath];
    
    if( musicPath )
    {
        _musicManager = [SGMusicManager sharedManager];
        if( _musicManager.player.isPlaying )
            [_musicManager pauseAudio];
        else
            [_musicManager playAudioWithPath:musicPath];
        
        ((UIButton*)sender).selected = _musicManager.player.isPlaying;
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Missing Asset" message:@"audio.mp3 has not been added for this overlay" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

@end

