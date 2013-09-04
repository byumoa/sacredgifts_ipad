//
//  SGSocialView.m
//  SacredGifts
//
//  Created by Ontario on 8/31/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import "SGSocialView.h"
#import <Social/Social.h>

const CGSize kSocialSize = {768, 237};
const CGPoint kThumbCenter = {120, 120};
const CGPoint kFacebookBtnCenter = {380, 60};
const CGPoint kTwitterBtnCenter = {380, 105};
const CGPoint kEmailBtnCenter = {380, 150};
const CGPoint kThanksBtnCenter = {620, 60};
const CGPoint kOtherBtnCenter = {620, 105};

const NSString* kEmailButtonNrmImgStr = @"SG_General_Share_email.png";
const NSString* kEmailButtonSelImgStr = @"SG_General_Share_email-on.png";
const NSString* kFacebookButtonNrmImgStr = @"SG_General_Share_fb.png";
const NSString* kFacebookButtonSelImgStr = @"SG_General_Share_fb-on.png";
const NSString* kOtherButtonNrmImgStr = @"SG_General_Share_other.png";
const NSString* kOtherButtonSelImgStr = @"SG_General_Share_other-on.png";
const NSString* kTwitterButtonNrmImgStr = @"SG_General_Share_tw.png";
const NSString* kTwitterButtonSelImgStr = @"SG_General_Share_tw-on.png";
const NSString* kThanksButtonNrmImgStr = @"SG_General_Share_thanks.png";
const NSString* kThanksButtonSelImgStr = @"SG_General_Share_thanks-on.png";

const int kEmailButtonTag = 1;
const int kFacebookButtonTag = 2;
const int kOtherButtonTag = 3;
const int kTwitterButtonTag = 4;
const int kThanksButtonTag = 5;

const NSString* kShareInitialText = @"Enjoying Sacred Gifts at the MOA";

@interface SGSocialView(PrivateMethods)
- (void)addButtonstoView;
- (void)pressedSocialBtn: (UIButton*)sender;
- (UIButton*)buttonWithNrmImgStr:(NSString*)nrmImgStr selImgStr: (NSString*)selImgStr andTag:(int)tag;

@end
@implementation SGSocialView

- (id)initWithThumbnail:(UIImage *)thumbnail{
    CGRect frame = CGRectMake(0, 0, kSocialSize.width, kSocialSize.height);
    self = [super initWithFrame:frame];
    if (self) {
        self.thumbnail = thumbnail;
        
        self.clipsToBounds = YES;
        self.autoresizesSubviews = YES;
        
        UIImage* backImg = [UIImage imageNamed:@"SG_General_Module_overlay.png"];
        UIImageView* backingView = [[UIImageView alloc] initWithImage:backImg];
        backingView.frame = frame;
        backingView.contentMode = UIViewContentModeScaleAspectFill;
        backingView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:backingView];
        
        UIImageView* thumbnailImgView = [[UIImageView alloc] initWithImage:thumbnail];
        [self addSubview:thumbnailImgView];
        thumbnailImgView.center = kThumbCenter;
        
        self.blurredOverlay.hidden = YES;
        self.backgroundColor = [UIColor clearColor];
        [self addButtonstoView];
    }
    return self;
}

-(void)addButtonstoView{
    UIButton* button = [self buttonWithNrmImgStr:(NSString*)kEmailButtonNrmImgStr selImgStr:(NSString*)kEmailButtonSelImgStr andTag:kEmailButtonTag];
    button.center = kEmailBtnCenter;
    [self addSubview:button];
    
    button = [self buttonWithNrmImgStr:(NSString*)kFacebookButtonNrmImgStr selImgStr:(NSString*)kFacebookButtonSelImgStr andTag:kFacebookButtonTag];
    button.center = kFacebookBtnCenter;
    [self addSubview:button];
    
    button = [self buttonWithNrmImgStr:(NSString*)kTwitterButtonNrmImgStr selImgStr:(NSString*)kTwitterButtonSelImgStr andTag:kTwitterButtonTag];
    button.center = kTwitterBtnCenter;
    [self addSubview:button];
    
    button = [self buttonWithNrmImgStr:(NSString*)kThanksButtonNrmImgStr selImgStr:(NSString*)kThanksButtonSelImgStr andTag:kThanksButtonTag];
    button.center = kThanksBtnCenter;
    [self addSubview:button];
    
    button = [self buttonWithNrmImgStr:(NSString*)kOtherButtonNrmImgStr selImgStr:(NSString*)kOtherButtonSelImgStr andTag:kOtherButtonTag];
    button.center = kOtherBtnCenter;
    [self addSubview:button];
}

-(UIButton *)buttonWithNrmImgStr:(NSString *)nrmImgStr selImgStr:(NSString *)selImgStr andTag:(int)tag{
    UIButton* returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *nrmImg = [UIImage imageNamed:nrmImgStr];
    [returnBtn setImage:nrmImg forState:UIControlStateNormal];
    [returnBtn setImage:[UIImage imageNamed:selImgStr] forState:UIControlStateHighlighted];
    returnBtn.tag = tag;
    [returnBtn addTarget:self action:@selector(pressedSocialBtn:) forControlEvents:UIControlEventTouchUpInside];
    returnBtn.frame = CGRectMake(0, 0, nrmImg.size.width, nrmImg.size.height);
    
    return returnBtn;
}

-(void)pressedSocialBtn:(UIButton *)sender{

    switch (sender.tag) {
        case kEmailButtonTag:
        {
            MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc] init];
            [mailcontroller setMailComposeDelegate:self];
            [mailcontroller setSubject:@"Sacred Gifts"];
            [mailcontroller setMessageBody:kShareInitialText isHTML:NO];
            [self.delegate presentSocialViewController:mailcontroller];
            NSData *myData = UIImageJPEGRepresentation(self.thumbnail, 1.0);
            [mailcontroller addAttachmentData:myData mimeType:@"image/png" fileName:@"Thumbnail.png"];
        }
            break;
        case kFacebookButtonTag:
            if( [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
            {
                SLComposeViewController *socialSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                [socialSheet setInitialText:(NSString*)kShareInitialText];
                [socialSheet addImage:self.thumbnail];
                [self.delegate presentSocialViewController:socialSheet];
            }
            break;
        case kTwitterButtonTag:
            if( [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            {
                SLComposeViewController *socialSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                [socialSheet setInitialText:(NSString*)kShareInitialText];
                [socialSheet addImage:self.thumbnail];
                [self.delegate presentSocialViewController:socialSheet];
            }
            break;
            
        default:
            break;
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self.delegate dismissSocialMailController];
}

@end
