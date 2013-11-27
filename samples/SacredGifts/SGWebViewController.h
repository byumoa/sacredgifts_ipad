//
//  SGWebViewController.h
//  SacredGifts
//
//  Created by Ontario on 10/3/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "GAITrackedViewController.h"

typedef enum
{
    webPageTypeThanks,
    webPageTypeTickets,
    webpageTypeFeedback
}WebpageType;

@interface SGWebViewController : GAITrackedViewController <UIWebViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *webHeaderImgView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)pressedClose:(UIButton *)sender;
- (void)configureWebpageFor: (WebpageType)webpageType;
- (void)configureWebpageForURL: (NSURL*)url;
@end
