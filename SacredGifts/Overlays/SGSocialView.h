//
//  SGSocialView.h
//  SacredGifts
//
//  Created by Ontario on 8/31/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import "SGClosableOverlayView.h"
#import <MessageUI/MessageUI.h>

@interface SGSocialView : SGClosableOverlayView<MFMailComposeViewControllerDelegate>
@property (nonatomic,weak) UIImage* thumbnail;

- (id)initWithThumbnail: (UIImage*)thumbnail;

@end
