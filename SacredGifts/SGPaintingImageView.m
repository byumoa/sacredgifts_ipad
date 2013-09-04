//
//  SGPaintingImageView.m
//  SacredGifts
//
//  Created by Ontario on 8/28/13.
//  Copyright (c) 2013 PepperGum Games. All rights reserved.
//

#import "SGPaintingImageView.h"

const int inset = 20;

@implementation SGPaintingImageView

-(void)animateDown
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect f = self.frame;
        self.frame = CGRectMake(f.origin.x+inset, f.origin.y+inset, f.size.width-inset*2, f.size.height-inset*2);
        self.alpha = 1;
    }];
    
    self.isDown = YES;
}

-(void)animateUp
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect f = self.frame;
        self.frame = CGRectMake(f.origin.x-inset, f.origin.y-inset, f.size.width+inset*2, f.size.height+inset*2);
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
    self.isDown = NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate paintingTapped:self];
}

@end
