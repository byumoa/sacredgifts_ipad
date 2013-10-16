//
//  SGPerspectiveMatchViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/16/13.
//
//

#import "SGPerspectiveMatchViewController.h"

@interface SGPerspectiveMatchViewController ()

@end

@implementation SGPerspectiveMatchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
}

-(void)arMatrixReporter:(EAGLView *)eaglView matrixUpdated:(int)matrix
{
    NSLog(@"matrix: %i", matrix);
}

@end
