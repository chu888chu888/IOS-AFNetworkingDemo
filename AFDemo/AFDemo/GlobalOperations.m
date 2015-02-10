//
//  GlobalOperations.m
//  AFDemo
//
//  Created by chuguangming on 15/2/6.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "GlobalOperations.h"
#import "AFNetworking.h"
@implementation GlobalOperations
@synthesize strAccessToken,strPassWord,strUserName;

-(id)initWithUserName:(NSString *)strusername PassWord:(NSString *)strpassword
{
    if (self=[super init]) {
        strUserName=strusername;
        strPassWord=strpassword;
        [self getAccessToken];
    }
    return self;
    
}
//请求accesstoken
-(void)getAccessToken
{
    //需要传递的数据
    NSDictionary *parameters = @{
                                 @"grant_type" :@"password",
                                 @"client_id" : @"ObpJAwJ7WP4s4Rwd",
                                 @"client_secret" : @"WMv9vbYIFz8ugpwl6zDNThzn4KLoxLTV",
                                 @"password" : strPassWord,
                                 @"username" : strUserName
                                 };
    //获取accesstoken
    [self getAccessToken:parameters :^(NSString *strAccess_Token,BOOL returnVal) {
        //NSLog(@"%@ %d",strAccess_Token,returnVal);
        if (returnVal) {
            NSLog(@"%@ %d",strAccess_Token,returnVal);
            strAccessToken=strAccess_Token;
        }
        else
        {
            NSLog(@"请求失败");
            strAccessToken=nil;
        }
        
    }];
}

//获取accesstoken
- (void)getAccessToken:(NSDictionary*)params:(void (^)(NSString *strAccess_Token,BOOL returnVal))completion {
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    
    operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/vnd.591m.v1+json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    
    [operationManager POST:@"http://121.42.51.177/auth/access-token"
                parameters:params
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       if(completion) {
                           completion(responseObject[@"access_token"],TRUE);
                       }
                   }
                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       if(completion) {
                           completion(nil,FALSE);
                           NSLog(@"Error: %@", [error description]);
                       }
                       
                   }
     ];
}
@end
