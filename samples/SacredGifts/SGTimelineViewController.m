//
//  SGTimelineViewController.m
//  SacredGifts
//
//  Created by Ontario on 12/5/13.
//
//

#import "SGTimelineViewController.h"

NSString* const kTimelinePlistName = @"timeline.plist";

@interface SGTimelineViewController ()
- (void)buildTimelineViews;
@end

@implementation SGTimelineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.scrollView.contentSize = CGSizeMake(5376, self.scrollView.frame.size.height);
    self.scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_assets_bg.png"]];
    
    [self buildTimelineViews];
}

-(void)buildTimelineViews
{
    NSString* fileName = [[NSBundle mainBundle] pathForResource:@"timeline" ofType:@"plist"];
    NSArray* timelineArr = [NSArray arrayWithContentsOfFile:fileName];
    NSLog(@"timelineArr: %@", timelineArr);
}

@end
