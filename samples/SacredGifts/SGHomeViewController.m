//
//  SGHomeViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGHomeViewController.h"
#import "SGConstants.h"

@interface SGHomeViewController ()
- (IBAction)pressedBtn:(UIButton *)sender;
@end

@implementation SGHomeViewController

-(void)viewDidLoad
{
    _blurImageName = @"sg_home_bg-home_blur.png";
    [super viewDidLoad];
    self.screenName = @"home";
}

- (IBAction)pressedBtn:(UIButton *)sender
{
    NSString* toControllerIDStr = (NSString*)kControllerIDHomeStr;
    
    switch (sender.tag) {
        case kNavigationDestinationFindAPainting:
            toControllerIDStr = (NSString*)kControllerIDFindAPaintingStr;
            break;
        case kNavigationDestinationMeetTheArtists:
            toControllerIDStr = (NSString*)kControllerIDMeetTheArtistsStr;
            break;
        case kNavigationDestinationAboutTheExhibition:
            toControllerIDStr = (NSString*)kControllerIDAboutTheExhibitionStr;
            break;
            
        default:
            break;
    }
    [self.delegate transitionFromController:self toControllerID:toControllerIDStr fromButtonRect:sender.frame withAnimType:kAnimTypeZoomIn];
}
@end
