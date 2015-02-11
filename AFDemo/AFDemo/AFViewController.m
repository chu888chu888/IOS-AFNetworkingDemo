//
//  AFViewController.m
//  AFDemo
//
//  Created by chuguangming on 15/2/4.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "AFViewController.h"

#import "AFNetworking.h"
#import "GlobalOperations.h"
#import "ResumeOperations.h"
#import "TestOperations.h"
#import "ITunesClient.h"
@interface AFViewController ()
@property(strong,nonatomic)NSString *returnJsonStr;
@property(strong,nonatomic)NSString *returnAccessToken;
@property(nonatomic) NSArray *returnJson;
@end

@implementation AFViewController
@synthesize returnJsonStr,returnAccessToken,returnJson;
- (void)AFHTTPRequestOperationManagerDemo {
    //封装与Web应用程序通过HTTP交互，包括请求的创建，响应序列化，
    //网络可达性监控和安全，以及请求操作管理的常见沟通模式。
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //POST请求
    [manager POST:@"http://www.sina.com.cn/" parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject); }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error); }];
    //GET请求
    [manager GET:@"http://www.sina.com.cn/" parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject); }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error); }];
    
    //复杂表单
    NSDictionary *parameters = @{@"foo": @"bar"};
    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    [manager POST:@"http://example.com/resources.json" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:filePath name:@"image" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)AFURLSessionManagerDownloadDemo {
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://www.oschina.net/js/ke/plugins/emoticons/1.gif"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}

- (void)AFURLSessionManagerUploadDemo {
    // Do any additional setup after loading the view.

    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
}

- (void)AFURLSessionManagerUploadDemo2 {
    //创建一个复杂的上传,带进度
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"file://path/to/image.jpg"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    
    [uploadTask resume];
}

- (void)APIDemo_accesstoken {
   
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"username": @"13145877854",@"client_id":@"ObpJAwJ7WP4s4Rwd",
                             @"client_secret":@"WMv9vbYIFz8ugpwl6zDNThzn4KLoxLTV",
                             @"grant_type":@"password",@"password":@"888888"};
    
    operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [operationManager.requestSerializer setValue:@"application/vnd.591m.v1+json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    
    [operationManager POST:@"http://121.42.51.177/auth/access-token"
                parameters:params
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       
                       /*
                        NSString *access_tokenStr = responseObject[@"access_token"];
                        NSString *expires_inStr = responseObject[@"expires_in"];
                        NSString *refresh_tokenStr = responseObject[@"refresh_token"];
                        NSString *token_typeStr = responseObject[@"token_type"];
                        */
                       /*
                        NSLog(@"--------------------------");
                        NSString* json = @"{\"access_token\":\"access_token\", \"expires_in\":\"access_token\",\"refresh_token\":\"access_token\",\"token_type\":\"access_token\",}";
                        HttpReturnModel *returnModel=[[HttpReturnModel alloc]initWithString:returnJsonStr error:nil];
                        NSLog(@"Model:%@",returnModel.access_token);
                        */
                       /*
                       NSString *returnStr=[self dictionaryOrArrayToJSONString:responseObject];
                       HttpReturnModel *returnModel=[[HttpReturnModel alloc]initWithString:returnStr error:nil];
                       NSLog(@"access_token:%@",returnModel.access_token);*/
                       
                   }
                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       
                       NSLog(@"Error: %@", [error description]);
                       
                   }
     ];
}

- (void)APIDemo_Recruitment {

    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    
    operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/vnd.591m.v1+json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [operationManager.requestSerializer setValue:@"Bearer nEbdELZeu0rGy8ULR3wydVt4xt2dwHuQaMMgFtIV" forHTTPHeaderField:@"Authorization"];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    
    [operationManager GET:@"http://121.42.51.177/recruitment?city=1"
               parameters:nil
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      NSLog(@"%@",responseObject);
                  }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      NSLog(@"Error: %@", [error description]);
                  }
     ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self AFHTTPRequestOperationManagerDemo];
    //[self AFURLSessionManagerDownloadDemo];
    //[self AFURLSessionManagerUploadDemo];
    //[self AFURLSessionManagerUploadDemo2];
    //[self APIDemo_accesstoken];
    
    /*
     //在操作之前一定要先获取access_token
     [self getAccessToken:^(NSString *str) {
     // Stop the animation
     // and use returned model here
     NSLog(@"access_token:%@",str);
     }];
     */
    
    //[self APIDemo_Recruitment];
    /*
    [self getAccessToken2:@"s666" :^(NSString *strAccess_Token) {
        NSLog(@"%@",strAccess_Token);
    }];
     */
    //GlobalOperations *globalOP=[[GlobalOperations alloc] initWithUserName:@"13145877854" PassWord:@"888888"];
    //[globalOP getAccessToken];
    //globalOP.strUserName=@"13145877854";
    //globalOP.strPassWord=@"888888";
    //NSLog(@"%@",globalOP.strUserName);
    //NSLog(@"%@",globalOP.strAccessToken);
    //ResumeOperations *resumeOP=[ResumeOperations new];
    //[resumeOP get_recruitment_info];
    
    //TestOperations *testOP=[TestOperations new];
    //[testOP getData];
    
    NSURLSessionDataTask *task = [[ITunesClient sharedClient] searchForTerm:@"刘德华"
                                                                 completion:^(NSArray *results, NSError *error) {
                                                                     if (results) {
                                                                         //NSLog(@"Result: %@", results);
                                                                         returnJson=results;
                                                                         [self printJson];

                                                                     } else {
                                                                         NSLog(@"ERROR: %@", error);
                                                                     }
                                                                 }];

    
}
-(void)printJson
{
        NSLog(@"returnJson %@",returnJson);
}
- (void)getAccessToken2:(NSString*)strUser:(void (^)(NSString *strAccess_Token))completion {
    NSLog(@"%@",strUser);
    if(completion) {
        NSString *str=@"sssss";
        completion(str);
    }
}

- (void)getAccessToken:(void (^)(NSString *strAccess_Token))completion {

     AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
     NSDictionary *params = @{@"username": @"13145877854",@"client_id":@"ObpJAwJ7WP4s4Rwd",
                              @"client_secret":@"WMv9vbYIFz8ugpwl6zDNThzn4KLoxLTV",
                              @"grant_type":@"password",@"password":@"888888"};
     
     operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
     [operationManager.requestSerializer setValue:@"application/vnd.591m.v1+json" forHTTPHeaderField:@"Accept"];
     [operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
     
     operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
     operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
     
     
     [operationManager POST:@"http://121.42.51.177/auth/access-token"
                 parameters:params
                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        
                        
                        returnAccessToken=responseObject[@"access_token"];
                        
                        if(completion) {
                            completion(returnAccessToken);
                        }
                        //access_tokenStr = responseObject[@"access_token"];
                        
                        
                    }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"Error: %@", [error description]);
                    }
      ];
}
//以下这种写法是一种非常严重的错误,因为程序是异步的,所以也许会得不到值
-(void)getAccess_Token
{
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"username": @"13145877854",@"client_id":@"ObpJAwJ7WP4s4Rwd",
                             @"client_secret":@"WMv9vbYIFz8ugpwl6zDNThzn4KLoxLTV",
                             @"grant_type":@"password",@"password":@"888888"};
    
    operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/vnd.591m.v1+json" forHTTPHeaderField:@"Accept"];
    [operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];

    
    [operationManager POST:@"http://121.42.51.177/auth/access-token"
                parameters:params
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       returnAccessToken = responseObject[@"access_token"];
                   }
                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"Error: %@", [error description]);
                   }
     ];
}
//将字典与数组转换为Json字符串
-(NSString *)dictionaryOrArrayToJSONString:(id)dictionaryOrArray
{
    //对于NSJSONReadingMutableContainers我做一个解释
    /*
    NSJSONReadingMutableContainers
    Specifies that arrays and dictionaries are created as mutable objects.    //  创建可变的数组或字典 接收
    
    NSJSONReadingMutableLeaves
    Specifies that leaf strings in the JSON object graph are created as instances of NSMutableString.   // 指定在JSON对象可变字符串被创建为NSMutableString的实例
    
    NSJSONReadingAllowFragments
    Specifies that the parser should allow top-level objects that are not an instance of NSArray or NSDictionary   //  指定解析器应该允许不属于的NSArray或NSDictionary中的实例顶层对象
    */
    NSData *data=[NSJSONSerialization dataWithJSONObject:dictionaryOrArray options:NSJSONReadingMutableContainers error:nil];
    if(data==nil)
    {
        return nil;
    }
    NSString *string=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
