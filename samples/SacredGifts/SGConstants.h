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
    kModuleTypeHighlights = 8,
    kModuleTypeVideo = 9,
    kModuleTypePanorama = 10,
    kModuleTypeText = 11,
    kModuleTypeNarration = 12
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
extern const NSString* kControllerIDStoryOfTheExhibitionStr;
extern const NSString* kControllerIDPaintingContainerStr;
extern const NSString* kControllerIDPaintingStr;
extern const NSString* kControllerIDBlochStr;
extern const NSString* kControllerIDSchwartzStr;
extern const NSString* kControllerIDHofmantr;

extern const int kTotalPaintings;
extern const NSString* kPaintingNames[];

extern const CGRect kBlurFrame;

extern const NSString* kDontateURLStr;
extern const CGRect kWebviewBackBtnFrm;

extern const NSString* kPaintingResourcesStr;

extern const NSString* kModuleBtnSummaryImageNrm;
extern const NSString* kModuleBtnSummaryImageSel;
extern const NSString* kModuleBtnHighlightsImageNrm;
extern const NSString* kModuleBtnHighlightsImageSel;
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
extern NSString* const kGiftsStr;
extern const NSString* kMusicStr;
extern const NSString* kChildrensStr;
extern const NSString* kHighlightsStr;
extern const NSString* kTombstoneStr;
extern const NSString* kSocialStr;
extern NSString* const kVideoStr;
extern const NSString* kPanoramaStr;
extern NSString* const kScanStr;
extern NSString* const kTextStr;
extern NSString* const kNarrationStr;