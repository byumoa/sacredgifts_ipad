//
//  SGAbstractAudioManager.h
//  SacredGifts
//
//  Created by Ontario on 10/16/13.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SGAbstractAudioManager : NSObject <AVAudioPlayerDelegate>
{
    NSString* _currentAudioPath;
}
@property (strong, nonatomic) AVAudioPlayer* player;

- (void)playAudioWithPath: (NSString*)audioPath;
- (void)pauseAudio;

@end
