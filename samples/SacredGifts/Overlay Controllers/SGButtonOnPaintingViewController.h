//
//  SGButtonOnPaintingViewController.h
//  SacredGifts
//
//  Created by Ontario on 11/6/13.
//
//

#import "SGMediaSelectionViewController.h"

@interface SGButtonOnPaintingViewController : SGMediaSelectionViewController
{
    NSString* _moduleTypeStr;
    NSMutableArray* _buttons;
}

-(void)configureWithPath:(NSString *)folderPath;
-(UIButton *)buttonForHighlightIndex:(int)highlightIndex;
-(void)pressedHighlightBtn:(UIButton *)sender;

@end
