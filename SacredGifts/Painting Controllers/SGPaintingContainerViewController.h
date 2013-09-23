//
//  SGPaintingContainerViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/23/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGContainerViewController.h"

@interface SGPaintingContainerViewController : SGContainerViewController
@property NSString* paintingInfoStr;
@property(strong, nonatomic) id<SGContentControllerDelegate> delegate;
- (void) configWithInfo: (NSDictionary*)userInfo;

@end
