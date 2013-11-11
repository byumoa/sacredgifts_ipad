//
//  SGButtonOnPaintingViewController.m
//  SacredGifts
//
//  Created by Ontario on 11/6/13.
//
//

#import "SGButtonOnPaintingViewController.h"

@implementation SGButtonOnPaintingViewController

-(void)configureWithPath:(NSString *)folderPath
{
    self.rootFolderPath = folderPath;
    _buttons = [NSMutableArray new];
    
    for( int i = 1; i <= 10; i++ )
    {
        NSString* buttonConfigDir = [NSString stringWithFormat:@"%@/%@_%i", folderPath, _moduleTypeStr, i];
        NSString* buttonConfigPath = [[NSBundle mainBundle] pathForResource:@"ButtonPlacement" ofType:@"plist" inDirectory:buttonConfigDir];
        
        if( buttonConfigPath )
        {
            NSDictionary* buttonDict = [NSDictionary dictionaryWithContentsOfFile:buttonConfigPath];
            UIButton* button = [self buttonForHighlightIndex:i];
            CGPoint center = CGPointMake([[buttonDict objectForKey:@"xPos"] intValue], [[buttonDict objectForKey:@"yPos"] intValue]);
            button.center = center;
            
            [self.view addSubview:button];
            [_buttons addObject:button];
        }
        else
            break;
    }
}

-(UIButton *)buttonForHighlightIndex:(int)highlightIndex
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* normalBtnImg = [UIImage imageNamed:@"sg_general_painting_detailmarkerbtn.png"];
    UIImage* highlightBtnImg = [UIImage imageNamed:@"sg_general_painting_detailmarkerbtn-on.png"];
    [button setImage:normalBtnImg forState:UIControlStateNormal];
    [button setImage:highlightBtnImg forState:UIControlStateHighlighted];
    
    button.frame = CGRectMake(0, 0, normalBtnImg.size.width, normalBtnImg.size.height);
    button.tag = highlightIndex;
    [button addTarget:self action:@selector(pressedHighlightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

-(void)pressedHighlightBtn:(UIButton *)sender
{
    NSString* btnFolderPath = [NSString stringWithFormat:@"%@/%@_%i", self.rootFolderPath, _moduleTypeStr, sender.tag];
    NSString* panoPath = [[NSBundle mainBundle] pathForResource:@"pano_b" ofType:@"jpg" inDirectory:btnFolderPath];
    NSString* videoPath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4" inDirectory:btnFolderPath];
    NSString* audioPath = [[NSBundle mainBundle] pathForResource:@"audio" ofType:@"mp3" inDirectory:btnFolderPath];
    
    if( panoPath )
        [self loadPanoramaWithFolderPath:btnFolderPath];
    else if( videoPath )
        [self loadVideoWithFolderPath:btnFolderPath];
    else if( audioPath )
        [self loadAudioWithFolderPath:btnFolderPath];
    else
        [self loadTextWithFolderPath:btnFolderPath];
}

@end
