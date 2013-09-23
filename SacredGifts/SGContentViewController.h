//
//  SGContentViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGContentControllerDelegate.h"

@interface SGContentViewController : UIViewController
{
    NSString* _backgroundPatternStr, *_blurredBackgroundPatternStr;
}
@property(strong, nonatomic) id<SGContentControllerDelegate> delegate;
@end
