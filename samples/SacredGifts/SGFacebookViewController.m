//
//  SGFacebookViewController.m
//  SacredGifts
//
//  Created by Ontario on 11/27/13.
//
//

#import "SGFacebookViewController.h"

@interface SGFacebookViewController ()
- (void)openSocialPage: (NSURL*)url;
@end

@implementation SGFacebookViewController

-(void)pressedClose:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)configureWebpageForURLStr:(NSString *)urlStr
{
    _currentFacebookPage = urlStr;
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
    UIView* coverOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, 602, 768, 600)];
    coverOverlay.backgroundColor = [UIColor colorWithRed:235/255.0 green:238/255.0 blue:244/255.0 alpha:255/255.0];
    [self.webview addSubview:coverOverlay];
    
    UIView* commentsOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, 574, 200, 30)];
    commentsOverlay.backgroundColor = [UIColor colorWithRed:235/255.0 green:238/255.0 blue:244/255.0 alpha:255/255.0];
    [self.webview addSubview:commentsOverlay];
    
    UIImageView* blueOverlay = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BlueOverLay.png"]];
    [self.webview addSubview:blueOverlay];
    blueOverlay.userInteractionEnabled = YES;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* urlStr = [request URL].description;
    NSLog(@"urlStr: %@", urlStr);
    
    if( !_hasLoaded ||
       [urlStr rangeOfString:@"m.facebook.com/story.php"].location != NSNotFound ||
       [urlStr rangeOfString:@"m.facebook.com/logout.php"].location != NSNotFound ||
       [urlStr rangeOfString:@"m.facebook.com/login.php"].location != NSNotFound ||
       [urlStr rangeOfString:@"https://m.facebook.com/?stype"].location != NSNotFound
       )
    {
        _hasLoaded = YES;
        return YES;
    }
    
    if( [urlStr rangeOfString:@"m.facebook.com/profile.php"].location != NSNotFound )
    {
        NSLog(@"LOGGED IN!");
        NSURL* url = [NSURL URLWithString:@"https://m.facebook.com/photo.php?fbid=577324159007371&set=a.577324135674040.1073741825.126723597400765&type=3&theater"];
        [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
        return NO;
    }
    
    if( [urlStr rangeOfString:@"m.facebook.com/messages/read"].location != NSNotFound )
    {
        [self pressedClose:nil];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Message Successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return NO;
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

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError: %@", error);
    //UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Trouble connecting to the internet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //[alert show];
    //[self pressedClose:nil];
}

@end
