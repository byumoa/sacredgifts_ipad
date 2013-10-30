//
//  SGSecondaryOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/24/13.
//
//

#import "SGSecondaryOverlayViewController.h"

const int closeBtnPadding = 6;

@interface SGSecondaryOverlayViewController ()

@end

@implementation SGSecondaryOverlayViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)pressedClose:(UIButton *)sender
{
    NSLog(@"pressedClose on Secondary");
    [self.delegate overlay:self triggersNewOverlayName:self.returnToModuleStr];
}

@end
