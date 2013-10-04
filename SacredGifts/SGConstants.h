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
    kModuleTypeTombstone = 1,
    kModuleTypeSummary = 2,
    kModuleTypePerspective = 3,
    kModuleTypeMusic = 4,
    kModuleTypeChildrens = 5,
    kModuleTypeSocial = 6,
    kModuleTypeGifts = 7,
    kModuleTypeDetails = 8
}ModuleType;

typedef enum
{
    kOverlayAnimationNone,
    kOverlayAnimationFall
}OverlayAnimation;

extern const NSString* kAnimTypeZoomIn;
extern const NSString* kAnimTypeZoomOut;
extern const NSString* kAnimTypeSwipeRight;
extern const NSString* kAnimTypeSwipeLeft;

extern const NSString* kControllerIDHomeStr;
extern const NSString* kControllerIDFindAPaintingStr;
extern const NSString* kControllerIDMeetTheArtistsStr;
extern const NSString* kControllerIDAboutTheExhibitionStr;
extern const NSString* kControllerIDPaintingContainerStr;
extern const NSString* kControllerIDPaintingStr;

extern const NSString* kPaintingNames[];
/*
extern const NSString* kPaintingNameAalborg;
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
*/
extern const CGRect kBlurFrame;

extern const NSString* kDontateURLStr;
extern const CGRect kWebviewBackBtnFrm;

extern const NSString* kPaintingResourcesStr;

extern const NSString* kModuleBtnSummaryImageNrm;
extern const NSString* kModuleBtnSummaryImageSel;
extern const NSString* kModuleBtnDetailsImageNrm;
extern const NSString* kModuleBtnDetailsImageSel;
extern const NSString* kModuleBtnMusicImageNrm;
extern const NSString* kModuleBtnMusicImageSel;
extern const NSString* kModuleBtnChildrensImageNrm;
extern const NSString* kModuleBtnChildrensImageSel;
extern const NSString* kModuleBtnPerspectiveImageNrm;
extern const NSString* kModuleBtnPerspectiveImageSel;
extern const NSString* kModuleBtnGiftsImageNrm;
extern const NSString* kModuleBtnGiftsImageSel;

extern const NSString* kSummaryStr;
extern const NSString* kPerspectiveStr;
extern const NSString* kGiftsStr;
extern const NSString* kMusicStr;
extern const NSString* kChildrensStr;
extern const NSString* kDetailsStr;
extern const NSString* kTombstoneStr;
extern const NSString* kSocialStr;