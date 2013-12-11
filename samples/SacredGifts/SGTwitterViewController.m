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

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screenName = @"twitter";
}

-(void)pressedClose:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)configureWebpageForURLStr:(NSString *)urlStr
{
    /*
    NSLog(@"urlStr: %@", urlStr);
    _currentTwitterPage = [urlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSLog(@"_currentTwitterPage: %@", _currentTwitterPage);
    NSURL *url = [NSURL URLWithString:_currentTwitterPage];
    NSLog(@"url.description: %@", url.description);
    [self openSocialPage:url];
     */
    NSString *body = urlStr;
    CFStringRef encodedBody = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)body, NULL, CFSTR("&"), kCFStringEncodingUTF8);
    NSString *urlString = [NSString stringWithFormat:@"%@", (__bridge NSString *)encodedBody];
    CFRelease(encodedBody);
    NSURL *url = [NSURL URLWithString:urlString];
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
    UIImageView* blueOverlay = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackTopBar.png"]];
    [self.webview addSubview:blueOverlay];
    blueOverlay.userInteractionEnabled = YES;
    
    [self.activityIndicator stopAnimating];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* urlStr = [request URL].description;
    
    if( !_hasLoaded ||
       [urlStr rangeOfString:@"https://twitter.com/intent/tweet/update"].location != NSNotFound )
    {
        _hasLoaded = YES;
        return YES;
    }
    
    if( [urlStr rangeOfString:@"https://twitter.com/intent/tweet/complete"].location != NSNotFound )
    {
        [self pressedClose:nil];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Twitter" message:@"Update Successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    
    return NO;
}

@end
