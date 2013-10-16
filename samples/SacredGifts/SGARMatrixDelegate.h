//
//  SGPerspectiveMatchDelegate.h
//  SacredGifts
//
//  Created by Ontario on 10/16/13.
//
//

#import <Foundation/Foundation.h>
@class EAGLView;

@protocol SGARMatrixDelegate <NSObject>
- (void)arMatrixReporter:(EAGLView*)eaglView matrixUpdated:(int)matrix;
@end
