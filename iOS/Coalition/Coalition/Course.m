//
//  Course.m
//  Coalition
//
//  Created by AJ Ibraheem on 28/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

#import "Course.h"

@implementation Course

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.chapters = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
