//
//  SGPaintingViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/23/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPaintingImageView.h"
#import "SGContentControllerDelegate.h"
#import "SGOverlayViewController.h"

@interface SGPaintingViewController : UIViewController <SGPaintingImageViewDelegate, SGOverlayViewControllerDelegate>
{
    CGRect _lastPortraitFrame;
    NSString* _paintingNameStr;
    int _currentFooterBtnX;
}

@property (weak, nonatomic) IBOutlet SGPaintingImageView *paintingImageView;
@property (strong, nonatomic) SGOverlayViewController* overlayController;
@property (weak, nonatomic) id<SGContentControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic) float frameOverlayDelay;
@property (nonatomic) int currentPaintingIndex;

-(void)configWithPaintingName:(NSString *)paintingStr;

- (IBAction)swipeRecognized:(UISwipeGestureRecognizer *)sender;

@end
