//
//  SGShareViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/3/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGSocialViewController.h"
#import <Social/Social.h>

NSString* const kShareInitialText = @"Enjoying Sacred Gifts at the MOA";

@implementation SGSocialViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 720);
        self.moduleType = kModuleTypeSocial;
    }
    
    return self;
}

- (IBAction)pressedSocialBtn:(id)sender
{
    UIImage* thumbnail = [UIImage imageNamed:self.paintingName];
    
    switch (((UIButton*)sender).tag)
    {
        case SocialMediaTypeFacebook:
        {
            if( [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
            {
                SLComposeViewController *socialSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                [socialSheet setInitialText:(NSString*)kShareInitialText];
                [socialSheet addImage:thumbnail];
                [self presentViewController:socialSheet animated:YES completion:^{}];
            }
        }
            break;
        case SocialMediaTypeTwitter:
        {
            if( [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            {
                SLComposeViewController *socialSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                [socialSheet setInitialText:(NSString*)kShareInitialText];
                [socialSheet addImage:thumbnail];
                [self presentViewController:socialSheet animated:YES completion:^{}];
            }
        }
            break;
        case SocialMediaTypeEmail:
        {
            MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
            [mailController setMailComposeDelegate:self];
            [mailController setSubject:@"Sacred Gifts"];
            [mailController setMessageBody:kShareInitialText isHTML:NO];
            [self presentViewController:mailController animated:YES completion:^{}];
            NSData *myData = UIImageJPEGRepresentation(thumbnail, 1.0);
            [mailController addAttachmentData:myData mimeType:@"image/png" fileName:@"Thumbnail.png"];
        }
            break;
        default:
            break;
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
