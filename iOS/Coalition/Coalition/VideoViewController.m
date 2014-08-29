//
//  ChallengesViewController.m
//  Coalition
//
//  Created by AJ Ibraheem on 28/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@property(nonatomic,strong) MPMoviePlayerController *moviePlayer;
@property(nonatomic,strong) UIView *playingArea;
@property (weak, nonatomic) IBOutlet UIView *playingAreaNib;
@property(nonatomic,strong) NSURL *videoURL;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.playingArea = self.playingAreaNib;
    self.videoURL = self.content.url;
    self.playingArea.backgroundColor = [UIColor blackColor];
        
    //build Ui
    [self prepareVideoPlayerAt:self.videoURL];
    
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
        [self.moviePlayer setFullscreen:YES animated:YES];
        [self.playingArea addSubview:self.moviePlayer.view];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
