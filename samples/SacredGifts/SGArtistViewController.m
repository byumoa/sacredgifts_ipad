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
    //NSString *musicPath = [NSString stringWithFormat:@"%@,%@.mp3", [[NSBundle mainBundle] resourcePath], audioName];
    
    return YES;
}

@end
