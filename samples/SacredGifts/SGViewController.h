//
//  SGViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGNavigationContainerViewController.h"

@interface SGViewController : SGNavigationContainerViewController
@property (weak, nonatomic) IBOutlet UIImageView *splash;
@property (weak, nonatomic) IBOutlet UIImageView *splashLogo;
@property (weak, nonatomic) IBOutlet UIImageView *splashArtists;
@property (weak, nonatomic) IBOutlet UIImageView *splashDonors;

- (void)resetSplash;

@end
