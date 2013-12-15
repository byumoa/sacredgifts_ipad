//
//  SGSermonShapesOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 12/12/13.
//
//

#import "SGSermonShapesOverlayViewController.h"

@interface SGSermonShapesOverlayViewController ()

@end

@implementation SGSermonShapesOverlayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    for( UIView* shape in self.shapes )
    {
        CGPoint center = shape.center;
        center.x += 20;
        center.y += 15;
        shape.center = center;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressedShape:(UIButton *)sender {
    UIImageView *targetImageView;
    
    switch( sender.tag )
    {
        case 1:
            targetImageView = self.blueCircleLarge;
            break;
        case 2:
            targetImageView = self.greenTriangle;
            break;
        case 3:
            targetImageView = self.purpleTriangle;
            break;
        case 4:
            targetImageView = self.redSquare;
            break;
        case 5:
            targetImageView = self.blueCrossHair;
            break;
    }
    
    float targetAlpha = targetImageView.alpha == 1 ? 0 : 1;
    
    [UIView animateWithDuration:0.25 animations:^{
        targetImageView.alpha = targetAlpha;
    }];
    
    sender.selected = (targetAlpha == 1);
}

- (IBAction)pressedClose:(UIButton *)sender
{
    [self.delegate closeOverlay:self];
}

- (IBAction)pressedCamera:(UIButton *)sender {
}

@end
