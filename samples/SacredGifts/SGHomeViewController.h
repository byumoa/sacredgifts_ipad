//
//  SGHomeViewController.h
//  SacredGifts
//
//  Created by Ontario on 9/20/13.
//  Copyright (c) 2013 Wells Fargo. All rights reserved.
//

#import "SGContentViewController.h"

typedef enum
{
    kNavigationDestinationHome = 0,
    kNavigationDestinationFindAPainting = 1,
    kNavigationDestinationMeetTheArtists = 2,
    kNavigationDestinationAboutTheExhibition = 3
}NavigationDestination;

@interface SGHomeViewController : SGContentViewController

@end
