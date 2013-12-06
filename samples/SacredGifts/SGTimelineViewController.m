//
//  SGTimelineViewController.m
//  SacredGifts
//
//  Created by Ontario on 12/5/13.
//
//

#import "SGTimelineViewController.h"
#import "SGTimelineEntry.h"

NSString* const kTimelinePlistName = @"timeline.plist";

@interface SGTimelineViewController ()
- (void)buildTimelineViews;
- (UIColor*)createUIColorWithArr: (NSArray*)colorArr;
- (NSMutableArray*)getArrayForTitle: (NSString*)title;
@end

@implementation SGTimelineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.scrollView.contentSize = CGSizeMake(5376, self.scrollView.frame.size.height);
    self.scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_assets_bg.png"]];
    
    _blochViews = [NSMutableArray new];
    _schwartzViews = [NSMutableArray new];
    _hofmannViews = [NSMutableArray new];
    _worldViews = [NSMutableArray new];
    _churchViews = [NSMutableArray new];
    [self buildTimelineViews];
}

-(void)buildTimelineViews
{
    NSString* fileName = [[NSBundle mainBundle] pathForResource:@"timeline" ofType:@"plist"];
    NSArray* timelineArr = [NSArray arrayWithContentsOfFile:fileName];
    
    for( NSDictionary* dict in timelineArr)
    {
        NSMutableArray* currentArr = [self getArrayForTitle:[dict objectForKey:@"title"]];
        UIColor *bgColor = [self createUIColorWithArr:[dict objectForKey:@"backgroundrgb"]];
        NSDictionary* datas = [dict objectForKey:@"data"];
        for (NSDictionary* data in datas)
        {
            SGTimelineEntry* timelineEntry = [[SGTimelineEntry alloc] initWithDictionary:data];
            timelineEntry.backgroundColor = bgColor;
            [currentArr addObject:timelineEntry];
            [self.scrollView addSubview:timelineEntry];
        }
    }
}

-(NSMutableArray *)getArrayForTitle:(NSString *)title
{
    if( [title isEqualToString:@"Schwartz"]) return _schwartzViews;
    else if( [title isEqualToString:@"Hofmann"]) return _hofmannViews;
    else if( [title isEqualToString:@"World"]) return _worldViews;
    else if( [title isEqualToString:@"Church"]) return _churchViews;
    return _blochViews;
}

-(UIColor *)createUIColorWithArr:(NSArray *)colorArr
{
    return [UIColor colorWithRed:((NSNumber*)colorArr[0]).floatValue green:((NSNumber*)colorArr[1]).floatValue blue:((NSNumber*)colorArr[2]).floatValue alpha:0.7];
}

@end
