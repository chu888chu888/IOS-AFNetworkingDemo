//
//  GlobalOperations.h
//  AFDemo
//
//  Created by chuguangming on 15/2/6.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalOperations : NSObject
@property(nonatomic) NSString *strAccessToken;
@property(nonatomic) NSString *strUserName;
@property(nonatomic) NSString *strPassWord;
-(id)initWithUserName:(NSString *)strusername PassWord:(NSString *)strpassword;
-(void)getAccessToken;
@end
