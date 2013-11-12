//
//  SGArtistViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/16/13.
//
//

#import "SGArtistViewController.h"
#import "SGConstants.h"
#import "SGNarrationManager.h"

@interface SGArtistViewController()

- (BOOL) playAudioNamed: (NSString*)audioName;

@end

@implementation SGArtistViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.contentSize = _scrollContentSize;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SGNarrationManager pause];
}

- (IBAction)pressedNarration:(UIButton *)sender
{
    if(((SGNarrationManager*)[SGNarrationManager sharedManager]).player.isPlaying)
        [SGNarrationManager pause];
    else
        [self playAudioNamed:_narrationStr];
}

- (BOOL) playAudioNamed: (NSString*)audioName;
{
    NSString *narrationPath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], audioName];
    [[SGNarrationManager sharedManager] playAudioWithPath:narrationPath];
    
    return YES;
}

- (IBAction)pressedPainting:(UIButton *)sender
{
    NSString* paintingName = (NSString*)kPaintingNames[sender.tag-1];
    [self.delegate transitionFromController:self toPaintingNamed:paintingName fromButtonRect:sender.frame withAnimType:kAnimTypeZoomIn];
}



@end
