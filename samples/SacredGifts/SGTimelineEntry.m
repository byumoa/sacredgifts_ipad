//
//  SGTimelineEntry.m
//  SacredGifts
//
//  Created by Ontario on 12/5/13.
//
//

#import "SGTimelineEntry.h"

@implementation SGTimelineEntry

-(SGTimelineEntry *)initWithDictionary:(NSDictionary *)dict
{
    if( self = [super initWithFrame:CGRectMake(0, 0, ((NSNumber*)[dict objectForKey:@"width"]).floatValue, 36)] )
    {
        self.center = CGPointMake(((NSNumber*)[dict objectForKey:@"x"]).floatValue, ((NSNumber*)[dict objectForKey:@"y"]).floatValue);
        UIView* leftHandle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
        float r; float g; float b; float a;
        [self.backgroundColor getRed:&r green:&g blue:&b alpha:&a];
        leftHandle.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
        [self addSubview:leftHandle];
    }
    
    return self;
}

@end
