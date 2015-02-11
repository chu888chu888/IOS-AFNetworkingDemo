//
//  ITunesClient.m
//  AFDemo
//
//  Created by chuguangming on 15/2/11.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "ITunesClient.h"

@implementation ITunesClient
+ (ITunesClient *)sharedClient {
    static ITunesClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"https://itunes.apple.com/"];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"TuneStore iOS 1.0"}];
        
        //设置我们的缓存大小 其中内存缓存大小设置10M  磁盘缓存5M
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        
        [config setURLCache:cache];
        
        _sharedClient = [[ITunesClient alloc] initWithBaseURL:baseURL
                                         sessionConfiguration:config];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];

    });
    
    return _sharedClient;
}

- (NSURLSessionDataTask *)searchForTerm:(NSString *)term completion:( void (^)(NSArray *results, NSError *error) )completion {
    NSURLSessionDataTask *task = [self GET:@"/search"
                                  //为了速度我们将地区设置为台湾
                                parameters:@{ @"country" : @"TW",
                                              @"term" : term }
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                       if (httpResponse.statusCode == 200) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseObject[@"results"], nil);
                                           });
                                       } else {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, nil);
                                           });
                                           NSLog(@"Received: %@", responseObject);
                                           NSLog(@"Received HTTP %d", httpResponse.statusCode);
                                       }
                                       
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           completion(nil, error);
                                       });
                                   }];
    return task;
}
@end
