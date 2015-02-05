//
//  HttpReturnModel.h
//  AFDemo
//
//  Created by chuguangming on 15/2/5.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface HttpReturnModel : JSONModel
@property(strong,nonatomic) NSString *access_token;
@property(strong,nonatomic) NSString *expires_in;
@property(strong,nonatomic) NSString *refresh_token;
@property(strong,nonatomic) NSString *token_type;
@end
