//
//  SGMediaSelectionViewController.h
//  SacredGifts
//
//  Created by Ontario on 11/6/13.
//
//

#import "SGOverlayViewController.h"

@interface SGMediaSelectionViewController : SGOverlayViewController <SGOverlayViewControllerDelegate>
@property( nonatomic, strong ) SGOverlayViewController *childOverlay;
@property (nonatomic) BOOL extendePlacement;
@property (nonatomic, strong) NSString* paintingName;

- (SGOverlayViewController*)loadPanoramaWithFolderPath: (NSString*)panoFolderPath;
- (SGOverlayViewController*)loadVideoWithFolderPath: (NSString*)videoFolderPath;
- (SGOverlayViewController*)loadAudioWithFolderPath: (NSString*)audioFolderPath;
- (SGOverlayViewController*)loadTextWithFolderPath: (NSString*)textFolderPath;

- (void)prepareForMediaStart;
- (void)prepareForMediaEnd;

- (SGOverlayViewController*)addChildOverlay: (NSString*)moduleStr;
@end