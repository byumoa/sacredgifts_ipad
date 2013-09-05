//
//  SGNavigationViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/5/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import "SGNavigationViewController.h"

@implementation SGNavigationViewController

-(void)pressedBack:(id)sender{
    NSLog(@"pressed back");
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
