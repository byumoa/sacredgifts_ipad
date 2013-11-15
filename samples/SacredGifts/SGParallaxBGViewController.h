//
//  SGParallaxBGViewController.h
//  SacredGifts
//
//  Created by Ontario on 11/15/13.
//
//

#import "SGContentViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface SGParallaxBGViewController : SGContentViewController<UIAccelerometerDelegate>
{
    CMMotionManager *_motionManager;
}
@property (weak, nonatomic) IBOutlet UIImageView* background;

- (void)startParallaxing;
- (void)stopParallaxing;

@end
