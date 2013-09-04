//
//  SGPhasedBackgroundView.m
//  SacredGifts
//
//  Created by Ontario on 8/28/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import "SGPhasedBackgroundView.h"

@implementation SGPhasedBackgroundView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"SG_General_BG_Pattern"]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetPatternPhase(context, self.offset);
    
    CGColorRef color = self.backgroundColor.CGColor;
    CGContextSetFillColorWithColor(context, color);
    CGContextFillRect(context, self.bounds);
    
    CGContextRestoreGState(context);
}

@end
