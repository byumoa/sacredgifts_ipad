//
//  SGTimelineEntry.m
//  SacredGifts
//
//  Created by Ontario on 12/5/13.
//
//

#import "SGTimelineEntry.h"

@interface SGTimelineEntry()
- (void)pressedEntry: (UIButton*)sender;
- (void)removePopup: (UIButton*)sender;
@end

@implementation SGTimelineEntry

-(SGTimelineEntry *)initWithDictionary:(NSDictionary *)dict andColor:(UIColor *)bgColor
{
    if( self = [super initWithFrame:CGRectMake(0, 0, ((NSNumber*)[dict objectForKey:@"width"]).floatValue, 40)] )
    {
        self.center = CGPointMake(((NSNumber*)[dict objectForKey:@"x"]).floatValue, ((NSNumber*)[dict objectForKey:@"y"]).floatValue);
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        _fullFrame = self.frame;
        
        UIView* backing = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 36)];
        backing.backgroundColor = bgColor;
        [self addSubview:backing];
        
        UIView* leftHandle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
        float r; float g; float b; float a;
        [bgColor getRed:&r green:&g blue:&b alpha:&a];
        leftHandle.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
        [self addSubview:leftHandle];
        
        CGRect frame = self.frame;
        frame.origin = CGPointZero;
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.text = [dict objectForKey:@"text"];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        CGPoint center = label.center;
        center.x += 12;
        label.center = center;
        [self addSubview:label];
        
        frame = self.frame;
        frame.size.width = 1;
        self.frame = frame;
        
        NSString* thumbnail = [dict objectForKey:@"thumbnail"];
        if( thumbnail )
        {
            UIImageView *thumbnailImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:thumbnail]];
            center = thumbnailImgView.center;
            center.x+=1;
            thumbnailImgView.center = center;
            [self addSubview:thumbnailImgView];
            
            center = label.center;
            center.x += thumbnailImgView.frame.size.width + 12;
            label.center = center;
        }
        
        NSString* buttonImgStr = [dict objectForKey:@"buttonImage"];
        if( buttonImgStr )
        {
            UIImageView *buttonImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:buttonImgStr]];
            center = buttonImgView.center;
            center.x = self.frame.size.width - buttonImgView.frame.size.width/2;
            buttonImgView.center = center;
        }
        
        _popupName = [dict objectForKey:@"popup"];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, ((NSNumber*)[dict objectForKey:@"width"]).floatValue, 40);
        [button addTarget:self action:@selector(pressedEntry:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    return self;
}

-(void)pressedEntry:(UIButton *)sender
{
    NSLog(@"pressedEntry _popupName: %@", _popupName);
    
    if( _popupName )
    {
        _popup = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_popupName]];
        _popup.center = self.superview.superview.center;
        [self.superview.superview addSubview:_popup];
        
        UIButton* popupDismiss = [UIButton buttonWithType:UIButtonTypeCustom];
        [popupDismiss addTarget:self action:@selector(removePopup:) forControlEvents:UIControlEventTouchUpInside];
        popupDismiss.frame = self.superview.superview.frame;
        [self.superview.superview addSubview:popupDismiss];
    }
}

-(void)removePopup:(UIButton *)sender
{
    [UIView animateWithDuration:0.25 animations:^{
        _popup.alpha = 0;
    } completion:^(BOOL finished) {
        [_popup removeFromSuperview];
        [sender removeFromSuperview];
    }];
}

-(void)animateOn
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = _fullFrame;
    }];
}

-(void)animateOff
{
    CGRect frame = _fullFrame;
    frame.size.width = 1;
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = frame;
    }];
}

@end

@implementation SGTimelinePopup

@end
