//
//  SGConstants.h
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

typedef enum
{
    kModuleTypeNone = 0,
    kModuleTypeTitle = 1,
    kModuleTypeSummary = 2,
    kModuleTypeContext = 3,
    kModuleTypeDetails = 4,
    kModuleTypeCommentary = 5,
    kModuleTypeMusic = 6,
    kModuleTypeChildrens = 7,
    kModuleTypeSocial = 8
}ModuleType;

typedef enum
{
    kOverlayAnimationNone,
    kOverlayAnimationFall
}OverlayAnimation;

extern const NSString* kAnimTypeZoomIn;
extern const NSString* kAnimTypeZoomOut;

extern const NSString* kControllerIDHomeStr;
extern const NSString* kControllerIDFindAPaintingStr;
extern const NSString* kControllerIDMeetTheArtistsStr;
extern const NSString* kControllerIDAboutTheExhibitionStr;
extern const NSString* kControllerIDPaintingContainerStr;
extern const NSString* kControllerIDPaintingStr;

extern const NSString* kPaintingNameBurial;
extern const NSString* kPaintingNameCapture;
extern const NSString* kPaintingNameChildren;
extern const NSString* kPaintingNameCleansing;
extern const NSString* kPaintingNameConsolator;
extern const NSString* kPaintingNameCross;
extern const NSString* kPaintingNameDenial;
extern const NSString* kPaintingNameEmmaus;
extern const NSString* kPaintingNameGarden;
extern const NSString* kPaintingNameGethsemane;
extern const NSString* kPaintingNameHealing;
extern const NSString* kPaintingNameMocking;
extern const NSString* kPaintingNameResurrection;
extern const NSString* kPaintingNameRuler;
extern const NSString* kPaintingNameSavior;
extern const NSString* kPaintingNameSermon;
extern const NSString* kPaintingNameShepherds;
extern const NSString* kPaintingNameTemple;

extern const CGRect kBlurFrame;

extern const NSString* kDontateURLStr;
extern const CGRect kWebviewBackBtnFrm;