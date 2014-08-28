//
//  ChallengesViewController.m
//  Coalition
//
//  Created by AJ Ibraheem on 28/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

#import "ChallengesViewController.h"

@interface ChallengesViewController ()

@property(nonatomic,strong) MPMoviePlayerController *moviePlayer;
@property(nonatomic,strong) NSURL *videoURL;

@end

@implementation ChallengesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startPlayingVideo:(id)sender{
    NSBundle *mainBundle = [NSBundle mainBundle];
    
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
