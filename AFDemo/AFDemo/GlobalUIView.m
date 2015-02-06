//
//  GlobalUIView.m
//  weChat
//
//  Created by apple on 14-9-18.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "GlobalUIView.h"

@implementation GlobalUIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addLinearLayoutView];
    }
    return self;
}

- (void)addLinearLayoutView{
    self.linearLayoutView = [[CSLinearLayoutView alloc] initWithFrame:self.bounds];
    _linearLayoutView.orientation = CSLinearLayoutViewOrientationVertical;
    _linearLayoutView.scrollEnabled = YES;
    _linearLayoutView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _linearLayoutView.backgroundColor = [UIColor noodleLightGray];
    
    [self addSubview:_linearLayoutView];
}

-(void)addView:(UIView*)theView withPadding:(CSLinearLayoutItemPadding)padding{
    self.linearLayoutItem = [CSLinearLayoutItem layoutItemForView:theView];
    self.linearLayoutItem.padding = padding;
    self.linearLayoutItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:self.linearLayoutItem];
}


@end
