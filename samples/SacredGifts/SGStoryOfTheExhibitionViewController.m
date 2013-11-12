//
//  SGStoryOfTheExhibitionViewController.m
//  SacredGifts
//
//  Created by Ontario on 11/9/13.
//
//

#import "SGStoryOfTheExhibitionViewController.h"

@implementation SGStoryOfTheExhibitionViewController

-(void)loadView
{
    [super loadView];
    
    _scrollContentSize = CGSizeMake(768, 2250);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.scrollView.contentSize = _scrollContentSize;
}

@end
