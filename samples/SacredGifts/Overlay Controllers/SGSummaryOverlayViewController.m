//
//  SGSummaryOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGSummaryOverlayViewController.h"
#import "SGNarrationManager.h"

@interface SGSummaryOverlayViewController ()

@end

@implementation SGSummaryOverlayViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 670);
        self.moduleType = kModuleTypeSummary;
    }
    
    return self;
}

- (IBAction)pressedNarration:(UIButton *)sender
{
    /*
    NSString *audioPath = [NSString stringWithFormat:@"%@,%@.mp3", [[NSBundle mainBundle] resourcePath], @"narration"];
    
    SGNarrationManager* narrationManager = [SGNarrationManager sharedManager];
    if( ![narrationManager playAudioWithPath:audioPath])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Missing asset" message:@"narration.mp3 has not been added for this overlay" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
     */
}
@end
