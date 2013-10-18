//
//  SGFindAPaintingViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGFindAPaintingViewController.h"
#import "SGConstants.h"

const int kArtistHofmanTag = 1;
const int kArtistSchwartzTag = 2;
const int kArtistBlochTag = 3;

@implementation SGFindAPaintingViewController

-(void)viewDidLoad
{
    _blurImageName = @"sg_home_bg-findpainting_blur.png";
    [super viewDidLoad];
}

- (IBAction)touchedPainting:(UIButton *)sender
{
    NSString* paintingName = (NSString*)kPaintingNames[sender.tag-1];
    [self.delegate transitionFromController:self toPaintingNamed:paintingName fromButtonRect:sender.frame withAnimType:kAnimTypeZoomIn];
}

- (IBAction)touchedArtist:(id)sender
{
    NSString* targetID;
    switch (((UIButton*)sender).tag) {
        case kArtistHofmanTag:
            targetID = (NSString*)kControllerIDHofmantr;
            break;
        case kArtistSchwartzTag:
            targetID = (NSString*)kControllerIDSchwartzStr;
            break;
        case kArtistBlochTag:
        default:
            targetID = (NSString*)kControllerIDBlochStr;
            break;
    }
    [self.delegate transitionFromController:self toControllerID:targetID fromButtonRect:CGRectZero withAnimType:kAnimTypeZoomIn];
}
@end