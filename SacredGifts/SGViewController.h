//
//  SGViewController.h
//  SacredGifts
//
//  Created by Ontario on 8/27/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPaintingViewController.h"

@interface SGViewController : UIViewController
{
    SGPaintingViewController *_paintingViewController;
}
@property (weak, nonatomic) IBOutlet UIImageView *spalshImgView;
@end
