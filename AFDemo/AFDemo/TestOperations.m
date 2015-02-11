//
//  TestOperations.m
//  AFDemo
//
//  Created by chuguangming on 15/2/11.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "TestOperations.h"
#import "NoodleApi.h"
@interface TestOperations()

@end
@implementation TestOperations
///调用
- (void)getData{
    /**
     *  请求网络数据，具体情况具体分析采用get or post
     *
     *  @param task
     *  @param responseObject
     *
     *  @note 路径如果没有可以用@“”来替代。
     */
    
    [[NoodleApi sharedClient] GET:@"" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"responseObject=%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"error=%@",[error localizedDescription]);
        
    }];
    
    /**
     *  返回当前的网络状态
     */
    NSLog(@"net type=%ld",[[[NoodleApi sharedClient] reachabilityManager] networkReachabilityStatus]);
    
}

@end
