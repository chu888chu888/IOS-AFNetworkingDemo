//
//  AccountOperations.m
//  AFDemo
//
//  Created by chuguangming on 15/2/6.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "AccountOperations.h"
#import "AFNetworking.h"

@implementation AccountOperations
-(void)loginStudent:(User*) student
{
    
    //需要传递的数据
    NSDictionary *parameters = @{
                                 @"grant_type" :@"password",
                                 @"client_id" : @"ObpJAwJ7WP4s4Rwd",
                                 @"client_secret" : @"WMv9vbYIFz8ugpwl6zDNThzn4KLoxLTV",
                                 @"password" : student.password,
                                 @"username" : student.userName
                                 };
    [self getAccessToken:parameters :^(NSString *strAccess_Token) {
        NSLog(@"%@",strAccess_Token);
    }];
    
}
//注册用户
- (void)registerStudent:(User*) student{}

//获取注册短信验证码
- (void)getRegisterCodeWithPhone:(NSString*) phone {}

//验证注册输入的短信
- (void)checkRegisterCodeWithPhone:(NSString*) phone andCode:(NSString *)code {}

//修改密码
- (void)changeCurrentPassword:(NSString *)currentPassword withNewPassword:(NSString *)newPassword andConfirmPassword:(NSString *)confirmPassword {}

//找回密码
- (void)findPasswordWithPhone:(NSString*) phone andPassword:(NSString *)newPassword {}

//获取找回密码短信验证码
- (void)getFindCodeWithPhone:(NSString*) phone {}

//验证找回密码输入的短信
- (void)checkFindCodeWithPhone:(NSString*) phone andCode:(NSString *)code{}

//注销
- (void)logoff{}

//回调方法
- (void)getAccessToken:(NSDictionary*)params:(void (^)(NSString *strAccess_Token))completion {
    
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
                           completion(responseObject[@"access_token"]);
                       }
                   }
                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"Error: %@", [error description]);
                   }
     ];
}
@end
