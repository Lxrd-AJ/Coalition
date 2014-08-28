//
//  Model.m
//  Coalition
//
//  Created by AJ Ibraheem on 28/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#import "Model.h"
#import "Chapter.h"
#import "Content.h"

@implementation Model

-(instancetype)init
{
    self = [super init];
    if (self) {
        //Build up the course objects
        self.courses = [[NSMutableArray alloc] init];
        [self loadCourses];
    }
    return self;
}

-(void)loadCourses
{
    NSString *basePath = [[NSBundle mainBundle] bundlePath];
    NSString *path = [basePath stringByAppendingString:@"/coursera_videos/"];
    NSArray *directories = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    for (NSString *course in directories) {
        //Build up the Courses
        Course *aCourse = [[Course alloc] init];
        aCourse.name = course;
        //Build up Chapters
        NSString *coursePath = [path stringByAppendingString:course];
        coursePath = [coursePath stringByAppendingString:@"/"];
        NSArray *chapters = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:coursePath error:nil];
        for (NSString *chapter in chapters) {
            //Build up each chapter
            //create chapter object
            Chapter *aChapter = [[Chapter alloc] init];
            aChapter.name = chapter;
            //create the contents for each chapeter
            NSString *chapterPath = [coursePath stringByAppendingString:chapter];
            chapterPath = [chapterPath stringByAppendingString:@"/"];
            NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:chapterPath error:nil];
            for (NSString *content in contents) {
                Content *aContent = [[Content alloc] init];
                aContent.name = content;
                //Build up the URL String
                NSString *urlString = [chapterPath stringByAppendingString:content];
                aContent.url = [NSURL fileURLWithPath:urlString];
                aContent.thumbnail = [self thumbnailFromVideoAtURL:aContent.url];
                //add the content to the chapter
                [aChapter.contents addObject:aContent];
            }
            
            //add the chapter to the course
            [aCourse.chapters addObject:aChapter];
        }
        
        [self.courses addObject:aCourse];
    }
    
}


-(UIImage *)thumbnailFromVideoAtURL:(NSURL *)url
{
    AVAsset *asset = [AVAsset assetWithURL:url];
    
    //  Get thumbnail at the very start of the video
    CMTime thumbnailTime = [asset duration];
    thumbnailTime.value = 1;
    
    //  Get image from the video at the given time
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:thumbnailTime actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return thumbnail;

}




@end
