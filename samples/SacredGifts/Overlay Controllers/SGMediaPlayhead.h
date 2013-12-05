//
//  SGMediaPlayhead.h
//  SacredGifts
//
//  Created by Ontario on 12/5/13.
//
//

#import <UIKit/UIKit.h>
@protocol SGMediaPlayheadDelegate;

@interface SGMediaPlayhead : UIImageView
@property(nonatomic) int startX;
@property(nonatomic) int endX;
@property(nonatomic,weak) IBOutlet id<SGMediaPlayheadDelegate>delegate;
@end

@protocol SGMediaPlayheadDelegate

- (void)playhead: (SGMediaPlayhead*)playhead seekingStartedAtPoint: (CGPoint)pt;
- (void)playhead: (SGMediaPlayhead*)playhead seekingMovedAtPoint: (CGPoint)pt;
- (void)playhead: (SGMediaPlayhead*)playhead seekingEndedAtPoint: (CGPoint)pt;

@end