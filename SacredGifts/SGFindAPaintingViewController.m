//
//  SGFindAPaintingViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/5/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import "SGFindAPaintingViewController.h"
#import "SGPaintingViewController.h"

@implementation SGFindAPaintingViewController

-(void)pressedPainting:(id)sender
{
    [self transitionToPainting:@"christ_and_the_rich_young_ruler"];
}

-(void)transitionToPainting: (const NSString*)paintingName
{
    UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    SGPaintingViewController* paintingViewController = (SGPaintingViewController*)[mainStoryBoard instantiateViewControllerWithIdentifier:@"painting"];
    [self addChildViewController:paintingViewController];
    [self.view addSubview:paintingViewController.view];
    
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"paintingConfig" ofType:@"plist" inDirectory:[NSString stringWithFormat: @"PaintingResources/%@", paintingName]];
    NSMutableDictionary *config = [NSMutableDictionary dictionaryWithContentsOfFile:fullPath];
    [config setObject:paintingName forKey:@"paintingName"];
    
    [paintingViewController configWithDictionary:(NSDictionary*)config];
}
/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"SGFindAPaintingViewController: prepareForSegue");
    [super prepareForSegue:segue sender:sender];
    NSString* paintingName = @"christ_and_the_rich_young_ruler";
    
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"paintingConfig" ofType:@"plist" inDirectory:[NSString stringWithFormat: @"PaintingResources/%@", paintingName]];
    
    NSMutableDictionary *config = [NSMutableDictionary dictionaryWithContentsOfFile:fullPath];
    [config setObject:paintingName forKey:@"paintingName"];
    
    ((SGPaintingViewController*)segue.destinationViewController).config = (NSDictionary*)config;
}
*/
@end
