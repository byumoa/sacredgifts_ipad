//
//  SGIntoMovieViewController.m
//  SacredGifts
//
//  Created by Ontario on 12/2/13.
//
//

#import "SGIntroMovieViewController.h"

NSString* const kIntroMovieStr = @"Sacred Gifts Intro Film FOR IPAD_h264";

@interface SGIntroMovieViewController ()

- (void)configureVideo;

@end

@implementation SGIntroMovieViewController

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
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:kIntroMovieStr ofType:@"mp4"]];
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.moviePlayer.view.frame = CGRectMake(0, 45, 768, 432);
    self.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    [self.view addSubview:self.moviePlayer.view];
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
