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
#import "Challenge.h"

#define kOFFSET_FOR_KEYBOARD 120.0

@interface VideoViewController ()

@property(nonatomic,strong) MPMoviePlayerController *moviePlayer;
@property (weak, nonatomic) IBOutlet UIView *playingArea;
@property(nonatomic,strong) NSURL *videoURL;
@property (nonatomic, strong) UITextField *question;
@property (nonatomic, strong) UITextField *answer;
@property (nonatomic, assign) float begin;
@property (nonatomic, assign) float end;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Videos";
    self.videoURL = self.content.url;
    self.playingArea.translatesAutoresizingMaskIntoConstraints = NO;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    [super viewWillAppear:animated];
    //build UI
    for (UIView *v in self.view.subviews) {
        [v removeFromSuperview];
    }
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
        mySAVideoRangeSlider.maxGap = 120; // optional, seconds
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
    CGFloat sHeight = [UIScreen mainScreen].bounds.size.height;
    //create the question label
    UIButton *questionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height * 0.4) + 65 + 70, [UIScreen mainScreen].bounds.size.width, sHeight * 0.05 )];
    questionButton.tintColor = [UIColor blueColor];
    [questionButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:200 alpha:0.7] forState:UIControlStateNormal];
    [questionButton setTitleColor:[UIColor colorWithRed:10 green:0 blue:0 alpha:0.4] forState:UIControlStateHighlighted];
    [questionButton setTitle:@"Choose Question Type" forState:UIControlStateNormal];
    [questionButton setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.09]];
    [questionButton addTarget:self action:@selector(performAddWithAlertView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:questionButton];
    
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, sHeight - 50, [UIScreen mainScreen].bounds.size.width, sHeight * 0.05)];
    [saveButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:200 alpha:0.7] forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor colorWithRed:10 green:0 blue:0 alpha:0.4] forState:UIControlStateHighlighted];
    [saveButton setTitle:@"Create Challenge" forState:UIControlStateNormal];
    [saveButton setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.09]];
    [saveButton addTarget:self action:@selector(saveChallenge:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
}

-(void)saveChallenge:(id)sender
{
//    NSLog(@"%@, %@", self.question, self.answer);
    Challenge *aChallenge = [[Challenge alloc] init];
    aChallenge.name = self.content.name;
    aChallenge.question = self.question.text;
    aChallenge.answer = self.answer.text;
    aChallenge.completed = NO;
    aChallenge.url = self.content.url;
    aChallenge.begin = self.begin;
    aChallenge.end = self.end;
    [self.content.challenges addObject:aChallenge];
    [self.navigationController popViewControllerAnimated:YES];
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
        [self displayQandAView];
    }else if( [buttonTitle isEqualToString:@"Multiple Choice"] ){
        [self displayMultipleChoiceView];
    }
}

-(void)displayQandAView
{
    CGFloat sWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat sHeight = [UIScreen mainScreen].bounds.size.height;
    
    //Create the question textfield
    UITextField *questionField = [[UITextField alloc] initWithFrame:CGRectMake(0, (sHeight * 0.4) + 65 + 70 + 50 , sWidth / 2, sHeight * 0.35 )];
    [questionField setBorderStyle:UITextBorderStyleLine];
    questionField.placeholder = @"Enter your Question Here";
    [self.view addSubview:questionField];
    
    UITextField *answerField = [[UITextField alloc] initWithFrame:CGRectMake(sWidth/2, (sHeight * 0.4) + 65 + 70 + 50, sWidth/2, sHeight * 0.35)];
    [answerField setBorderStyle:UITextBorderStyleLine];
    answerField.placeholder = @"Enter your Answer Here";
    [self.view addSubview:answerField];
    
    self.question = questionField;
    self.answer = answerField;
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    [sender becomeFirstResponder];
    if (sender != nil ) {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }

}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


-(void)displayMultipleChoiceView
{
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self stopPlayingVideo];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
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
