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
- (void)navigateToNavStr:(UIButton *)sender;
@end

@implementation SGTimelineEntry

-(SGTimelineEntry *)initWithDictionary:(NSDictionary *)dict andColor:(UIColor *)bgColor
{
    if( self = [super initWithFrame:CGRectMake(0, 0, ((NSNumber*)[dict objectForKey:@"width"]).floatValue, 40)] )
    {
        CGPoint origin = CGPointMake(((NSNumber*)[dict objectForKey:@"x"]).floatValue, ((NSNumber*)[dict objectForKey:@"y"]).floatValue);
        
        CGRect frame = self.frame;
        frame.origin = origin;
        self.frame = frame;
        
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
        
        frame = self.frame;
        frame.origin = CGPointZero;
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.text = [dict objectForKey:@"text"];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        CGPoint center = label.center;
        center.x += 12;
        center.y -= 2;
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
        
        _buttonName = [dict objectForKey:@"buttonImage"];
        _popupName = [dict objectForKey:@"popup"];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(-2, -2, ((NSNumber*)[dict objectForKey:@"width"]).floatValue+4, 44);
        [button addTarget:self action:@selector(pressedEntry:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    _navStr = [dict objectForKey:@"pageLink"];
    
    return self;
}

-(void)pressedEntry:(UIButton *)sender
{
    if( _popupName )
    {
        _dismiss1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismiss1 addTarget:self action:@selector(removePopup:) forControlEvents:UIControlEventTouchUpInside];
        _dismiss1.frame = self.superview.superview.frame;
        [self.superview.superview addSubview:_dismiss1];
        
        _popup = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_popupName]];
        _popup.center = self.superview.superview.center;
        _popup.userInteractionEnabled = YES;
        [self.superview.superview addSubview:_popup];
        
        _dismiss2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismiss2 addTarget:self action:@selector(removePopup:) forControlEvents:UIControlEventTouchUpInside];
        CGRect frame = _popup.frame;
        frame.origin = CGPointZero;
        _dismiss2.frame = frame;
        [_popup addSubview:_dismiss2];
        
        if( _buttonName )
        {
            UIButton* navButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [navButton setImage:[UIImage imageNamed:_buttonName] forState:UIControlStateNormal];
            NSString* buttonOnStr = [NSString stringWithFormat:@"%@%@", _buttonName, @"-on"];
            UIImage* buttonOnImg = [UIImage imageNamed:buttonOnStr];
            [navButton setImage:buttonOnImg forState:UIControlStateHighlighted];
            CGSize s = buttonOnImg.size;
            navButton.frame = CGRectMake(_popup.frame.size.width - s.width - 20,
                                         _popup.frame.size.height - s.height*1.5 - 20, s.width, s.height);
            [_popup addSubview:navButton];
            
            [navButton addTarget:self action:@selector(navigateToNavStr:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

-(void)navigateToNavStr:(UIButton *)sender
{
    [self.delegate timelineEntry:self triggersNavToStr:_navStr];
}

-(void)removePopup:(UIButton *)sender
{
    [UIView animateWithDuration:0.25 animations:^{
        _popup.alpha = 0;
    } completion:^(BOOL finished) {
        [_dismiss1 removeFromSuperview];
        [_popup removeFromSuperview];
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
