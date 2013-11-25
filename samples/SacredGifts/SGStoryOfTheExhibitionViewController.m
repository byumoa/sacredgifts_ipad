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
    
    _scrollContentSize = CGSizeMake(768, 2673);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.scrollView.contentSize = _scrollContentSize;
    self.screenName = @"story of the exhibition";
}

@end
