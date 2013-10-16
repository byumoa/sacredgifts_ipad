//
//  SGArtistViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/16/13.
//
//

#import "SGArtistViewController.h"

@interface SGArtistViewController()

- (BOOL) playAudioNamed: (NSString*)audioName;

@end

@implementation SGArtistViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.contentSize = _scrollContentSize;
}

- (IBAction)pressedNarration:(UIButton *)sender
{
    [self playAudioNamed:@"schwartz_bio_audio"];
}

- (BOOL) playAudioNamed: (NSString*)audioName;
{
    NSString *musicPath = [NSString stringWithFormat:@"%@,%@.mp3", [[NSBundle mainBundle] resourcePath], audioName];
    
    if( musicPath )
    {
        NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryAmbient error: nil];
        
        NSError *activationError = nil;
        [[AVAudioSession sharedInstance] setActive: YES error: &activationError];
        
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL: musicURL error: nil];
        [self.player prepareToPlay];
        [self.player setVolume: 1.0];
        self.player.numberOfLoops = 0;
        [self.player play];
        
        return true;
    }
    else
    {
        return false;
    }
}

@end
