//
//  SGTimelineViewController.m
//  SacredGifts
//
//  Created by Ontario on 12/5/13.
//
//

#import "SGTimelineViewController.h"

@interface SGTimelineViewController ()

@end

@implementation SGTimelineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.scrollView.contentSize = CGSizeMake(5376, self.scrollView.frame.size.height);
    self.scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_assets_bg.png"]];
}

@end
