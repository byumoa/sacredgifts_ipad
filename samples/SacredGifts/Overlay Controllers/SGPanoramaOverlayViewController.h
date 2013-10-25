//
//  SGPanoramaOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 10/7/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayViewController.h"

@interface SGPanoramaOverlayViewController : SGOverlayViewController
@property (nonatomic, weak) IBOutlet UIImageView* infoStripImgView;

- (IBAction)pressedClose:(id)sender;
-(void)startPanoWithPath: (NSString*)panoFolder;

@end
