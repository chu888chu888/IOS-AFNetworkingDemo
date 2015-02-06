//
//  LoginView.h
//  AFDemo
//
//  Created by chuguangming on 15/2/6.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalUIView.h"
@interface LoginView : GlobalUIView
@property (strong, nonatomic) UITextField *nameText;
@property (strong, nonatomic) UITextField *passwordText;
@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIButton *findBtn;
@property (strong, nonatomic) UIButton *registerBtn;
@end
