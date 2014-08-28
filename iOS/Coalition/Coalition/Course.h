//
//  Course.h
//  Coalition
//
//  Created by AJ Ibraheem on 28/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chapter.h"

@interface Course : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSMutableArray *chapters;

@end
