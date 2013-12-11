//
//  SGConvenienceFunctionsManager.m
//  SacredGifts
//
//  Created by Ontario on 11/9/13.
//
//

#import "SGConvenienceFunctionsManager.h"

@implementation SGConvenienceFunctionsManager

+(id)sharedManager
{
    static SGConvenienceFunctionsManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [self new];
    });
    
    return  sharedManager;
}

+(void)facebookLogout
{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}

+ (NSString*)artistForPainting: (NSString*)paintingStr abbreviated:(BOOL)abbreviate
{
    NSArray* schwartzPaintings = @[@"garden", @"aalborg"];
    NSArray* hofmannPaintings = @[@"capture", @"temple", @"temple-ny", @"ruler", @"gethsemane", @"savior"];
    
    for (NSString* pName in schwartzPaintings ) {
        if( [pName isEqualToString:paintingStr])
            return abbreviate ? @"schwartz" : @"Frans Schwartz";
    }
    for (NSString* pName in hofmannPaintings ) {
        if( [pName isEqualToString:paintingStr])
            return abbreviate ? @"hofmann" : @"Heinrich Hofmann";
    }
    
    return abbreviate ? @"bloch" : @"Carl Bloch";
}

+ (NSString *)getStringForModule:(ModuleType)moduleType
{
    switch (moduleType) {
        case kModuleTypeChildrens:      return (NSString*)kChildrensStr;    break;
        case kModuleTypeHighlights:     return (NSString*)kHighlightsStr;   break;
        case kModuleTypeGifts:          return (NSString*)kGiftsStr;        break;
        case kModuleTypeMusic:          return (NSString*)kMusicStr;        break;
        case kModuleTypePerspective:    return (NSString*)kPerspectiveStr;  break;
        case kModuleTypeSocial:         return (NSString*)kSocialStr;       break;
        case kModuleTypeSummary:        return (NSString*)kSummaryStr;      break;
        case kModuleTypeTombstone:      return (NSString*)kTombstoneStr;    break;
        case kModuleTypeText:           return (NSString*)kTextStr;         break;
        case kModuleTypeNarration:      return (NSString*)kNarrationStr;    break;
        case kModuleTypeNone:           default:                            break;
    }
    
    return nil;
}

+ (NSString *)getFBURLStrForModule:(NSString*)paintingStr
{
    if( [paintingStr isEqualToString:(NSString*)kPaintingNames[0]] ) return (NSString*)kfacebookURLcapture;
    else if( [paintingStr isEqualToString:@"temple-ny"] ) return (NSString*)kfacebookURLtemple;
    else if( [paintingStr isEqualToString:@"temple"]) return (NSString*)kfacebookURLtempleGermany;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[2]] ) return (NSString*)kfacebookURLruler;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[3]] ) return (NSString*)kfacebookURLgethsemane;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[4]] ) return (NSString*)kfacebookURLsavior;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[5]] ) return (NSString*)kfacebookURLgarden;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[6]] ) return (NSString*)kfacebookURLaalborg;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[7]] ) return (NSString*)kfacebookURLmocking;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[8]] ) return (NSString*)kfacebookURLconsolator;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[9]] ) return (NSString*)kfacebookURLemmaus;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[10]] ) return (NSString*)kfacebookURLshepherds;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[11]] ) return (NSString*)kfacebookURLsermon;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[12]] ) return (NSString*)kfacebookURLchildren;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[13]] ) return (NSString*)kfacebookURLhealing;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[14]] ) return (NSString*)kfacebookURLcleansing;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[15]] ) return (NSString*)kfacebookURLdenial;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[16]] ) return (NSString*)kfacebookURLcross;
    else if( [paintingStr isEqualToString:(NSString*)kPaintingNames[17]] ) return (NSString*)kfacebookURLburial;
    
    return (NSString*)kfacebookURLresurrection;
}

@end
