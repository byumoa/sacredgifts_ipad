//
//  SGOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/27/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayViewController.h"

@interface SGOverlayViewController ()
- (void)configureBGImage;
@end

@implementation SGOverlayViewController
@synthesize rootFolderPath = _rootFolderPath;

- (void)addBackgroundImgWithPath: (NSString*)bgImgPath
{
    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:bgImgPath]];
    [self configureBGImage];
}

-(void)addBackgroundImgWithImgName:(NSString *)bgImgName
{
    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bgImgName]];
    [self configureBGImage];
}

-(void)configureBGImage
{
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.bgImageView.image.size.width, self.bgImageView.image.size.height);
    [self.view insertSubview:self.bgImageView atIndex:0];
    self.view.center = _centerPos;
    
    //Place view 41px above footer bar
    if( self.moduleType != kModuleTypeChildrens )
    {
        int yHeight = 1024 - 70 - 41 - self.view.frame.size.height/2;
        self.view.center = CGPointMake(768/2, yHeight);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) playAudioNamed: (NSString*)audioName;
{
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:audioName ofType:@".mp3" inDirectory:self.rootFolderPath];
    
    if( musicPath )
    {
        NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryAmbient error: nil];
    
        NSError *activationError = nil;
        [[AVAudioSession sharedInstance] setActive: YES error: &activationError];
    
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL: musicURL error: nil];
        [self.player prepareToPlay];
        [self.player setVolume: 1.0];
        self.player.numberOfLoops = -1;
        [self.player play];
        
        return true;
    }
    else
    {
        return false;
    }
}

@end
