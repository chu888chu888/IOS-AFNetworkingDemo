//
//  ResumeOperations.m
//  AFDemo
//
//  Created by chuguangming on 15/2/10.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "ResumeOperations.h"
#import "AFNetworking.h"
@implementation ResumeOperations
//请求宣讲会方法
-(void)get_recruitment_info
{

    [self recruitment_info_Method:nil :^(id returnDic, BOOL returnVal) {
        NSLog(@"%@ %d",returnDic,returnVal);
        NSLog(@"%@",[returnDic[@"data"][0] objectForKey:@"address"]);
    }];

}
//注册方法
- (void)recruitment_info_Method:(NSDictionary*)params:(void (^)(id returnDic,BOOL returnVal))completion {
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    
    operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/vnd.591m.v1+json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    

    [operationManager.requestSerializer setValue:@"Bearer VpPOlRBxP81Yr6Q9OG1dS78rBz1RJKUkoluYbq5B" forHTTPHeaderField:@"Authorization"];
    
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    
    [operationManager GET:@"http://121.42.51.177/recruitment_info?city=189"
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
- (NSString *)replaceUnicode:(NSString *)unicodeStr {
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    //NSLog(@"Output = %@", returnStr);
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}
@end
