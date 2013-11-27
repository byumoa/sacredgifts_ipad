//
//  SGShareViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/3/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGSocialViewController.h"
#import <Social/Social.h>
#import "SGWebViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import <FacebookSDK/FacebookSDK.h>
#import "UWFacebookService.h"

NSString* const kEmailAutofill = @"Enjoying the painting by %@ while using the Sacred Gifts app from the BYU Museum of Art. %@";
NSString* const kTwitterAutofill = @"Viewing this painting while using the @BYUmoa’s #sacredgifts app.";
NSString* const kFacebookAutofill = @"Viewing this painting by %@ and feeling grateful while using the #sacredgifts app from the BYU Museum of Art.";

NSString* const kAppStoreURL = @"https://itunes.apple.com/us/app/sacred-gifts-brigham-young/id723165787?ls=1&mt=8";
int const kOverlayHeight = 236;

@interface SGSocialViewController()
{
    NSArray* _schwartzPaintings;
    NSArray* _hofmannPaintings;
}

- (NSString*)calcArtistForPaintingStr: (NSString*)paintingName;
- (void)doInMuseumFBPostWithImage: (UIImage*)thumbnail;
- (void)doInMuseumTWPostWithImage: (UIImage*)thumbnail;
@end

@implementation SGSocialViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 720);
        self.moduleType = kModuleTypeSocial;
        
        _schwartzPaintings = @[@"garden", @"aalborg"];
        _hofmannPaintings = @[@"capture", @"temple", @"ruler", @"gethsemane", @"savior"];
    }
    
    return self;
}

- (IBAction)pressedSocialBtn:(id)sender
{
    UIImage* thumbnail = [UIImage imageNamed:self.paintingName];
    
    NSString* mediaType;
    switch (((UIButton*)sender).tag)
    {
        case SocialMediaTypeFacebook:
        {
            /*
            NSString* artist = [self calcArtistForPaintingStr:self.paintingName];
            NSString* autofillStr = [NSString stringWithFormat:kFacebookAutofill, artist];
            
            SLComposeViewController *socialSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [socialSheet setInitialText:autofillStr];
            [socialSheet addImage:thumbnail];
            [socialSheet addURL:[NSURL URLWithString:kAppStoreURL]];
            [self presentViewController:socialSheet animated:YES completion:^{}];
             */
            mediaType = @"facebook";
            [self doInMuseumFBPostWithImage:thumbnail];
        }
            break;
        case SocialMediaTypeTwitter:
        {
            /*
            SLComposeViewController *socialSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [socialSheet setInitialText:(NSString*)kTwitterAutofill];
            [socialSheet addImage:thumbnail];
            [socialSheet addURL:[NSURL URLWithString:kAppStoreURL]];
            [self presentViewController:socialSheet animated:YES completion:^{}];
             */
            mediaType = @"twitter";
        }
            break;
        case SocialMediaTypeEmail:
        {
            /*
            NSString* artist = [self calcArtistForPaintingStr:self.paintingName];
            NSString* autofillStr = [NSString stringWithFormat:kEmailAutofill, artist, kAppStoreURL];
            
            MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
            [mailController setMailComposeDelegate:self];
            [mailController setSubject:@"Sacred Gifts"];
            [mailController setMessageBody:autofillStr isHTML:NO];
            [self presentViewController:mailController animated:YES completion:^{}];
            NSData *myData = UIImageJPEGRepresentation(thumbnail, 1.0);
            [mailController addAttachmentData:myData mimeType:@"image/png" fileName:@"Thumbnail.png"];
             */
            mediaType = @"email";
        }
            break;
        case 4:
        {
            SGWebViewController* webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"web"];
            [self presentViewController:webViewController animated:YES completion:nil];
            [webViewController configureWebpageFor:webPageTypeThanks];
        }
            break;
        default:
            break;
    }
    
    if( ((UIButton*)sender).tag != 4)
        [[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action" action:@"button_press" label:mediaType value:nil] build]];
}

-(void)doInMuseumFBPostWithImage:(UIImage *)thumbnail
{
    SGWebViewController* webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"web"];
    [self presentViewController:webViewController animated:YES completion:nil];
    NSURL *url = [NSURL URLWithString:@"https://m.facebook.com/photo.php?fbid=577324159007371&set=a.577324135674040.1073741825.126723597400765&type=3&theater"];
    [webViewController configureWebpageForURL:url];
}

- (void)doInMuseumTWPostWithImage: (UIImage*)thumbnail
{
    SGWebViewController* webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"web"];
    [self presentViewController:webViewController animated:YES completion:nil];
    NSURL *url = [NSURL URLWithString:@"https://twitter.com/intent/tweet?source=webclient&text=Viewing+this+Franz+Schwartz+painting+and+feeling+grateful+for+sacredgifts"];
    [webViewController configureWebpageForURL:url];
}

-(NSString *)calcArtistForPaintingStr:(NSString *)paintingName
{
    for (NSString* pName in _schwartzPaintings ) {
        if( [pName isEqualToString:paintingName])
            return @"Frans Schwartz";
    }
    for (NSString* pName in _hofmannPaintings ) {
        if( [pName isEqualToString:paintingName])
            return @"Heinrich Hofmann";
    }
    
    return @"Carl Bloch";
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)addBackgroundImgWithImgName:(NSString *)bgImgName
{
    [super addBackgroundImgWithImgName:bgImgName];
    self.paintingThumbnail.image = [UIImage imageNamed:self.paintingName];
    CGRect frame = self.view.frame;
    frame.size.height = kOverlayHeight;
}
@end
