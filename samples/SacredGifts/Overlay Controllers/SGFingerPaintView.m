//
//  FingerPaintView.m
//  PlayingWithTabs
//
//  Created by Ontario on 9/12/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGFingerPaintView.h"

const CGRect kEllipseBox = {10, 10, 500, 500};

@interface SGFingerPaintView()
{
    size_t _imageWidth;
}
@end

@implementation SGFingerPaintView
@synthesize originalImage = _originalImage;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder]){
        _strokesArr = [NSMutableArray new];
        
        _imageWidth = CGImageGetWidth(self.originalImage);
    }
    
    return self;
}


//Use imagewithContentsOfFile or IMageWithData to force SD asset on iPad 3's
-(CGImageRef)drawImageWithContext:(CGContextRef)context inRect:(CGRect)rect
{
    CGContextClearRect(context, rect);
    
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1.0);
    CGContextSetLineWidth(context, 30);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    //Draw a line
    for( NSDictionary* dict in _strokesArr )
    {
        CGPoint firstPoint = ((NSValue*)[dict objectForKey:@"first point"]).CGPointValue;
        CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
        
        NSArray* strokeTouches = (NSArray*)[dict objectForKey:@"stroke points"];
        for(NSValue* val in strokeTouches)
            CGContextAddLineToPoint(context, [val CGPointValue].x, [val CGPointValue].y);
    }
    
    CGContextStrokePath(context);
    return CGBitmapContextCreateImage(context);
}

- (void)drawRect:(CGRect)rect {
    
    if( _strokesArr.count == 0 ) return;
    // Retrieve the graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGImageRef maskImage = [self drawImageWithContext:context inRect:rect];
    
    // Get the mask from the image
    CGImageRef mask = CGImageMaskCreate(  CGImageGetWidth(maskImage)
                                        , CGImageGetHeight(maskImage)
                                        , CGImageGetBitsPerComponent(maskImage)
                                        , CGImageGetBitsPerPixel(maskImage)
                                        , CGImageGetBytesPerRow(maskImage)
                                        , CGImageGetDataProvider(maskImage)
                                        , NULL
                                        , false);
    
    //Flip and Clip
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, rect, mask);
    
    CGImageRef maskedCGImage = CGImageCreateWithMask(self.originalImage, mask);
    CGContextDrawImage(context, rect, maskedCGImage);
    CGImageRelease(maskedCGImage);
    CGImageRelease(mask);
    CGImageRelease(maskImage);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _firstTouchPt = [[touches anyObject] locationInView:self];
    _strokeTouches = [NSMutableArray new];
    
    NSArray* objectsArr = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:_firstTouchPt], _strokeTouches, nil];
    NSArray* keysArr = [NSArray arrayWithObjects:@"first point", @"stroke points", nil];
    
    NSDictionary* strokeInfo = [NSDictionary dictionaryWithObjects:objectsArr forKeys:keysArr];
    [_strokesArr addObject:strokeInfo];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    NSValue* val = [NSValue valueWithCGPoint:point];
    [_strokeTouches addObject:val];
    [self setNeedsDisplay];
}

@end

