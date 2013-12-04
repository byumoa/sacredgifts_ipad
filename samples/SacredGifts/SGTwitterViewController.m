//
//  SGFacebookViewController.m
//  SacredGifts
//
//  Created by Ontario on 11/27/13.
//
//

#import "SGTwitterViewController.h"

@interface SGTwitterViewController ()
- (void)openSocialPage: (NSURL*)url;
@end

@implementation SGTwitterViewController

-(void)pressedClose:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)configureWebpageForURLStr:(NSString *)urlStr
{
    _currentTwitterPage = urlStr;
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [self openSocialPage:url];
}

-(void)openSocialPage:(NSURL *)url
{
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
    
    self.webview.delegate = self;
    self.webview.scrollView.scrollEnabled = NO;
    self.webview.scrollView.bounces = NO;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* urlStr = [request URL].description;
    
    if( !_hasLoaded )
    {
        _hasLoaded = YES;
        return YES;
    }
    
    if( [urlStr rangeOfString:@"m.facebook.com/a/sharer.php"].location != NSNotFound )
    {
        [self pressedClose:nil];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Post Successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    
    return YES;
}

@end
