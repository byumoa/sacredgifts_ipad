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
    NSString* _buttonNrmImgStr;
    NSString* _buttonHilImgStr;
}

-(void)configureWithPath:(NSString *)folderPath;
-(UIButton *)buttonForHighlightIndex:(int)highlightIndex;
-(SGOverlayViewController*)pressedHighlightBtn:(UIButton *)sender;

@end
