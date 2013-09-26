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
    
    NSArray* blurredViews = [NSArray arrayWithObject:self.tombstone];
    
    NSString* paintingName = (NSString*)[userInfo objectForKey:@"paintingName"];
    NSString *blurredPaintingPath = [[NSBundle mainBundle] pathForResource:@"MainPainting Blurred" ofType:@"png" inDirectory:[NSString stringWithFormat: @"PaintingResources/%@", paintingName]];
    
    [self.delegate contentController:self viewsForBlurredBacking:blurredViews blurredImgPath:blurredPaintingPath];
}

-(void)addMainPainting:(NSDictionary *)config
{
    NSString* paintingName = (NSString*)[config objectForKey:@"paintingName"];
    NSString *paintingPath = [[NSBundle mainBundle] pathForResource:@"MainPainting" ofType:@"png" inDirectory:[NSString stringWithFormat: @"PaintingResources/%@", paintingName]];
    self.paintingImageView.image = [UIImage imageWithContentsOfFile:paintingPath];
    
    NSString *tombstonePath = [[NSBundle mainBundle] pathForResource:@"tombstone" ofType:@"png" inDirectory:[NSString stringWithFormat: @"PaintingResources/%@", paintingName]];
    self.tombstone.image = [UIImage imageWithContentsOfFile:tombstonePath];
}

@end
