//
//  SGSecondaryOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/24/13.
//
//

#import "SGSecondaryOverlayViewController.h"

const int closeBtnPadding = 6;

@interface SGSecondaryOverlayViewController ()
- (void)pressedClose: (UIButton*)sender;
- (void)addCloseBtn;
@end

@implementation SGSecondaryOverlayViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addCloseBtn];
}

-(void)addCloseBtn
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* closeBtnImg = [UIImage imageNamed:@"SG_General_Module_CloseBtn.png"];
    UIImage* closeBtnOnImg = [UIImage imageNamed:@"SG_General_Module_CloseBtn-on.png"];
    
    [button setImage:closeBtnImg forState:UIControlStateNormal];
    [button setImage:closeBtnOnImg forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(pressedClose:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect frame = CGRectZero;
    frame.size = closeBtnImg.size;
    frame.origin.x = self.view.frame.size.width - closeBtnPadding - frame.size.width;
    frame.origin.y = closeBtnPadding;
    button.frame = frame;
    
    [self.view addSubview:button];
}

-(void)pressedClose:(UIButton *)sender
{
    NSLog(@"pressedClose");
}

@end
