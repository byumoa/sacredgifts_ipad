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
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"narration" ofType:@".mp3" inDirectory:self.rootFolderPath];
    
    SGNarrationManager* narrationManager = [SGNarrationManager sharedManager];
    if( audioPath )
    {
        [narrationManager playAudioWithPath:audioPath];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Missing asset" message:@"narration.mp3 has not been added for this overlay" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}
@end
