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
- (UIColor*)createUIColorWithArr: (NSArray*)colorArr;
- (NSMutableArray*)getArrayForTitle: (NSString*)title;
@end

@implementation SGTimelineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.scrollView.contentSize = CGSizeMake(5376, self.scrollView.frame.size.height);
    self.scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_assets_bg.png"]];
    
    [self.scrollView setContentOffset:CGPointMake(2500, 0)];
    [UIView animateWithDuration:2 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
    }];
    
    _blochViews = [NSMutableArray new];
    _schwartzViews = [NSMutableArray new];
    _hofmannViews = [NSMutableArray new];
    _worldViews = [NSMutableArray new];
    _churchViews = [NSMutableArray new];
    [self buildTimelineViews];
    
    CGPoint center = self.datesImageView.center;
    center.y -= 8;
    self.datesImageView.center = center;
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
            SGTimelineEntry* timelineEntry = [[SGTimelineEntry alloc] initWithDictionary:data andColor:bgColor];
            timelineEntry.delegate = self;
            [currentArr addObject:timelineEntry];
            [self.scrollView addSubview:timelineEntry];
            [timelineEntry animateOn];
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

- (IBAction)pressedTimelineToggle:(UIButton *)sender
{
    NSMutableArray* toggleArray = _hofmannViews;
    
    switch (sender.tag) {
        case 2:
            toggleArray = _schwartzViews;
            break;
        case 3:
            toggleArray = _blochViews;
            break;
        case 4:
            toggleArray = _worldViews;
            break;
        case 5:
            toggleArray = _churchViews;
            break;
        default:
            break;
    }
    
    if(((SGTimelineEntry*)toggleArray[0]).frame.size.width > 1 )
        for( int i = 0; i < toggleArray.count; i++ )
            [((SGTimelineEntry*)toggleArray[i]) animateOff];
    else
        for( int i = toggleArray.count-1; i >= 0; i-- )
            [((SGTimelineEntry*)toggleArray[i]) animateOn];
}

-(void)timelineEntry:(SGTimelineEntry *)timelineEntry triggersNavToStr:(NSString *)navStr
{
    if([navStr isEqualToString:@"hofmann"] ||
       [navStr isEqualToString:@"schwartz"] ||
       [navStr isEqualToString:@"bloch"])
        [self.delegate transitionFromController:self toControllerID:navStr fromButtonRect:CGRectZero withAnimType:nil];
    else
        [self.delegate transitionFromController:self toPaintingNamed:navStr fromButtonRect:CGRectZero withAnimType:nil];
}

@end
