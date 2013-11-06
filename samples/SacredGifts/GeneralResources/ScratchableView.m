//
//  ScratchableView.m
//  CGScratch
//
//  Created by Olivier Yiptong on 11-01-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScratchableView.h"


@implementation ScratchableView

- (void)configWithGreyscaleOverlay: (NSString*)path
{
    scratchable = CGImageCreateCopy([UIImage imageWithContentsOfFile:path].CGImage);
    width = CGImageGetWidth(scratchable);
    height = CGImageGetHeight(scratchable);
    
    CGPoint center = self.center;
    CGRect frame = self.frame;
    frame.size.width = width;
    frame.size.height = height;
    self.frame = frame;
    self.center = center;
    
    self.opaque = NO;
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceGray();
		
    CFMutableDataRef pixels = CFDataCreateMutable( NULL , width * height );
    alphaPixels = CGBitmapContextCreate( CFDataGetMutableBytePtr( pixels ), width, height, 8, width, colorspace, kCGImageAlphaNone );
    provider = CGDataProviderCreateWithCFData(pixels);
		
    CGContextSetFillColorWithColor(alphaPixels, [UIColor blackColor].CGColor);
    CGContextFillRect(alphaPixels, self.frame);
		
    CGContextSetStrokeColorWithColor(alphaPixels, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(alphaPixels, 70.0);
    CGContextSetLineCap(alphaPixels, kCGLineCapRound);
    CGContextSetLineJoin(alphaPixels, kCGLineJoinRound);
		
    CGImageRef mask = CGImageMaskCreate(width, height, 8, 8, width, provider, nil, NO);
    scratched = CGImageCreateWithMask(scratchable, mask);
		
    CGImageRelease(mask);
    CGColorSpaceRelease(colorspace);
}

- (void)drawRect:(CGRect)rect {
    CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, scratched);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event touchesForView:self] anyObject];
	firstTouch = YES;
	location = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[event touchesForView:self] anyObject];
	
	if (firstTouch) {
		firstTouch = NO;
		previousLocation = [touch previousLocationInView:self];
	} else {
		location = [touch locationInView:self];
		previousLocation = [touch previousLocationInView:self];
	}
	
	// Render the stroke
	[self renderLineFromPoint:previousLocation toPoint:location];
    
    [self.nextResponder touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event touchesForView:self] anyObject];
	if (firstTouch) {
		firstTouch = NO;
		previousLocation = [touch previousLocationInView:self];
		
		[self renderLineFromPoint:previousLocation toPoint:location];
	}
}

- (void) renderLineFromPoint:(CGPoint)start toPoint:(CGPoint)end
{
	CGContextMoveToPoint(alphaPixels, start.x, start.y);
	CGContextAddLineToPoint(alphaPixels, end.x, end.y);
	CGContextStrokePath(alphaPixels);
    [self setNeedsDisplay];
}

- (void)dealloc {
	CGContextRelease(alphaPixels);
	CGImageRelease(scratchable);
	CGDataProviderRelease(provider);
    [super dealloc];
}


@end
