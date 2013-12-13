//
//  SGShareViewController.h
//  SacredGifts
//
//  Created by Ontario on 10/3/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayViewController.h"
#import <MessageUI/MessageUI.h>
#import "SGWebViewController.h"

typedef enum
{
    SocialMediaTypeFacebook = 1,
    SocialMediaTypeTwitter = 2,
    SocialMediaTypeEmail = 3
}SocialMediaType;

@interface SGSocialViewController : SGOverlayViewController<MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) NSString* paintingName;
@property (weak, nonatomic) IBOutlet UIImageView *paintingThumbnail;
@property (weak, nonatomic) SGWebViewController* webViewController;

- (IBAction)pressedSocialBtn:(id)sender;
- (IBAction)pressedSignOut:(id)sender;

@end
