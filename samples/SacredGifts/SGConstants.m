//
//  SGConstants.m
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

const NSString* kAnimTypeZoomIn = @"kSG ZoomIn Anim";
const NSString* kAnimTypeZoomOut = @"kSG ZoomOut Anim";
const NSString* kAnimTypeSwipeRight = @"kSG SwipeRight Anim";
const NSString* kAnimTypeSwipeLeft = @"kSG SwipeLeft Anim";

const NSString* kControllerIDHomeStr = @"SacredGifts Home";
const NSString* kControllerIDFindAPaintingStr = @"SacredGifts FindAPainting";
const NSString* kControllerIDMeetTheArtistsStr = @"SacredGifts MeetTheArtists";
const NSString* kControllerIDAboutTheExhibitionStr = @"SacredGifts AboutTheExhibition";
const NSString* kControllerIDStoryOfTheExhibitionStr = @"SacredGifts StoryOfTheExhibition";
const NSString* kControllerIDPaintingContainerStr = @"SacredGifts PaintingContainer";
const NSString* kControllerIDPaintingStr = @"SacredGifts Painting";
const NSString* kControllerIDBlochStr = @"bloch";
const NSString* kControllerIDSchwartzStr = @"schwartz";
const NSString* kControllerIDHofmantr = @"hofman";
const NSString* kControllerIDPanoramaStr = @"panorama";

const NSString* kfacebookURLcapture = @"https://www.facebook.com/photo.php?fbid=577324175674036&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLtemple = @"https://www.facebook.com/photo.php?fbid=577324482340672&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLruler = @"https://www.facebook.com/photo.php?fbid=577324422340678&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLgethsemane = @"https://www.facebook.com/photo.php?fbid=577324332340687&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLsavior = @"https://www.facebook.com/photo.php?fbid=577324425674011&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLgarden = @"https://www.facebook.com/photo.php?fbid=577324322340688&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLaalborg = @"https://www.facebook.com/photo.php?fbid=577324159007371&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLmocking = @"https://www.facebook.com/photo.php?fbid=577324365674017&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLconsolator = @"https://www.facebook.com/photo.php?fbid=577324295674024&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLemmaus = @"https://www.facebook.com/photo.php?fbid=577324289007358&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLshepherds = @"https://www.facebook.com/photo.php?fbid=577324489007338&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLsermon = @"https://www.facebook.com/photo.php?fbid=577324339007353&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLchildren = @"https://www.facebook.com/photo.php?fbid=577324185674035&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLhealing = @"https://www.facebook.com/photo.php?fbid=577324362340684&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLcleansing = @"https://www.facebook.com/photo.php?fbid=577324205674033&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLdenial = @"https://www.facebook.com/photo.php?fbid=577324259007361&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLcross = @"https://www.facebook.com/photo.php?fbid=577324232340697&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLburial = @"https://www.facebook.com/photo.php?fbid=577324169007370&set=a.577324135674040.1073741825.126723597400765&type=3&theater";
const NSString* kfacebookURLresurrection = @"https://www.facebook.com/photo.php?fbid=577324385674015&set=a.577324135674040.1073741825.126723597400765&type=3&theater";

const int kTotalPaintings = 19;
NSString* const kPaintingNames[] = {
    @"capture",
    @"temple",
    @"ruler",
    @"gethsemane",
    @"savior",
    @"garden",
    @"aalborg",
    @"mocking",
    @"consolator",
    @"emmaus",
    @"shepherds",
    @"sermon",
    @"children",
    @"healing",
    @"cleansing",
    @"denial",
    @"cross",
    @"burial",
    @"resurrection"
};

NSString* const kArtistNames[] = {
    @"hofman",
    @"schwartz",
    @"bloch"
};

const NSString* kDontateURLStr = @"https://donate.byu.edu/TNHO3ajmoEyyUA7Sb5uKkg/P/LlGZnojZCEC0r8dLhBjk2w?cat=0&ReturnUrl=sacredgifts%3A%2F%2F%3Fsender%3Dldsp";
const CGRect kWebviewBackBtnFrm = {10, 10, 100, 60 };
const CGRect kBlurFrame = {-18, -18, 804, 1060};

const NSString* kPaintingResourcesStr = @"PaintingResources";

const NSString* kModuleBtnSummaryImageNrm = @"SG_General_Painting_SummaryBtn";
const NSString* kModuleBtnSummaryImageSel = @"SG_General_Painting_SummaryBtn-on";
const NSString* kModuleBtnMusicImageNrm = @"SG_General_Painting_MusicBtn";
const NSString* kModuleBtnMusicImageSel = @"SG_General_Painting_MusicBtn-on";
const NSString* kModuleBtnChildrensImageNrm = @"SG_General_Painting_ChildrensBtn";
const NSString* kModuleBtnChildrensImageSel = @"SG_General_Painting_ChildrensBtn-on";
const NSString* kModuleBtnPerspectiveImageNrm = @"SG_General_Painting_PerspectivesBtn";
const NSString* kModuleBtnPerspectiveImageSel = @"SG_General_Painting_PerspectivesBtn-on";
const NSString* kModuleBtnGiftsImageNrm = @"SG_General_Painting_GiftsBtn";
const NSString* kModuleBtnGiftsImageSel = @"SG_General_Painting_GiftsBtn-on";
const NSString* kModuleBtnHighlightsImageNrm = @"SG_General_Painting_DetailsBtn";
const NSString* kModuleBtnHighlightsImageSel = @"SG_General_Painting_DetailsBtn-on";

const NSString* kSummaryStr = @"summary";
NSString* const kPerspectiveStr = @"perspectives";
NSString* const kGiftsStr = @"gift";
const NSString* kMusicStr = @"music";
NSString* const kHighlightsStr = @"highlights";
const NSString* kChildrensStr = @"childrens";
const NSString* kTombstoneStr = @"tombstone";
const NSString* kSocialStr = @"social";
NSString* const kVideoStr = @"video";
const NSString* kPanoramaStr = @"panorama";
const NSString* kScanStr = @"scan";
const NSString* kTextStr = @"text";
const NSString* kNarrationStr = @"narration";