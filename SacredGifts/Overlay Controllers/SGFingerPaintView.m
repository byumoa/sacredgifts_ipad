//
//  FingerPaintView.m
//  PlayingWithTabs
//
//  Created by Ontario on 9/12/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGFingerPaintView.h"

const CGRect kEllipseBox = {10, 10, 500, 500};

@implementation SGFingerPaintView
@synthesize originalImage = _originalImage;

-(id)init
{
    if( self = [super init])
    {
        self.originalImage = [[UIImage imageNamed:@"childrens.png"] CGImage];
        self.maskThis.opaque = NO;
        self.maskThis.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(CGImageRef)drawImageWithContext:(CGContextRef)context inRect:(CGRect)rect
{
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextSetLineWidth(context, 30);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    //Draw a line
    CGContextMoveToPoint(context, _firstTouchPt.x, _firstTouchPt.y);
    for(NSValue* val in _allTouches)
        CGContextAddLineToPoint(context, [val CGPointValue].x, [val CGPointValue].y);
    
    CGContextStrokePath(context);
    return CGBitmapContextCreateImage(context);
}

- (void)drawRect:(CGRect)rect {
    
    // Retrieve the graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGImageRef maskImage = [self drawImageWithContext:context inRect:rect];
    
    // Get the mask from the image
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskImage)
                                        , CGImageGetHeight(maskImage)
                                        , CGImageGetBitsPerComponent(maskImage)
                                        , CGImageGetBitsPerPixel(maskImage)
                                        , CGImageGetBytesPerRow(maskImage)
                                        ,  CGImageGetDataProvider(maskImage)
                                        , NULL
                                        , false);

    //Flip and Clip
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, rect, mask);
    
    CGImageRef maskedCGImage = CGImageCreateWithMask(self.originalImage, mask);
    self.maskThis.image = [UIImage imageWithCGImage:maskedCGImage];
    CGImageRelease(maskedCGImage);

    CGImageRelease(mask);
    CGImageRelease(maskImage);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _firstTouchPt = [[touches anyObject] locationInView:self];
    _allTouches = [NSMutableArray new];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    NSValue* val = [NSValue valueWithCGPoint:point];
    [_allTouches addObject:val];
    [self setNeedsDisplay];
}

@end
