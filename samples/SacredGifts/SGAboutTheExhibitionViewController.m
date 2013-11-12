//
//  SGAboutTheExhibitionViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/21/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGAboutTheExhibitionViewController.h"
#import "SGConstants.h"
#import "SGWebViewController.h"

const int kNavigationDestinationStoryOfTheExhibition = 9324;
const int kNavigationReservations = 456;

@implementation SGAboutTheExhibitionViewController

-(void)viewDidLoad
{
    _blurImageName = @"sg_home_bg-exhibition_blur.png";
    [super viewDidLoad];
}

- (IBAction)pressedBtn:(UIButton *)sender
{
    NSString* toControllerIDStr = (NSString*)kControllerIDHomeStr;
    
    switch (sender.tag) {
        case kNavigationDestinationStoryOfTheExhibition:
            toControllerIDStr = (NSString*)kControllerIDStoryOfTheExhibitionStr;
            break;
        case kNavigationReservations:
        {
            SGWebViewController* webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"web"];
            [self presentViewController:webViewController animated:YES completion:nil];
            [webViewController configureWebpageFor:webpageTypeFeedback];
        }
            break;
        default:
            break;
    }
    
    NSLog(@"%i: %@", sender.tag, toControllerIDStr);
    [self.delegate transitionFromController:self toControllerID:toControllerIDStr fromButtonRect:sender.frame withAnimType:kAnimTypeZoomIn];
}

@end
