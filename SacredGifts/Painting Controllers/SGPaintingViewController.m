//
//  SGPaintingViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/23/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGPaintingViewController.h"

@interface SGPaintingViewController (PrivateAPIs)

- (void) addMainPainting:(NSDictionary*)config;

@end

@implementation SGPaintingViewController

-(void)configWithInfo:(NSDictionary *)userInfo
{
    [self addMainPainting:userInfo];
}

-(void)addMainPainting:(NSDictionary *)config
{
    NSString* paintingName = (NSString*)[config objectForKey:@"paintingName"];
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"MainPainting" ofType:@"png" inDirectory:[NSString stringWithFormat: @"PaintingResources/%@", paintingName]];
    self.paintingImageView.image = [UIImage imageWithContentsOfFile:fullPath];
    NSLog(@"paintingName: %@", paintingName);
    NSLog(@"fullPath: %@", fullPath);
    //self.paintingImageView.delegate = self;
}

@end
