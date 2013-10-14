//
//  SGPaintingImageView.m
//  SacredGifts
//
//  Created by Ontario on 9/24/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGPaintingImageView.h"

const int inset = 20;

@interface SGPaintingImageView()

- (void)tapRecognized: (UITapGestureRecognizer*)recognizer;

@end

@implementation SGPaintingImageView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder])
    {
        UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
        [self addGestureRecognizer:recognizer];
    }
    
    return self;
}

-(void)tapRecognized:(UITapGestureRecognizer *)recognizer
{
    [self.delegate paintingTapped:self];
}

-(void)animateDownWithDelay: (float)delay;
{
    [UIView animateWithDuration:0.25 delay:delay options:0 animations:^{
        CGRect f = self.frame;
        self.frame = CGRectMake(f.origin.x+inset, f.origin.y+inset, f.size.width-inset*2, f.size.height-inset*2);
        self.alpha = 1;
    } completion:nil];
    
    self.isDown = YES;
}

-(void)animateUpWithDelay: (float)delay;
{
    [UIView animateWithDuration:0.25 delay:delay options:0 animations:^{
        CGRect f = self.frame;
        self.frame = CGRectMake(f.origin.x-inset, f.origin.y-inset, f.size.width+inset*2, f.size.height+inset*2);
        self.alpha = 1;
    } completion:nil];
    
    self.isDown = NO;
}

@end