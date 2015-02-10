//
//  AccountOperations.m
//  AFDemo
//
//  Created by chuguangming on 15/2/6.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "AccountOperations.h"
#import "AFNetworking.h"
@interface AccountOperations()
@property(nonatomic)NSString *accesstoken;
@end
@implementation AccountOperations
@synthesize accesstoken;
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
    //获取accesstoken
    [self getAccessToken:parameters :^(NSString *strAccess_Token,BOOL returnVal) {
        NSLog(@"%@ %d",strAccess_Token,returnVal);
        accesstoken=strAccess_Token;
    }];

}
//注册用户
- (void)registerStudent:(User*) student{
    //需要传递的数据
    NSDictionary *parameters = @{
                                 @"phone" :student.phone,
                                 @"password" : student.password,
                                 @"name" : student.userName,
                                 @"gender" : student.gender,
                                 @"email" : student.email,
                                 @"college_id" : @"153",
                                 @"major" : student.major
                                 };
    [self registerMethod:parameters :^(id returnDic, BOOL returnVal) {
        NSLog(@"%@ %d",returnDic,returnVal);
    }];
}

//获取注册短信验证码
- (void)getRegisterCodeWithPhone:(NSString*) phone {
    //需要传递的数据
    NSDictionary *parameters = @{
                                 @"phone" :phone,
                                 @"behavior" : @"1"
                                 };
    [self getRegisterCodeWithPhoneMethod:parameters :^(id returnDic, BOOL returnVal) {
        NSLog(@"%@ %d",returnDic,returnVal);
    }];
}

//验证注册输入的短信
- (void)checkRegisterCodeWithPhone:(NSString*) phone andCode:(NSString *)code {
    //需要传递的数据
    NSDictionary *parameters = @{
                                 @"phone" :phone,
                                 @"code":code,
                                 @"behavior" : @"1"
                                 };
    [self checkRegisterCodeWithPhoneMethod:parameters :^(id returnDic, BOOL returnVal) {
        if (returnVal) {
            NSLog(@"%@ %d",returnDic,returnVal);
        }
        else
        {
            NSLog(@"请求失败");
        }
    }];
}

//修改密码
- (void)changeCurrentPassword:(NSString *)currentPassword withNewPassword:(NSString *)newPassword andConfirmPassword:(NSString *)confirmPassword {

}

//找回密码
- (void)findPasswordWithPhone:(NSString*) phone andPassword:(NSString *)newPassword {

}

//获取找回密码短信验证码
- (void)getFindCodeWithPhone:(NSString*) phone {}

//验证找回密码输入的短信
- (void)checkFindCodeWithPhone:(NSString*) phone andCode:(NSString *)code{}

//注销
- (void)logoff{}

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
//注册方法
- (void)registerMethod:(NSDictionary*)params:(void (^)(id returnDic,BOOL returnVal))completion {
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    
    operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/vnd.591m.v1+json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    
    [operationManager POST:@"http://121.42.51.177/user"
                parameters:params
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       if(completion) {
                           completion(responseObject,TRUE);
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
//注册方法
- (void)getRegisterCodeWithPhoneMethod:(NSDictionary*)params:(void (^)(id returnDic,BOOL returnVal))completion {
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    
    operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/vnd.591m.v1+json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    
    [operationManager POST:@"http://121.42.51.177/user/access_code"
                parameters:params
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       if(completion) {
                           completion(responseObject,TRUE);
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
- (void)checkRegisterCodeWithPhoneMethod:(NSDictionary*)params:(void (^)(id returnDic,BOOL returnVal))completion {
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    
    operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/vnd.591m.v1+json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    
    [operationManager POST:@"http://121.42.51.177/user/check_code"
                parameters:params
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       if(completion) {
                           completion(responseObject,TRUE);
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
