//
//  SGMediaPlayhead.m
//  SacredGifts
//
//  Created by Ontario on 12/5/13.
//
//

#import "SGMediaPlayhead.h"

NSString* const kPlayheadOffImgStr = @"SG_General_Media_Playhead";
NSString* const kPlayheadOnImgStr = @"SG_General_Media_Playhead-on";

@implementation SGMediaPlayhead

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.image = [UIImage imageNamed:kPlayheadOnImgStr];
    self.startX = 258;
    self.endX = 258+477;
    [self.delegate playhead:self seekingStartedAtPoint:self.center];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLoc = [[touches anyObject] locationInView:self.superview];
    CGPoint lastTouchLoc = [[touches anyObject] previousLocationInView:self.superview];
    
    CGPoint center = self.center;
    center.x += touchLoc.x-lastTouchLoc.x;
    if( center.x < self.startX ) center.x = self.startX;
    if( center.x > self.endX ) center.x = self.endX;
    self.center = center;
    [self.delegate playhead:self seekingMovedAtPoint:self.center];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.image = [UIImage imageNamed:kPlayheadOffImgStr];
    [self.delegate playhead:self seekingEndedAtPoint:self.center];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.image = [UIImage imageNamed:kPlayheadOffImgStr];
    [self.delegate playhead:self seekingEndedAtPoint:self.center];
}

@end
