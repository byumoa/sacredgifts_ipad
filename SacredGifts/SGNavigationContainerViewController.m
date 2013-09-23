//
//  SGNavigationContainerViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGNavigationContainerViewController.h"
#import "SGConstants.h"
#import "SGPaintingContainerViewController.h"
#import "SGContentViewController.h"

@interface SGNavigationContainerViewController ()
- (void)pressedWebViewBack: (id)sender;
- (void)dismissWebview;
@end

@implementation SGNavigationContainerViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    _lastViewControllerIDStr = (NSString*)kControllerIDHomeStr;
    self.backBtn.alpha = 0.5;
    self.backBtn.enabled = NO;
}

-(IBAction)pressedBack:(UIButton*)sender
{
    [self transitionFromController:self.currentContentController toControllerID:_lastViewControllerIDStr fromButtonRect:sender.frame withAnimType:kAnimTypeZoomOut];
}

#pragma mark webview
- (IBAction)pressedDonate:(UIButton *)sender
{
    //Create Webview
    _donateWebView = [UIWebView new];
    _donateWebView.frame = self.view.frame;
    [_donateWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:(NSString*)kDontateURLStr]]];
    _donateWebView.delegate = self;
    
    //Webview Close Button
    UIButton* closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [closeBtn setTitle:@"DONE" forState:UIControlStateNormal];
    closeBtn.frame = kWebviewBackBtnFrm;
    [closeBtn addTarget:self action:@selector(pressedWebViewBack:) forControlEvents:UIControlEventTouchUpInside];
    [_donateWebView addSubview:closeBtn];
    
    //Webview Transition On
    _donateWebView.alpha = 0;
    [self.view addSubview:_donateWebView];
    [UIView animateWithDuration:0.25 animations:^{
        _donateWebView.alpha = 1;
    }];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.activityIndicator = [UIActivityIndicatorView new];
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.activityIndicator.hidesWhenStopped = YES;
    [self.activityIndicator startAnimating];
    self.activityIndicator.center = CGPointMake(webView.frame.size.width/2, webView.frame.size.height/2);
    [webView addSubview:self.activityIndicator];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)erro{
    [self dismissWebview];
}

-(void)pressedWebViewBack:(id)sender{
    [self dismissWebview];
}

-(void)dismissWebview{
    [UIView animateWithDuration:0.25 animations:^{
        _donateWebView.alpha = 0;
    } completion:^(BOOL finished) {
        [_donateWebView removeFromSuperview];
    }];
}

#pragma mark Delegate
-(UIViewController*)transitionFromController:(UIViewController *)fromController toControllerID:(const NSString *)toControllerID fromButtonRect:(CGRect)frame withAnimType:(const NSString *)animType
{
    _lastViewControllerIDStr = fromController.restorationIdentifier;
    
    float backBtnAlpha = 1;
    if( [toControllerID isEqualToString: (NSString*)kControllerIDHomeStr] )
        backBtnAlpha = 0.5;
    self.backBtn.enabled = backBtnAlpha == 1;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backBtn.alpha = backBtnAlpha;
    }];
    
    SGContentViewController* toController = [self.storyboard instantiateViewControllerWithIdentifier:(NSString *)toControllerID];
    toController.delegate = self;
    
    __weak typeof(self) weakSelf = self;
    animTransitionBlock = ^(void){
        //newC.view.frame = self.view.frame;
        toController.view.alpha = 1;
        [weakSelf.view bringSubviewToFront:weakSelf.headerView];
        [weakSelf.view bringSubviewToFront:weakSelf.footerView];
        weakSelf.footerView.alpha = ![toController.restorationIdentifier isEqualToString:(NSString*)kControllerIDPaintingContainerStr];
        /*
         CGRect f = self.view.frame;
         oldC.view.frame = CGRectMake(f.origin.x - f.size.width/2,
         f.origin.y - f.size.height/2,
         f.size.width * 2, f.size.height*2);
         */
    };
    
    [self cycleFromViewController:fromController toViewController:toController fromButtonRect:frame falling:animType];
    
    return toController;
}

-(void)transitionFromController:(UIViewController *)fromController toPaintingID:(const NSString *)toPaintingID fromButtonRect:(CGRect)frame withAnimType:(const NSString *)animType
{
    SGPaintingContainerViewController* paintingContainer = (SGPaintingContainerViewController*)[self transitionFromController:fromController toControllerID:kControllerIDPaintingContainerStr fromButtonRect:frame withAnimType:animType];
    
    [paintingContainer configWithInfo:nil];
}

@end
