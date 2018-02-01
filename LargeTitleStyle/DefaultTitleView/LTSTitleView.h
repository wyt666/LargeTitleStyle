//
//  LTSTitleView.h
//  LargeTitleStyle
//  描述：简单的大标题，类似系统自带方式
//  Created by linch on 2018/1/31. email:dongyi2403@163.com
//  Copyright © 2018年 linch All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTSViewProtocol.h"

@interface LTSTitleView : UIView<LTSViewProtocol>
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)text;
@end
