//
//  LTSNavigationBar.m
//  LargeTitleStyle
//
//  Created by linch on 2018/1/31. email:dongyi2403@163.com
//  Copyright © 2018年 linch All rights reserved.
//

#import "LTSNavigationBar.h"

@implementation LTSNavigationBar

-(void)layoutSubviews
{
    [super layoutSubviews];
    [[NSNotificationCenter defaultCenter] postNotificationName:KEY_UINavigationBar_Height_Changed object:self userInfo:nil];
}

@end
