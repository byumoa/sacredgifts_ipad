//
//  SGIntoMovieViewController.m
//  SacredGifts
//
//  Created by Ontario on 12/2/13.
//
//

#import "SGIntroMovieViewController.h"
#import "SGNavigationContainerViewController.h"

NSString* const kIntroMovieStr = @"Sacred_Gifts_Intro_Film_FOR_IPAD";
CGRect const kMovieFramePortrait = {0, 45, 768, 432};
CGRect const kMovieFrameLandscape = {0, 0, 1024, 768};

@interface SGIntroMovieViewController ()

- (void)configureVideo;

@end

@implementation SGIntroMovieViewController

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if( UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        self.moviePlayer.view.frame = kMovieFrameLandscape;
        ((SGNavigationContainerViewController*)self.delegate).headerView.alpha = 0;
    }
    else
    {
        self.moviePlayer.view.frame = kMovieFramePortrait;
        self.moviePlayer.view.center = self.view.center;
        ((SGNavigationContainerViewController*)self.delegate).headerView.alpha = 1;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self configureVideo];
}

- (void)configureVideo
{
    NSString* path = [[NSBundle mainBundle] pathForResource:kIntroMovieStr ofType:@"mp4" inDirectory:@"PaintingResources"];

    if(!path) return;
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.moviePlayer.view.frame = kMovieFramePortrait;
    self.moviePlayer.view.center = self.view.center;
    self.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    [self.view addSubview:self.moviePlayer.view];
    self.moviePlayer.backgroundView.backgroundColor = [UIColor whiteColor];
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
