//
//  Challenge.h
//  Coalition
//
//  Created by AJ Ibraheem on 28/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Challenge : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *answer;
@property (nonatomic, assign) BOOL completed;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, assign) float begin;
@property (nonatomic, assign) float end;

@end
