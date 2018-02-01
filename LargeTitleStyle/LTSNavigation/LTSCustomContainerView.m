//
//  LTSCustomContainerView.m
//  LargeTitleStyle
//
//  Created by linch on 2018/1/31. email:dongyi2403@163.com
//  Copyright © 2018年 linch All rights reserved.
//

#import "LTSCustomContainerView.h"

@implementation LTSCustomContainerView

-(instancetype)initWithFrame:(CGRect)frame contentView:(UIView<LTSViewProtocol> *)contentView
{
    self = [super initWithFrame:frame];
    self.contentView = contentView;
    [self addSubview:self.contentView];
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView LTSSuperViewUpdated];
}

-(void)updateUIWithNavigationBar:(CGFloat)navigationBarHeight scrollView:(UIScrollView *)scrollView
{
    CGPoint contentOffset = scrollView.contentOffset;
    if (contentOffset.y>44) {
        CGRect frame = self.frame;
        frame.size.height = navigationBarHeight;
        self.frame = frame;
        [self layoutIfNeeded];
    }else
    {
        CGRect frame = self.frame;
        if (self.maxStretchMode) {
            frame.size.height = MIN(navigationBarHeight, 96);
        }else
        {
            frame.size.height = navigationBarHeight;
        }
        self.frame = frame;
        NSLog(@"LTSCustomContainerView=%@",self);
        [self layoutIfNeeded];
    }
}

//防止按钮阻断父视图事件传递
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    // 1.判断下窗口能否接收事件
    if (self.userInteractionEnabled == NO || self.hidden == YES ||  self.alpha <= 0.01) return nil;
    // 2、从后往前遍历子控件数组
    int count = (int)self.subviews.count;
    for (int i = count - 1; i >= 0; i--)     {
        // 获取子控件
        UIView *childView = self.subviews[i];
        // 坐标系的转换,把窗口上的点转换为子控件上的点
        // 把自己控件上的点转换成子控件上的点
        CGPoint childP = [self convertPoint:point toView:childView];
        UIView *fitView = [childView hitTest:childP withEvent:event];
        if (fitView) {
            // 如果能找到最合适的view
            return fitView;
        }
    }
    return nil;
}
@end
