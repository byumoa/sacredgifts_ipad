//
//  SGViewController.m
//  SacredGifts
//
//  Created by Ontario on 8/27/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import "SGViewController.h"

const NSString* kPaintingNameChristAndTheRichYoungRulerStr = @"christ_and_the_rich_young_ruler";

@interface SGViewController ()
- (void)transitionToPainting: (const NSString*)paintingName;
@end

@implementation SGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	//[self transitionToPainting:kPaintingNameChristAndTheRichYoungRulerStr];
}

-(void)transitionToPainting: (const NSString*)paintingName
{
    UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    _paintingViewController = (SGPaintingViewController*)[mainStoryBoard instantiateViewControllerWithIdentifier:@"painting"];
    [self addChildViewController:_paintingViewController];
    [self.view addSubview:_paintingViewController.view];
    
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"paintingConfig" ofType:@"plist" inDirectory:[NSString stringWithFormat: @"PaintingResources/%@", paintingName]];
    
    NSMutableDictionary *config = [NSMutableDictionary dictionaryWithContentsOfFile:fullPath];
    [config setObject:paintingName forKey:@"paintingName"];
    
    [_paintingViewController configWithDictionary:(NSDictionary*)config];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
