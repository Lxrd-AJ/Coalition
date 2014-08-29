//
//  ChallengesViewController.h
//  Coalition
//
//  Created by AJ Ibraheem on 28/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#import "VideoView.h"
#import "Content.h"
#import "SAVideoRangeSlider.h"

@interface VideoViewController : UIViewController <SAVideoRangeSliderDelegate, UIAlertViewDelegate>

@property(nonatomic, strong) Content *content;

@end
