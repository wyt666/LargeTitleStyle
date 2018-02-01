//
//  LRTMenuView.h
//  LargeTitleStyle
//  描述：菜单式大标题
//  Created by linch on 2018/1/31. email:dongyi2403@163.com
//  Copyright © 2018年 linch All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTSViewProtocol.h"

@protocol LTSMenuViewDelegate <NSObject>
//已选中菜单回调
-(void)didSelectMenu:(NSInteger)index;

@end

@interface LTSMenuView : UIView<LTSViewProtocol>

@property (nonatomic, weak) id<LTSMenuViewDelegate> menuDelegate;

- (instancetype)initViewWithFrame:(CGRect)frame andTextArray:(NSArray *)textArray;

@end
