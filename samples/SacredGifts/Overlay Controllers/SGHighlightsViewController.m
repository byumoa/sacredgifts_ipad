//
//  SGHighlightsViewController.m
//  SacredGifts
//
//  Created by Ontario on 10/25/13.
//
//

#import "SGHighlightsViewController.h"

@interface SGHighlightsViewController ()

@end

@implementation SGHighlightsViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _centerPos = CGPointMake(384, 670);
        self.moduleType = kModuleTypeHighlights;
    }
    
    return self;
}

-(void)configureWithPath:(NSString *)folderPath
{
    self.rootFolderPath = folderPath;
    for( int i = 1; i <= 10; i++ )
    {
        NSString* buttonConfigDir = [NSString stringWithFormat:@"%@/highlights_%i", folderPath, i];
        
        NSString* buttonConfigPath = [[NSBundle mainBundle] pathForResource:@"ButtonPlacement" ofType:@"plist" inDirectory:buttonConfigDir];
        
        if( buttonConfigPath )
        {
            NSDictionary* buttonDict = [NSDictionary dictionaryWithContentsOfFile:buttonConfigPath];
            NSLog(@"buttonDict: %@", buttonDict);
            /*
            UIButton* button = [self buttonForPerspectiveNumber:i atPath:folderPath];
            CGPoint center = CGPointMake(155 + 230 * ((i-1) % 3), 125 + 170 * ((i-1)/3));
            button.center = center;
            [self.view addSubview:button];
             */
        }
        else
            break;
    }
}

@end
