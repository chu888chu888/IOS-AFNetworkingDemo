//
//  LoginViewController.m
//  AFDemo
//
//  Created by chuguangming on 15/2/6.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "LoginViewController.h"
#import "AccountOperations.h"
#import "User.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

-(void) loadView {
    self.view = [LoginView new];
    [self.view.loginBtn addTarget:self action:@selector(loginHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.registerBtn addTarget:self action:@selector(registerHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.findBtn addTarget:self action:@selector(findHandle) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
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

#pragma mark 点击跳转操作
-(void)loginHandle {
    AccountOperations *accountOperations=[AccountOperations new];
    User *ModelStudent=[User new];
    ModelStudent.userName=[self.view.nameText text];
    ModelStudent.password=[self.view.passwordText text];
    [accountOperations loginStudent:ModelStudent];
}

-(void)registerHandle{

}

-(void)findHandle{

}


@end
