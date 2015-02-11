//
//  NoodleApi.m
//  AFDemo
//
//  Created by chuguangming on 15/2/6.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "NoodleApi.h"
static NSString *const BASEURL = @"http://douban.fm/j/mine/playlist?type=n&h=&channel=0&from=mainsite&r=4941e23d79";

@implementation NoodleApi
+ (instancetype)sharedClient
{
    static NoodleApi *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[NoodleApi alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    });
    return client;
}
@end
