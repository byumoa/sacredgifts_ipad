//
//  SGFacebookViewController.h
//  SacredGifts
//
//  Created by Ontario on 11/27/13.
//
//

#import <UIKit/UIKit.h>

@interface SGFacebookViewController : UIViewController <UIWebViewDelegate>
{
    BOOL _hasLoaded;
    NSString* _currentFacebookPage;
}
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)pressedClose:(UIButton *)sender;
- (void)configureWebpageForURLStr: (NSString*)urlStr;
@end
