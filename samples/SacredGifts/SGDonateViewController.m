//
//  SGDonateViewController.m
//  SacredGifts
//
//  Created by Ontario on 11/26/13.
//
//

#import "SGDonateViewController.h"

@interface SGDonateViewController ()

@end

@implementation SGDonateViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screenName = @"donate: museum";
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)touchedAnywhere:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
