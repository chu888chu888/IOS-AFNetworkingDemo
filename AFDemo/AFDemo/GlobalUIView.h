//
//  GlobalUIView.h
//  weChat
//
//  Created by apple on 14-9-18.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLinearLayoutView.h"
#import "UIView+Base.h"
#import "UIColor+Base.h"

@interface GlobalUIView : UIView
@property (nonatomic, strong) CSLinearLayoutView *linearLayoutView;
@property (nonatomic, strong) CSLinearLayoutItem *linearLayoutItem;

//为方便书写，把在流式布局中加视图的方法封装起来
-(void)addView:(UIView*)theView withPadding:(CSLinearLayoutItemPadding)padding;

@end
