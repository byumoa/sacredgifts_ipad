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
#import "SGPaintingContainerViewController.h"
#import "SGPaintingViewController.h"
#import "SGConvenienceFunctionsManager.h"

@interface SGArtistViewController()

- (BOOL) playAudioNamed: (NSString*)audioName;
- (void) swipeRecognized: (UISwipeGestureRecognizer*)swipeRecognizer;

@end

@implementation SGArtistViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.contentSize = _scrollContentSize;
    UISwipeGestureRecognizer* swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeRecognizer];
    
    swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRecognizer];
}

-(void)swipeRecognized:(UISwipeGestureRecognizer *)swipeRecognizer
{
    int direction = 1;
    NSString* swipeDir = (NSString*)kAnimTypeSwipeRight;
    
    if( swipeRecognizer.direction == UISwipeGestureRecognizerDirectionLeft )
    {
        direction = -1;
        swipeDir = (NSString*)kAnimTypeSwipeLeft;
    }
    
    int nextArtistIndex = self.view.tag + direction;
    if( nextArtistIndex < 0 )
        nextArtistIndex += 3;
    nextArtistIndex %= 3;
    
    NSString* nextArtistName = (NSString*)kArtistNames[nextArtistIndex];
    [self.delegate transitionFromController:self toControllerID:nextArtistName fromButtonRect:CGRectZero withAnimType:swipeDir];
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
    
    sender.selected = ((SGNarrationManager*)[SGNarrationManager sharedManager]).player.isPlaying;
}

- (BOOL)playAudioNamed: (NSString*)audioName;
{
    NSString *narrationPath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], audioName];
    [[SGNarrationManager sharedManager] playAudioWithPath:narrationPath];
    
    return YES;
}

- (IBAction)pressedPainting:(UIButton *)sender
{
    NSString* paintingName = (NSString*)kPaintingNames[sender.tag-1];
    SGPaintingContainerViewController* paintingViewController = (SGPaintingContainerViewController*)[self.delegate transitionFromController:self toPaintingNamed:paintingName fromButtonRect:sender.frame withAnimType:kAnimTypeZoomIn];
    ((SGPaintingViewController*)paintingViewController.currentContentController).fromArtist = [SGConvenienceFunctionsManager artistForPainting:paintingName abbreviated:YES];
}



@end
