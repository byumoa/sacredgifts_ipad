//
//  SGPersepectivesOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGMediaSelectionViewController.h"
#import "SGPaintingImageViewDelegate.h"
typedef enum
{
    kPerspectiveOverlayTypeVideo,
    kPerspectiveOverlayTypePanorama
}PerspectiveOverlayType;

@interface SGPersepectivesOverlayViewController : SGMediaSelectionViewController
@property( nonatomic, weak ) id<SGPaintingImageViewDelegate> tappedPaintingDelegate;

- (int)configurePerspectiveOverlayWithPath: (NSString*)folderPath;



@end
