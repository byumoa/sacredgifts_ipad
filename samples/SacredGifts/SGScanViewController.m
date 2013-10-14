//
//  SGScanViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/7/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGScanViewController.h"

@interface SGScanViewController ()

@end

@implementation SGScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] )
    {
        self.picker = [UIImagePickerController new];
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.picker.showsCameraControls = NO;
        self.picker.view.frame = self.view.frame;
        self.picker.cameraOverlayView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlay__brackets.png"]];
        [self.view insertSubview:self.picker.view atIndex:0];
    }
}

@end
