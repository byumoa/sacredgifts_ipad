//
//  SGShareViewController.h
//  SacredGifts
//
//  Created by Ontario on 10/3/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGOverlayViewController.h"
#import <MessageUI/MessageUI.h>

typedef enum
{
    SocialMediaTypeFacebook = 1,
    SocialMediaTypeTwitter = 2,
    SocialMediaTypeEmail = 3
}SocialMediaType;

@interface SGSocialViewController : SGOverlayViewController<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *paintingThumbnail;

- (IBAction)pressedSocialBtn:(id)sender;

@end
