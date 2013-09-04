//
//  SGClosableOverlayView.m
//  SacredGifts
//
//  Created by Ontario on 9/2/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import "SGClosableOverlayView.h"

const NSString* closeButtonImageNrm = @"SG_General_Module_CloseBtn";
const NSString* closeButtonImageSel = @"SG_General_Module_CloseBtn-on";

@interface SGClosableOverlayView()
- (void) addCloseButton;
@end

@implementation SGClosableOverlayView

- (id)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ){
        [self addCloseButton];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if( self = [super initWithCoder:aDecoder] ){
        [self addCloseButton];
    }
    return self;
}

- (id)init{
    if( self = [super init] ){
        [self addCloseButton];
    }
    return self;
}

-(void)addCloseButton
{
    //Close Button
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.tag = 9876;
    UIImage *closeButtonNormal = [UIImage imageNamed:(NSString*)closeButtonImageNrm];
    [closeButton setImage:closeButtonNormal forState:UIControlStateNormal];
    [closeButton setImage:[UIImage imageNamed:(NSString*)closeButtonImageSel] forState:UIControlStateSelected];
    closeButton.frame = CGRectMake(0, 0, closeButtonNormal.size.width, closeButtonNormal.size.height);
    [self addSubview:closeButton];
    [closeButton addTarget:self action:@selector(pressedClose:) forControlEvents:UIControlEventTouchUpInside];
    closeButton.center = CGPointMake(745, 25);
    
    self.closeButton = closeButton;
    closeButton.alpha = 1;
    self.userInteractionEnabled = YES;
}

-(void)pressedClose:(UIButton *)sender
{
    [self.delegate overlayClosed:self];
    self.closeButton.alpha = 0;
}

@end
