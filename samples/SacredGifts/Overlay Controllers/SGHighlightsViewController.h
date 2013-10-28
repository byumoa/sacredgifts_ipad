//
//  SGHighlightsViewController.h
//  SacredGifts
//
//  Created by Ontario on 10/25/13.
//
//

#import "SGOverlayViewController.h"

@interface SGHighlightsViewController : SGOverlayViewController

-(void)configureWithPath:(NSString *)folderPath;
-(UIButton *)buttonForHighlightIndex:(int)highlightIndex;
-(void)pressedHighlightBtn:(UIButton *)sender;

@end
