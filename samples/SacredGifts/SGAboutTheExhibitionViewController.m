//
//  SGAboutTheExhibitionViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/21/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGAboutTheExhibitionViewController.h"
#import "SGConstants.h"

const int kNavigationDestinationStoryOfTheExhibition = 9324;

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
            
        default:
            break;
    }
    
    NSLog(@"%i: %@", sender.tag, toControllerIDStr);
    [self.delegate transitionFromController:self toControllerID:toControllerIDStr fromButtonRect:sender.frame withAnimType:kAnimTypeZoomIn];
}

@end
