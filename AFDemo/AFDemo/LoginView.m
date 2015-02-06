//
//  LoginView.m
//  noodleBlue
//
//  Created by apple on 15/1/15.
//  Copyright (c) 2015年 noodles. All rights reserved.
//

#import "LoginView.h"
#import "UIButton+Base.h"

@implementation LoginView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void) initialize
{
    //    [self.linearLayoutView setBackgroundColor:[UIColor whiteColor]];
    [self addView];
    [self addLinkView];
    
    
}

-(void) addView
{
    _nameText = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIView globalWidth] - 20, 44)];
    _nameText.borderStyle = UITextBorderStyleNone;
    _nameText.placeholder = @"请输入电话号码";
    _nameText.returnKeyType = UIReturnKeyDone;
    _nameText.text=@"13145877854";
    
    CSLinearLayoutItem *nameTextItem = [CSLinearLayoutItem layoutItemForView:_nameText];
    nameTextItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    nameTextItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:nameTextItem];
    
    _passwordText = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIView globalWidth] - 20, 44)];
    _passwordText.borderStyle = UITextBorderStyleNone;
    _passwordText.placeholder = @"请输入密码";
    _passwordText.secureTextEntry=YES;
    _passwordText.returnKeyType = UIReturnKeyDone;
    _passwordText.text=@"888888";
    
    CSLinearLayoutItem *passwordTextItem = [CSLinearLayoutItem layoutItemForView:_passwordText];
    passwordTextItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    passwordTextItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:passwordTextItem];
    
    
    _loginBtn = [UIButton baseButtonWithColor:[UIColor noodleBaseColor] andTitle:@"登录"];
    CSLinearLayoutItem *loginBtnItem = [CSLinearLayoutItem layoutItemForView:_loginBtn];
    loginBtnItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    loginBtnItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:loginBtnItem];
    
}

-(void) addLinkView{
    
    _registerBtn = [UIButton baseButtonWithColor:[UIColor noodleYellow] andTitle:@"新用户？"];
    _registerBtn.frame = CGRectMake(0.0, 0.0, 150, 35);
    
    _findBtn = [UIButton baseButtonWithColor:[UIColor noodleYellow] andTitle:@"忘记密码？"];
    _findBtn.frame = CGRectMake( [UIView globalWidth]- 170, 0.0, 150, 35);
    
    UIView *btnItemsView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIView globalWidth] - 20, 35)];
    [btnItemsView addSubview:_registerBtn];
    [btnItemsView addSubview:_findBtn];
    
    CSLinearLayoutItem *btnItems = [CSLinearLayoutItem layoutItemForView:btnItemsView];
    btnItems.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    btnItems.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:btnItems];
    
    
}
@end
