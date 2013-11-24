//
//  SGPaintingViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/23/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "GAITrackedViewController.h"
#import "SGPaintingImageView.h"
#import "SGContentControllerDelegate.h"
#import "SGOverlayViewController.h"

@interface SGPaintingViewController : GAITrackedViewController <SGPaintingImageViewDelegate, SGOverlayViewControllerDelegate>
{
    CGRect _lastPortraitFrame;
    NSString* _paintingNameStr;
    int _currentFooterBtnX;
    BOOL _tombstoneShown;
}

@property (weak, nonatomic) IBOutlet SGPaintingImageView *paintingImageView;
@property (strong, nonatomic) SGOverlayViewController* overlayController;
@property (weak, nonatomic) id<SGContentControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic) float frameOverlayDelay;
@property (nonatomic) int currentPaintingIndex;
@property (weak, nonatomic) IBOutlet UIView *templeButtonsView;
@property (weak, nonatomic) IBOutlet UIButton *templeBtn1880;
@property (weak, nonatomic) IBOutlet UIButton *templeBtnLater;

-(void)configWithPaintingName:(NSString *)paintingStr;

- (IBAction)swipeRecognized:(UISwipeGestureRecognizer *)sender;
- (IBAction)pressedTempleToggle:(id)sender;

+ (BOOL)chromeHidden;
+ (void)setChromeHidden: (BOOL)val;

@end
