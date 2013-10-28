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
    sender.selected = !sender.selected;
    
    SGNarrationManager* narrationManager = [SGNarrationManager sharedManager];
    if( audioPath )
    {
        if( sender.selected )
            [narrationManager playAudioWithPath:audioPath];
        else
            [narrationManager pauseAudio];
    }
}
@end
