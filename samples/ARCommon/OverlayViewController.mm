/*==============================================================================
Copyright (c) 2010-2013 QUALCOMM Austria Research Center GmbH.
All Rights Reserved.
Qualcomm Confidential and Proprietary
==============================================================================*/

#import <AVFoundation/AVFoundation.h>
#import <QCAR/QCAR.h>
#import <QCAR/CameraDevice.h>
#import "OverlayViewController.h"
#import "OverlayView.h"
#import "QCARutils.h"

@interface OverlayViewController (PrivateMethods)
+ (void) determineCameraCapabilities:(struct tagCameraCapabilities *) pCapabilities;
- (void) startAnimatedOverlay;
- (void) fireHelpPrompt: (NSTimer*)timer;
@end

@implementation OverlayViewController

- (id) init
{
    if ((self = [super init]) != nil)
    {
        selectedTarget = 0;
        qUtils = [QCARutils getInstance];
        UIImageView* brackets = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlay__brackets.png"]];
        [self.view addSubview:brackets];
        [self startAnimatedOverlay];
    }
        
    return self;
}

-(void)startAnimatedOverlay
{
    self.animatedOverlay = [[UIView alloc] initWithFrame:self.view.frame];
    
    UIImageView* bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sg_home_ar_load_bg"]];
    [self.animatedOverlay addSubview:bgImageView];
    
    UIImageView* text1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sg_home_ar_text1"]];
    text1.center = CGPointMake(768/2-3, self.view.center.y - 121);
    [self.animatedOverlay addSubview:text1];
    text1.alpha = 0;
    [UIView animateWithDuration:0.5 delay:2.0 options:0 animations:^{
        text1.alpha = 1;
    } completion:nil];
    
    UIImageView* text2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sg_home_ar_text2"]];
    text2.center = CGPointMake(768/2-3, self.view.center.y - 75);
    [self.animatedOverlay addSubview:text2];
    text2.alpha = 0;
    [UIView animateWithDuration:0.5 delay:3.0 options:0 animations:^{
        text2.alpha = 1;
    } completion:nil];
    
    UIImageView* initializeLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sg_home_ar_initializing_label"]];
    initializeLabel.center = CGPointMake(768/2-3, self.view.center.y + 123);
    [self.animatedOverlay addSubview:initializeLabel];
    initializeLabel.alpha = 0;
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
        initializeLabel.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:3.5 options:0 animations:^{
            initializeLabel.alpha = 0;
        } completion:nil];
    }];
    
    UIImageView* camera = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sg_home_ar_camera_icon"]];
    camera.center = CGPointMake(768/2-3, self.view.center.y + 183);
    [self.animatedOverlay addSubview:camera];
    camera.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        camera.alpha = 1;
    }];
    
    UIImageView* cameraSpinner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sg_home_ar_load_spinner"]];
    cameraSpinner.center = CGPointMake(768/2-3, self.view.center.y + 183);
    [self.animatedOverlay addSubview:cameraSpinner];
    cameraSpinner.alpha = 0;
    [UIView animateWithDuration:1.5 delay:0 options:0 animations:^{
        cameraSpinner.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:0.5 options:0 animations:^{
            cameraSpinner.alpha = 0;
        } completion:nil];
    }];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear animations:^{
        cameraSpinner.transform = CGAffineTransformMakeRotation(3.14159265);
    } completion:nil];
    
    [self.view addSubview:self.animatedOverlay];
}

-(void)dismissAnimatedOverlay
{
    [UIView animateWithDuration:0.5 animations:^{
        self.animatedOverlay.alpha = 0;
    } completion:^(BOOL finished) {
        [self.animatedOverlay removeFromSuperview];
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(fireHelpPrompt:) userInfo:nil repeats:NO];
}

-(void)fireHelpPrompt:(NSTimer *)timer
{
    UIImageView* helpPrompt = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sg_home_ar_help"]];
    helpPrompt.center = CGPointMake(768/2, 1024/2);
    [self.view addSubview:helpPrompt];
    helpPrompt.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        helpPrompt.alpha = 1;
    }];
}

- (void)dealloc {
    [optionsOverlayView release];
    [super dealloc];
}

- (void) loadView
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    optionsOverlayView = [[OverlayView alloc] initWithFrame: screenBounds];
    self.view = optionsOverlayView;
    
    // We're going to let the parent VC handle all interactions so disable any UI
    // Further on, we'll also implement a touch pass-through
    self.view.userInteractionEnabled = NO;
}


- (void) handleViewRotation:(UIInterfaceOrientation)interfaceOrientation
{
    // adjust the size according to the rotation
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect overlayRect = screenRect;
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        overlayRect.size.width = screenRect.size.height;
        overlayRect.size.height = screenRect.size.width;
    }
    
    optionsOverlayView.frame = overlayRect;
}


// The user touched the screen - pass through
- (void) touchesBegan: (NSSet*) touches withEvent: (UIEvent*) event
{
    // pass events down to parent VC
    [super touchesBegan:touches withEvent:event];
}


- (void) populateActionSheet
{
    // add flash control button if supported by the device
    if (MENU_OPTION_WANTED == flashIx && YES == cameraCapabilities.torch)
    {
        // set button text according to the current mode (toggle)
        BOOL flashMode = [qUtils cameraTorchOn];
        NSString *text = YES == flashMode ? @"Flash off" : @"Flash on";
        flashIx = [mainOptionsAS addButtonWithTitle:text];
    }
    
    // add focus control button if supported by the device
    if (MENU_OPTION_WANTED == autofocusContIx && YES == cameraCapabilities.autofocusContinuous)
    {
        // set button text according to the current mode (toggle)
        BOOL contAFMode = [qUtils cameraContinuousAFOn];
        NSString *text = YES == contAFMode ? @"Auto focus off" : @"Auto focus on";
        autofocusContIx = [mainOptionsAS addButtonWithTitle:text];
    }
    
    // add single-shot focus control button if supported by the device
    if (MENU_OPTION_WANTED == autofocusSingleIx && YES == cameraCapabilities.autofocus)
    {
        autofocusSingleIx = [mainOptionsAS addButtonWithTitle:@"Focus"];
    }
    
    // add 'select target' if there is more than one target
    if (MENU_OPTION_WANTED == selectTargetIx && qUtils.targetsList && [qUtils.targetsList count] > 1)
    {
        NSInteger targetToShow = (selectedTarget + 1) % [qUtils.targetsList count];
        DataSetItem *targetEntry = [qUtils.targetsList objectAtIndex:targetToShow];
        NSString *text = [NSString stringWithFormat:@"Switch to %@", targetEntry.name];
        selectTargetIx = [mainOptionsAS addButtonWithTitle:text];
    }
    
    
    // The cancel button is added in showOverlay rather than here.  This enables
    // a subclass to call [super populateActionSheet either before or after adding
    // its own items
}


// pop-up is invoked by parent VC
- (void) showOverlay
{
    // Get the camera capabilities
    [OverlayViewController determineCameraCapabilities:&cameraCapabilities];
    
    // Show camera control action sheet
    mainOptionsAS = [[[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil] autorelease];
    
    // Specify standard menu options... a subclass can alter these settings
    // in populateActionSheet
    autofocusContIx = MENU_OPTION_WANTED;
    autofocusSingleIx = MENU_OPTION_UNWANTED;
    selectTargetIx = MENU_OPTION_WANTED;
    flashIx = MENU_OPTION_UNWANTED;
    
    // Call myself to populate the menu.  May be overridden.
    [self populateActionSheet];
 
    // Only show the menu if we ended up with something in it
    if ([mainOptionsAS numberOfButtons] > 0)
    {
        // Add a cancel button (this is only shown by iOS in the Phone idiom)
        [mainOptionsAS setCancelButtonIndex:[mainOptionsAS addButtonWithTitle:@"Cancel"]];
        self.view.userInteractionEnabled = YES;
        [mainOptionsAS showInView:self.view];
    }
}


// check to see if any content would be shown in showOverlay
+ (BOOL) doesOverlayHaveContent
{
    int count = 0;
    
    struct tagCameraCapabilities capabilities;
    [OverlayViewController determineCameraCapabilities:&capabilities];
    
    if (YES == capabilities.autofocusContinuous)
        ++count;
    
    if ([QCARutils getInstance].targetsList && [[QCARutils getInstance].targetsList count] > 1)
        ++count;
    
    
    return (count > 0);
}


// UIActionSheetDelegate event handlers

- (void) mainOptionClickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (flashIx == buttonIndex)
    {
        BOOL newFlashMode = ![qUtils cameraTorchOn];
        [qUtils cameraSetTorchMode:newFlashMode];
    }
    else if (selectTargetIx == buttonIndex)
    {
        selectedTarget = (selectedTarget + 1) % [qUtils.targetsList count];        
        DataSetItem *targetEntry = [qUtils.targetsList objectAtIndex:selectedTarget];
        [qUtils activateDataSet:targetEntry.dataSet];
    }
    else if (autofocusContIx == buttonIndex)
    {
        // toggle camera continuous autofocus mode
        BOOL newContAFMode = ![qUtils cameraContinuousAFOn];
        [qUtils cameraSetContinuousAFMode:newContAFMode];
    }
    else if (autofocusSingleIx == buttonIndex)
    {
        [qUtils cameraPerformAF];
    }
        
    self.view.userInteractionEnabled = NO;
 }


- (void) actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //[self mainOptionClickedButtonAtIndex:buttonIndex];
}


+ (void) determineCameraCapabilities:(struct tagCameraCapabilities *) pCapabilities
{
    // Determine whether the cameras support torch and autofocus
    NSArray* cameraArray = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    qUtils.noOfCameras = [cameraArray count];
    AVCaptureDevicePosition cameraPosition = AVCaptureDevicePositionBack;
    
    if (QCAR::CameraDevice::CAMERA_FRONT == qUtils.activeCamera)
    {
        cameraPosition = AVCaptureDevicePositionFront;
    }
    
    for (AVCaptureDevice* camera in cameraArray)
    {
        if (cameraPosition == [camera position])
        {
            pCapabilities->autofocus = [camera isFocusModeSupported:AVCaptureFocusModeAutoFocus];
            pCapabilities->autofocusContinuous = [camera isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus];
            pCapabilities->torch = [camera isTorchModeSupported:AVCaptureTorchModeOn];
        }
    }
}


@end
