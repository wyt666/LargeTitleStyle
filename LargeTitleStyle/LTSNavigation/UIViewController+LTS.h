//
//  UIViewController+LTS.h
//  LargeTitleStyle
//  视图类别：与大标题更新交互的类别
//  Created by linch on 2018/1/31. email:dongyi2403@163.com
//  Copyright © 2018年 linch All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTSNavigationBar.h"

//导航栏高度发生变化时调用，如果视图控制器需要开启自定义大标题时，实现下面的方法
@protocol LTSNavigationChangedDelegate<NSObject>

@optional
-(void)LTSNavigationChanged:(LTSNavigationBar *)navigationBar;
@end

@interface UIViewController (LTS) <LTSNavigationChangedDelegate>

@end
