//
//  SGNavigationContainerViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGContainerViewController.h"

@interface SGNavigationContainerViewController : SGContainerViewController <SGContentControllerDelegate, UIWebViewDelegate>
{
    NSString* _backViewControllerIDStr;
    UIWebView* _donateWebView;
    NSMutableArray* _allBlurredViews;
}

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) UIActivityIndicatorView* activityIndicator;

- (IBAction)pressedBack:(UIButton*)sender;
- (IBAction)pressedDonate:(UIButton *)sender;
@end
