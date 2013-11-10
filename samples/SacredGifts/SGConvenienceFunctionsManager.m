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

+ (NSString*)artistForPainting: (NSString*)paintingStr abbreviated:(BOOL)abbreviate
{
    NSArray* schwartzPaintings = @[@"garden", @"aalborg"];
    NSArray* hofmannPaintings = @[@"capture", @"temple", @"ruler", @"gethsemane", @"savior"];
    
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

@end
