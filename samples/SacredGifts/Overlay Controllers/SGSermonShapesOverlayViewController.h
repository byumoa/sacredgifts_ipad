//
//  SGSermonShapesOverlayViewController.h
//  SacredGifts
//
//  Created by Ontario on 12/12/13.
//
//

#import "SGOverlayViewController.h"

@interface SGSermonShapesOverlayViewController : SGOverlayViewController
@property (weak, nonatomic) IBOutlet UIImageView *redDot;
@property (weak, nonatomic) IBOutlet UIImageView *blueCrossHair;
@property (weak, nonatomic) IBOutlet UIImageView *greenTriangle;
@property (weak, nonatomic) IBOutlet UIImageView *blueCircleLarge;
@property (weak, nonatomic) IBOutlet UIImageView *redSquare;
@property (weak, nonatomic) IBOutlet UIImageView *purpleTriangle;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *shapes;
- (IBAction)pressedCamera:(UIButton *)sender;
- (IBAction)pressedShape:(UIButton *)sender;
- (IBAction)pressedClose:(UIButton *)sender;

@end
