//
//  SGQCARDelegate.h
//  SacredGifts
//
//  Created by Ontario on 11/19/13.
//
//

#import <Foundation/Foundation.h>

@protocol SGQCARDelegate <NSObject>
- (void)scannedPainting:(NSString*)paintingName;
@end
