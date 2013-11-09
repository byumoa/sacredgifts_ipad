//
//  SGMediaSelectionViewController.h
//  SacredGifts
//
//  Created by Ontario on 11/6/13.
//
//

#import "SGOverlayViewController.h"

@interface SGMediaSelectionViewController : SGOverlayViewController
//@property( nonatomic, strong )
- (void)loadPanoramaWithFolderPath: (NSString*)panoFolderPath;
- (void)loadVideoWithFolderPath: (NSString*)videoFolderPath;
- (void)loadAudioWithFolderPath: (NSString*)audioFolderPath;
- (void)loadTextWithFolderPath: (NSString*)textFolderPath;
@end