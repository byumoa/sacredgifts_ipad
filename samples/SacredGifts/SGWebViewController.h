//
//  SGWebViewController.h
//  SacredGifts
//
//  Created by Ontario on 10/3/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    webPageTypeThanks,
    webPageTypeTickets,
    webpageTypeFeedback
}WebpageType;

@interface SGWebViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *webHeaderImgView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)pressedClose:(UIButton *)sender;
- (void)configureWebpageFor: (WebpageType)webpageType;
@end
