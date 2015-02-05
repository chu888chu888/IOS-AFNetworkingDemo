//
//  AFViewController.m
//  AFDemo
//
//  Created by chuguangming on 15/2/4.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "AFViewController.h"

#import "AFNetworking.h"
#import "HttpReturnModel.h"
@interface AFViewController ()
@property(strong,nonatomic)NSString *returnJsonStr;
@end

@implementation AFViewController
@synthesize returnJsonStr;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self AFHTTPRequestOperationManagerDemo];
    //[self AFURLSessionManagerDownloadDemo];
    //[self AFURLSessionManagerUploadDemo];
    //[self AFURLSessionManagerUploadDemo2];
    
    
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
                       
                       
                       NSString *value1 = responseObject[@"access_token"];
                       NSString *value2 = responseObject[@"expires_in"];
                       NSString *value3 = responseObject[@"refresh_token"];
                       NSString *value4 = responseObject[@"token_type"];

                       /*
                       NSLog(@"--------------------------");
                       NSString* json = @"{\"access_token\":\"access_token\", \"expires_in\":\"access_token\",\"refresh_token\":\"access_token\",\"token_type\":\"access_token\",}";
                       HttpReturnModel *returnModel=[[HttpReturnModel alloc]initWithString:returnJsonStr error:nil];
                       NSLog(@"Model:%@",returnModel.access_token);
                        */
                       NSLog(@"");
                       
                   }
                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       
                       NSLog(@"Error: %@", [error description]);
                       
                   }
     ];
   
    /*
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *dict1 = @{@"username": @"13145877854"};
    NSDictionary *dict2 = @{@"client_id": @"ObpJAwJ7WP4s4Rwd"};
    NSDictionary *dict3 = @{@"client_secret": @"WMv9vbYIFz8ugpwl6zDNThzn4KLoxLTV"};
    NSDictionary *dict4 = @{@"grant_type": @"password"};
    NSDictionary *dict5 = @{@"password": @"888888"};
    NSArray *array = @[dict1, dict2, dict3, dict4, dict5];
    // 设置请求格式
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/vnd.591m.v1+json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    // 设置返回格式
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://121.42.51.177/auth/access-token" parameters:array success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
     */
    
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
