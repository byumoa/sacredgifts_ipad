//
//  SGMeetTheArtistsViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/21/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGMeetTheArtistsViewController.h"
#import "SGConstants.h"

typedef enum
{
    kNavigationDestinationBloch = 4,
    kNavigationDestinationHofman = 5,
    kNavigationDestinationSchwartz = 6,
    kNavigationDestinationTimeline = 7
}ArtistNavigationDestination;

@implementation SGMeetTheArtistsViewController

-(void)viewDidLoad
{
    _blurImageName = @"sg_home_bg-meetartists_blur.png";
    [super viewDidLoad];
    self.screenName = @"meet the artists";
}

- (IBAction)pressedBtn:(UIButton *)sender
{
    NSString* toControllerIDStr = (NSString*)kControllerIDHomeStr;
    
    switch (sender.tag) {
        case kNavigationDestinationBloch:
            toControllerIDStr = (NSString*)kControllerIDBlochStr;
            break;
        case kNavigationDestinationHofman:
            toControllerIDStr = (NSString*)kControllerIDHofmantr;
            break;
        case kNavigationDestinationSchwartz:
            toControllerIDStr = (NSString*)kControllerIDSchwartzStr;
            break;
        case kNavigationDestinationTimeline:
            toControllerIDStr = @"timeline";
            break;
            
        default:
            break;
    }
    
    [self.delegate transitionFromController:self toControllerID:toControllerIDStr fromButtonRect:sender.frame withAnimType:kAnimTypeZoomIn];
}

@end
