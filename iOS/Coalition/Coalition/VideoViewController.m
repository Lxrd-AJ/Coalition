//
//  ChallengesViewController.m
//  Coalition
//
//  Created by AJ Ibraheem on 28/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

#import "VideoViewController.h"
#import "SAVideoRangeSlider.h"
#import <UIKit/UIKit.h>

@interface VideoViewController ()

@property(nonatomic,strong) MPMoviePlayerController *moviePlayer;
@property (weak, nonatomic) IBOutlet UIView *playingArea;
@property(nonatomic,strong) NSURL *videoURL;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Videos";
    self.videoURL = self.content.url;
    self.playingArea.translatesAutoresizingMaskIntoConstraints = NO;
    //build UI
    [self prepareVideoPlayerAt:self.videoURL];
    [self buildQuestionAskingUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareVideoPlayerAt:(NSURL *)url
{
    if ( self.moviePlayer != nil ) {
        [self stopPlayingVideo];
    }
    NSNumber *thumbnailIndex = @3.0f;
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    if (self.moviePlayer != nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoHasFinishedPlaying:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
        self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
        [self.moviePlayer setControlStyle:MPMovieControlStyleEmbedded];
        [self.moviePlayer prepareToPlay];
        self.moviePlayer.shouldAutoplay = NO;
        self.moviePlayer.view.frame = CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.4 );
        [self.view addSubview:self.moviePlayer.view];
        
        //Add the slider
        SAVideoRangeSlider *mySAVideoRangeSlider = [[SAVideoRangeSlider alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height * 0.4) + 65, [UIScreen mainScreen].bounds.size.width, 70) videoUrl:url];
        [mySAVideoRangeSlider setPopoverBubbleSize:200 height:100];
        mySAVideoRangeSlider.delegate = self;
        mySAVideoRangeSlider.minGap = 5; // optional, seconds
        mySAVideoRangeSlider.maxGap = 600; // optional, seconds
        [self.view addSubview:mySAVideoRangeSlider];
        
        //create thumbnails
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoThumbnailIsAvailable:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:self.moviePlayer];
        [self.moviePlayer requestThumbnailImagesAtTimes:@[thumbnailIndex] timeOption:MPMovieTimeOptionExact];
    }else
        NSLog(@"Failed to instantiate movie player");
}

-(void)stopPlayingVideo
{
    if ( self.moviePlayer != nil ) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
        [self.moviePlayer stop];
    }
}

-(void)videoHasFinishedPlaying:(NSNotification *)notification
{
    NSNumber *reason = [notification.userInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    if ( reason != nil ) {
        NSInteger reasonAsInteger = [reason integerValue];
        switch ( reasonAsInteger ) {
            case MPMovieFinishReasonPlaybackEnded:
                //The movie ended normally
                break;
            case MPMovieFinishReasonPlaybackError:
                //An error occurred which eneded the movie
                break;
            case MPMovieFinishReasonUserExited:
                //User exited the player
                break;
                
            default:
                break;
        }
        [self stopPlayingVideo];
    }
}

-(void)videoThumbnailIsAvailable:(NSNotification *)notification
{
    //get the image
    MPMoviePlayerController *mp = [notification object];
    if ([mp isEqual:self.moviePlayer]) {
        UIImage *thumbnail = [notification.userInfo objectForKey:MPMoviePlayerThumbnailImageKey];
        if ( thumbnail != nil) {
            //use the image for what you need
        }
    }
}

-(void)startPlayingVideo
{
    [self.moviePlayer play];
}

-(void)videoRange:(SAVideoRangeSlider *)videoRange didChangeLeftPosition:(CGFloat)leftPosition rightPosition:(CGFloat)rightPosition
{
    
}

-(void)buildQuestionAskingUI
{
    //create the question label
    UIButton *questionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height * 0.4) + 65 + 70, [UIScreen mainScreen].bounds.size.width, 50)];
    questionButton.tintColor = [UIColor blueColor];
    [questionButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:200 alpha:0.7] forState:UIControlStateNormal];
    [questionButton setTitleColor:[UIColor colorWithRed:10 green:0 blue:0 alpha:0.4] forState:UIControlStateHighlighted];
    [questionButton setTitle:@"Choose Question Type" forState:UIControlStateNormal];
    [questionButton setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.09]];
    [questionButton addTarget:self action:@selector(performAddWithAlertView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:questionButton];
    
}

-(void)performAddWithAlertView:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Question Types" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Question and Answer",@"Multiple Choice", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if( [buttonTitle isEqualToString:@"Question and Answer"] ){
        //do some shit
    }else if( [buttonTitle isEqualToString:@"Multiple Choice"] ){
        //do some other shit
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self stopPlayingVideo];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
