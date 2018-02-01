//
//  LTSCustomContainerView.h
//  LargeTitleStyle
//  描述：自定义大标题界面的容器，可随UIScrollView进行上下滚动而改变它的frame
//  Created by linch on 2018/1/31. email:dongyi2403@163.com
//  Copyright © 2018年 linch All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTSViewProtocol.h"

@interface LTSCustomContainerView : UIView

@property (nonatomic,strong) UIView<LTSViewProtocol> * contentView;
@property (nonatomic,assign) BOOL maxStretchMode;//设置最大拉伸模式后，大标题显示最多只能拉伸至96像素（默认大标题的NavigatinBar的高度）,相应的UIScrollView也需要限制最大偏移量

-(instancetype)initWithFrame:(CGRect)frame contentView:(UIView<LTSViewProtocol> *)contentView;
//随导航栏变化而更新
-(void)updateUIWithNavigationBar:(CGFloat)navigationBarHeight scrollView:(UIScrollView *)scrollView;
@end
