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
    NSString* _blurImageName;
    NSMutableArray* _allBlurredViews;
}

@property(strong, nonatomic) id<SGContentControllerDelegate> delegate;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *blurredViews;

@end
