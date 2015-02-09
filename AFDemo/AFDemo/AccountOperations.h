//
//  AccountOperations.h
//  AFDemo
//
//  Created by chuguangming on 15/2/6.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface AccountOperations : NSObject
//用户登录
-(void)loginStudent:(User*) student;
//注册用户
- (void)registerStudent:(User*) student ;

//获取注册短信验证码
- (void)getRegisterCodeWithPhone:(NSString*) phone ;

//验证注册输入的短信
- (void)checkRegisterCodeWithPhone:(NSString*) phone andCode:(NSString *)code ;

//修改密码
- (void)changeCurrentPassword:(NSString *)currentPassword withNewPassword:(NSString *)newPassword andConfirmPassword:(NSString *)confirmPassword ;

//找回密码
- (void)findPasswordWithPhone:(NSString*) phone andPassword:(NSString *)newPassword ;

//获取找回密码短信验证码
- (void)getFindCodeWithPhone:(NSString*) phone ;

//验证找回密码输入的短信
- (void)checkFindCodeWithPhone:(NSString*) phone andCode:(NSString *)code ;

//注销
- (void)logoff;
@end
