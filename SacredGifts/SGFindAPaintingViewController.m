//
//  SGFindAPaintingViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGFindAPaintingViewController.h"
#import "SGConstants.h"

const int kPaintingIDBurial = 1;
const int kPaintingIDCapture = 2;
const int kPaintingIDChildren = 3;
const int kPaintingIDCleansing = 4;
const int kPaintingIDConsolator = 5;
const int kPaintingIDCross = 6;
const int kPaintingIDDenial = 7;
const int kPaintingIDEmmaus = 8;
const int kPaintingIDGarden = 9;
const int kPaintingIDGethsemane = 10;
const int kPaintingIDHealing = 11;
const int kPaintingIDMocking = 12;
const int kPaintingIDResurrection = 13;
const int kPaintingIDRuler = 14;
const int kPaintingIDSavior = 15;
const int kPaintingIDSermon = 16;
const int kPaintingIDShepherds = 17;
const int kPaintingIDTemple = 18;
const int kPaintingIDAalborg = 19;

@implementation SGFindAPaintingViewController

-(void)viewDidLoad
{
    _blurImageName = @"sg_home_bg-findpainting_blur.png";
    [super viewDidLoad];
}

- (IBAction)touchedPainting:(UIButton *)sender
{
    NSString* paintingName = @"";
    switch (sender.tag) {
        case kPaintingIDBurial:
            paintingName = (NSString*)kPaintingNameBurial;
            break;
        case kPaintingIDCapture:
            paintingName = (NSString*)kPaintingNameCapture;
            break;
        case kPaintingIDChildren:
            paintingName = (NSString*)kPaintingNameChildren;
            break;
        case kPaintingIDCleansing:
            paintingName = (NSString*)kPaintingNameCleansing;
            break;
        case kPaintingIDConsolator:
            paintingName = (NSString*)kPaintingNameConsolator;
            break;
        case kPaintingIDCross:
            paintingName = (NSString*)kPaintingNameCross;
            break;
        case kPaintingIDDenial:
            paintingName = (NSString*)kPaintingNameDenial;
            break;
        case kPaintingIDEmmaus:
            paintingName = (NSString*)kPaintingNameEmmaus;
            break;
        case kPaintingIDGarden:
            paintingName = (NSString*)kPaintingNameGarden;
            break;
        case kPaintingIDGethsemane:
            paintingName = (NSString*)kPaintingNameGethsemane;
            break;
        case kPaintingIDHealing:
            paintingName = (NSString*)kPaintingNameHealing;
            break;
        case kPaintingIDMocking:
            paintingName = (NSString*)kPaintingNameMocking;
            break;
        case kPaintingIDResurrection:
            paintingName = (NSString*)kPaintingNameResurrection;
            break;
        case kPaintingIDRuler:
            paintingName = (NSString*)kPaintingNameRuler;
            break;
        case kPaintingIDSavior:
            paintingName = (NSString*)kPaintingNameSavior;
            break;
        case kPaintingIDSermon:
            paintingName = (NSString*)kPaintingNameSermon;
            break;
        case kPaintingIDShepherds:
            paintingName = (NSString*)kPaintingNameShepherds;
            break;
        case kPaintingIDTemple:
            paintingName = (NSString*)kPaintingNameTemple;
            break;
        case kPaintingIDAalborg:
            paintingName = (NSString*)kPaintingNameAalborg;
            break;
            
        default:
            break;
    }
    
    [self.delegate transitionFromController:self toPaintingNamed:paintingName fromButtonRect:sender.frame withAnimType:kAnimTypeZoomIn];
}
@end
