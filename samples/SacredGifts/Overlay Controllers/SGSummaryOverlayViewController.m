//
//  SGSummaryOverlayViewController.m
//  SacredGifts
//
//  Created by Ontario on 9/28/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGSummaryOverlayViewController.h"
#import "SGNarrationManager.h"
#import "SGConvenienceFunctionsManager.h"

const NSString* kSummarySpeakerBtnNrmStr = @"speaker_btns__narration_btn.png";
const NSString* kSummarySpeakerBtnHilStr = @"speaker_btns__narration_btn-on.png";
const NSString* kSummaryPlayBtnNrlStr = @"summary_play_btn.png";
const NSString* kSummaryPlayBtnHilStr = @"summary_play_btn.png";
const NSString* kSummaryPauseBtnNrmStr = @"summary_pause_btn.png";
const NSString* kSummaryPauseBtnHilStr = @"summary_pause_btn.png";

@interface SGSummaryOverlayViewController ()
{
    BOOL _narrationIsActive;
}

- (void)setupSpeakerBtnPlay;
- (void)setupSpeakerBtnPause;
- (void)setupSpeakerBtnInctive;

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

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //BOOL isBlochPainting = [SGConvenienceFunctionsManager artistForPainting: abbreviated:<#(BOOL)#>]
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

- (IBAction)pressedCastle:(id)sender
{
    // [self.delegate transitionFromController:self toPaintingNamed:@"castle" fromButtonRect:((UIButton*)sender).frame withAnimType:kAnimTypeZoomIn];
}

-(void)setupSpeakerBtnPlay
{
    
}

-(void)setupSpeakerBtnPause
{
    
}

-(void)setupSpeakerBtnInctive
{
    
}

@end
