//
//  SGAudioViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/23/13.
//
//

#import "SGAudioViewController.h"
#import "SGAbstractAudioManager.h"
#import "SGConvenienceFunctionsManager.h"

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

    CGRect frame = self.playOverlay.frame;
    frame.size.width = 0;
    self.playOverlay.frame = frame;
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(updateProgressBar:) userInfo:nil repeats:YES];
    
    CGPoint center = self.playUnderlay.center;
    center.y = self.playPauseButton.center.y+5;
    self.playUnderlay.center = center;
}

-(void)updateProgressBar:(NSTimer*)timer
{
    CGRect frame = self.playOverlay.frame;
    
    if( _audioManager.player.duration > 0 )
        frame.size.width = _audioManager.player.currentTime / _audioManager.player.duration * 635.0;
        //frame.size.width = (_audioManager.player.currentTime / _audioManager.player.duration) * self.playUnderlay.frame.size.width;
    
    self.playOverlay.frame = frame;
}

-(void)addBackgroundImgWithPath:(NSString *)bgImgPath
{
    [super addBackgroundImgWithPath:bgImgPath];
}

-(void)configureAudioWithPath:(NSString *)rootFolderPath
{
    self.rootFolderPath = rootFolderPath;
    self.screenName = [NSString stringWithFormat:@"%@: %@", self.paintingName, [SGConvenienceFunctionsManager getStringForModule:self.moduleType]];
}

- (IBAction)pressedPlayPause:(id)sender{}

@end

