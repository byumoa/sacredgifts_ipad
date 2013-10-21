//
//  SGArtistViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/16/13.
//
//

#import "SGArtistViewController.h"
#import "SGConstants.h"

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

- (IBAction)pressedPainting:(UIButton *)sender
{
    NSLog(@"pressedPainting: %i", sender.tag);
    NSString* paintingName = (NSString*)kPaintingNames[sender.tag-1];
    [self.delegate transitionFromController:self toPaintingNamed:paintingName fromButtonRect:sender.frame withAnimType:kAnimTypeZoomIn];
}

@end
