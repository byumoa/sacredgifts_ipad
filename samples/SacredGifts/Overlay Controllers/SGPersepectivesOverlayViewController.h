//
//  SGPersepectivesOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGMediaSelectionViewController.h"
typedef enum
{
    kPerspectiveOverlayTypeVideo,
    kPerspectiveOverlayTypePanorama
}PerspectiveOverlayType;

@interface SGPersepectivesOverlayViewController : SGMediaSelectionViewController

- (int)configurePerspectiveOverlayWithPath: (NSString*)folderPath;

@end
