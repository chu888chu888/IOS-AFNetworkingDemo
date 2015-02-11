//
//  ITunesClient.h
//  AFDemo
//
//  Created by chuguangming on 15/2/11.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
@interface ITunesClient : AFHTTPSessionManager
+ (ITunesClient *)sharedClient;
- (NSURLSessionDataTask *)searchForTerm:(NSString *)term completion:( void (^)(NSArray *results, NSError *error) )completion;
@end
