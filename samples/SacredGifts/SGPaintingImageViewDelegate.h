//
//  SGPaintingImageViewDelegate.h
//  SacredGifts
//
//  Created by Ontario on 12/17/13.
//
//

#import <Foundation/Foundation.h>
@class SGPaintingImageView;

@protocol SGPaintingImageViewDelegate <NSObject>
- (void)paintingTapped: (SGPaintingImageView*) paintingView;
@end
