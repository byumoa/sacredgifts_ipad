//
//  SGNavigationContainerViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGNavigationContainerViewController.h"
#import "SGPaintingContainerViewController.h"
#import "SGContentViewController.h"
#import "SGPaintingViewController.h"
#import "SGWebViewController.h"
#import "ARParentViewController.h"
#import "ARViewController.h"
#import "EAGLView.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "SGDonateViewController.h"

const int kDonateAlertViewTag = 1;

@interface SGNavigationContainerViewController ()
- (void)pressedWebViewBack: (id)sender;
- (void)dismissWebview;
@end

@implementation SGNavigationContainerViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    _backViewControllerIDStr = (NSString*)kControllerIDHomeStr;
}

-(IBAction)pressedBack:(UIButton*)sender
{
    if( self.scanController )
    {
        [self.scanController.view removeFromSuperview];
        self.scanController = nil;
        self.footerView.alpha = _footerLastAlpha;
    }
    else
    {
        if( [self.currentContentController.restorationIdentifier isEqualToString:(NSString*)kControllerIDPaintingContainerStr])
        {
            NSLog(@"_backViewControllerIDStr: %@, _beforePaintingViewControllerIDStr: %@", _backViewControllerIDStr, _beforePaintingViewControllerIDStr);
            if( self.hasSwiped &&
               ![_beforePaintingViewControllerIDStr isEqualToString:@"bloch"] &&
               ![_beforePaintingViewControllerIDStr isEqualToString:@"schwartz"] &&
               ![_beforePaintingViewControllerIDStr isEqualToString:@"hofmann"])
                _beforePaintingViewControllerIDStr = (NSString*)kControllerIDFindAPaintingStr;
            
            _backViewControllerIDStr = _beforePaintingViewControllerIDStr;
            if( [_beforePaintingViewControllerIDStr isEqualToString:(NSString*)kControllerIDPaintingContainerStr])
                _backViewControllerIDStr = (NSString*)kControllerIDFindAPaintingStr;
        }
        else if(   [self.currentContentController.restorationIdentifier isEqualToString:@"bloch"]
                || [self.currentContentController.restorationIdentifier isEqualToString:@"hofman"]
                || [self.currentContentController.restorationIdentifier isEqualToString:@"schwartz"])
            _backViewControllerIDStr = (NSString*)kControllerIDMeetTheArtistsStr;
        else if ([self.currentContentController.restorationIdentifier isEqualToString:(NSString*)kControllerIDStoryOfTheExhibitionStr])
            _backViewControllerIDStr = (NSString*)kControllerIDAboutTheExhibitionStr;
        else
            _backViewControllerIDStr = (NSString*)kControllerIDHomeStr;
    
        [self transitionFromController:self.currentContentController toControllerID:_backViewControllerIDStr fromButtonRect:sender.frame withAnimType:kAnimTypeZoomOut];
        
        [self stopAudio];
    }
}

#pragma mark webview
- (IBAction)pressedDonate:(UIButton *)sender
{
    [[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action" action:@"button_press" label:@"donate" value:nil] build]];
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Donate" message:@"Share your gift of gratitude by supporting the Sacred Gifts exhibition and the Brigham Young University Museum of Art. Thank you!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alertView.tag = kDonateAlertViewTag;
    [alertView show];
}

-(void)pressedFeedback:(UIButton *)sender
{
    SGWebViewController* webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"web"];
    [self presentViewController:webViewController animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }];
    [webViewController configureWebpageFor:webpageTypeFeedback];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self dismissWebview];
    
    [[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createEventWithCategory:@"webview" action:@"error" label:@"no internet connection" value:nil] build]];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"We could not reach the internet at this time" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case kDonateAlertViewTag:
            if( buttonIndex > 0 )
            {
                //[[UIApplication sharedApplication] openURL:[NSURL URLWithString: (NSString*)kDontateURLStr]];
            //For Museum
            
             SGDonateViewController* donateViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"donate"];
             [self presentViewController:donateViewController animated:YES completion:^{
             [[UIApplication sharedApplication] setStatusBarHidden:YES];
             }];
             
            }
            break;
            
        default:
        
            break;
    }
}

-(void)alertViewCancel:(UIAlertView *)alertView
{
    switch (alertView.tag) {
        case kDonateAlertViewTag:
            break;
            
        default:
            [self dismissWebview];
            break;
    }
}

-(void)pressedWebViewBack:(id)sender{
    [self dismissWebview];
}

-(void)dismissWebview{
    [UIView animateWithDuration:0.25 animations:^{
        _webView.alpha = 0;
    } completion:^(BOOL finished) {
        [_webView removeFromSuperview];
    }];
}

#pragma mark Delegate
-(UIViewController*)transitionFromController:(UIViewController *)fromController toControllerID:(const NSString *)toControllerID fromButtonRect:(CGRect)frame withAnimType:(const NSString *)animType
{
    NSString* headerName = [NSString stringWithFormat:@"header_%@", toControllerID];
    self.headerTitleImgView.image = [UIImage imageNamed:headerName];
    
    if( [fromController.restorationIdentifier isEqualToString:@"timeline"] )
        self.hasSwiped = NO;
    
    //Handle Back Button Alpha
    float backBtnAlpha = 1;
    self.backBtn.enabled = backBtnAlpha == 1;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backBtn.alpha = backBtnAlpha;
    }];
    
    SGContentViewController* toController = [self.storyboard instantiateViewControllerWithIdentifier:(NSString *)toControllerID];
    toController.delegate = self;
    
    BOOL isTransitionToPainting = [toController.restorationIdentifier isEqualToString:(NSString*)kControllerIDPaintingContainerStr];
    BOOL isTransitionToArtist = NO;
    if( [toController.restorationIdentifier isEqualToString:(NSString*)kArtistNames[0]]
       ||[toController.restorationIdentifier isEqualToString:(NSString*)kArtistNames[1]]
       ||[toController.restorationIdentifier isEqualToString:(NSString*)kArtistNames[2]])
        isTransitionToArtist = YES;
    BOOL isTransitioningToTimeline = [toController.restorationIdentifier isEqualToString:@"timeline"];
    
    __weak typeof(self) weakSelf = self;
    animTransitionBlock = ^(void)
    {
        toController.view.alpha = 1;
        [weakSelf.view bringSubviewToFront:weakSelf.headerView];
        [weakSelf.view bringSubviewToFront:weakSelf.footerView];
        weakSelf.footerView.alpha = !(isTransitionToPainting||isTransitionToArtist||isTransitioningToTimeline);
    };
    
    [self cycleFromViewController:fromController toViewController:toController fromButtonRect:frame falling:animType];
    
    if (!isTransitionToPainting)
    {
        self.headerView.backgroundColor = [UIColor clearColor];
        self.headerBlurDecoy.backgroundColor = [UIColor clearColor];
    }

    [UIView animateWithDuration:0.25 animations:^{
        if( [self.currentContentController.restorationIdentifier isEqualToString:@"bloch"]
           || [self.currentContentController.restorationIdentifier isEqualToString:@"hofman"]
           || [self.currentContentController.restorationIdentifier isEqualToString:@"schwartz"]
           || [self.currentContentController.restorationIdentifier isEqualToString:@"SacredGifts StoryOfTheExhibition"])
                self.footerView.alpha = 0;
        else if( [toController.restorationIdentifier isEqualToString:(NSString*)kControllerIDFindAPaintingStr] )
                self.footerView.alpha = 1;
        
        if (!isTransitionToPainting)
            self.headerBGImgView.alpha = 1;
        
        if ([toController.restorationIdentifier isEqualToString:(NSString*)kPanoramaStr]){
            self.headerView.alpha = 0;
            self.headerBlurDecoy.alpha = 0;
        }
        else{
            self.headerView.alpha = 1;
            self.headerBlurDecoy.alpha = 1;
        }
    }];
    
    return toController;
}

-(UIViewController*)transitionFromController:(UIViewController *)fromController toPaintingNamed:(NSString *)paintingName fromButtonRect:(CGRect)frame withAnimType:(const NSString *)animType
{
    if ([paintingName rangeOfString:@"aalborg"].location != NSNotFound || [paintingName rangeOfString:@"alborg"].location != NSNotFound)
        paintingName = @"aalborg";
    
    SGPaintingContainerViewController* paintingContainer = (SGPaintingContainerViewController*)[self transitionFromController:fromController toControllerID:kControllerIDPaintingContainerStr fromButtonRect:frame withAnimType:animType];
    
    _beforePaintingViewControllerIDStr = fromController.restorationIdentifier;
    
    [(SGPaintingViewController*)paintingContainer.currentContentController configWithPaintingName:paintingName];
    ((SGPaintingViewController*)paintingContainer.currentContentController).headerView = self.headerView;
    ((SGPaintingViewController*)paintingContainer.currentContentController).headerTitleImgView = self.headerTitleImgView;
    
    NSString* headerName = [NSString stringWithFormat:@"header_%@", paintingName];
    self.headerTitleImgView.image = [UIImage imageNamed:headerName];
    
    self.headerBGImgView.alpha = 0;
    self.footerView.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.headerBlurDecoy.backgroundColor = [UIColor blackColor];
    }];
    
    return paintingContainer;
}

-(void)contentController:(UIViewController *)contentController viewsForBlurredBacking:(NSArray*)views blurredImgName:(NSString *)blurredImgName
{
    _allBlurredViews = [NSMutableArray new];
    [_allBlurredViews addObject:self.headerBlurDecoy];
    [super contentController:contentController viewsForBlurredBacking:views blurredImgName:blurredImgName];
}

- (IBAction)pressedScan:(id)sender
{
    if( self.scanController )
    {
        [self.scanController.view removeFromSuperview];
        self.scanController = nil;
        self.footerView.alpha = _footerLastAlpha;
        self.headerView.alpha = 1;
        self.headerBlurDecoy.alpha = 1;
    }
    else
    {
        [[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action" action:@"button_press" label:@"scan AR" value:nil] build]];
        
        self.scanController = [self.storyboard instantiateViewControllerWithIdentifier:kScanStr];
        [self.view insertSubview:self.scanController.view belowSubview:self.headerView];
        _footerLastAlpha = self.footerView.alpha;
        self.footerView.alpha = 0;
        self.headerView.alpha = 1;
        self.headerBlurDecoy.alpha = 0;
        //set EAGLView delegate
        ((ARViewController*)((ARParentViewController*)self.scanController).arViewController).arView.delegate = self;
    }
}

-(void)scannedPainting:(NSString *)paintingName
{
    SGPaintingContainerViewController* pContainer = (SGPaintingContainerViewController*)[self transitionFromController:self.currentContentController toPaintingNamed:paintingName fromButtonRect:CGRectZero withAnimType:kAnimTypeZoomIn];
    [((SGPaintingViewController*)pContainer.childViewControllers[0]) addTombstoneDelayed:nil];
    
    [self.scanController.view removeFromSuperview];
    self.scanController = nil;
    self.footerView.alpha = 0;
    self.headerView.alpha = 1;
    self.headerBlurDecoy.alpha = 1;
}

-(IBAction)pressedHome:(id)sender
{
    _backViewControllerIDStr = (NSString*)kControllerIDHomeStr;
    [self transitionFromController:self.currentContentController toControllerID:_backViewControllerIDStr fromButtonRect:((UIButton*)sender).frame withAnimType:kAnimTypeZoomOut];
}

@end
