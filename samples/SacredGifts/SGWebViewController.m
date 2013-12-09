//
//  SGWebViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/3/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGWebViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"

NSString* const kThanksURLStr = @"http://sacredgifts.byu.edu/say-thank-you/?inapp=true";
NSString* const kTicketsURLStr = @"http://sacredgifts.byu.edu/tickets/?inapp=true";
NSString* const kFeedbackURLStr = @"https://byu.qualtrics.com/SE/?SID=SV_2ivOxPx1IY5WUw5";

NSString* const kThanksImgStr = @"SG_General_header_thanks.png";
NSString* const kTicketsImgStr = @"SG_General_header_reserve.png";
NSString* const kFeedbackImgStr = @"SG_General_header_feedback.png";

@implementation SGWebViewController

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)configureWebpageForURL:(NSURL *)url
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

-(void)configureWebpageFor:(WebpageType)webpageType
{
    NSString* urlStr = @"";
    NSString* headerImgStr = @"";
    
    switch (webpageType) {
        case webPageTypeThanks:
            urlStr = kThanksURLStr;
            headerImgStr = kThanksImgStr;
            self.screenName = @"say thanks webpage";
            break;
        case webpageTypeFeedback:
            urlStr = kFeedbackURLStr;
            headerImgStr = kFeedbackImgStr;
            self.screenName = @"feedback webpage";
            break;
        case webPageTypeTickets:
            urlStr = kTicketsURLStr;
            headerImgStr = kTicketsImgStr;
            self.screenName = @"reserve tickets webpage";
            break;
        default:
            break;
    }
    
    self.webHeaderImgView.image = [UIImage imageNamed:headerImgStr];
    NSURL* url = [NSURL URLWithString:urlStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:120];
    [self.webView loadRequest:request];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

- (IBAction)pressedClose:(UIButton *)sender
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)erro{
    [[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createEventWithCategory:@"webview" action:@"error" label:@"no internet connection" value:nil] build]];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"We could not reach the internet at this time" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}
@end
