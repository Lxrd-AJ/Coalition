//
//  Content.h
//  Coalition
//
//  Created by AJ Ibraheem on 28/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Content : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSURL *url;
@property(nonatomic,strong) UIImage *thumbnail;
@property(nonatomic,strong) NSMutableArray *challenges;

@end
