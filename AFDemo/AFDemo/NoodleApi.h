//
//  NoodleApi.h
//  AFDemo
//
//  Created by chuguangming on 15/2/6.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface NoodleApi : AFHTTPSessionManager
/**
 *  @brief 单例模式
 *  @param
 *  @return 返回一个类的实例
 */
+ (instancetype)sharedClient;
@end
