//
//  SGPersepectivesOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayViewController.h"
typedef enum
{
    kPerspectiveOverlayTypeVideo,
    kPerspectiveOverlayTypePanorama
}PerspectiveOverlayType;

@interface SGPersepectivesOverlayViewController : SGOverlayViewController

- (void)configurePerspectiveOverlayWithPath: (NSString*)folderPath;

@end
