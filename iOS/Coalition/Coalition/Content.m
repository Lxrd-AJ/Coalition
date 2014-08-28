//
//  Content.m
//  Coalition
//
//  Created by AJ Ibraheem on 28/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//



#import "Content.h"

@implementation Content

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.thumbnail = [[UIImage alloc] init];
        self.challenges = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
