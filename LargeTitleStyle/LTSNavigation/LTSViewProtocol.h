//
//  LTSViewProtocol.h
//  LargeTitleStyle
//
//  Created by linch on 2018/1/31. email:dongyi2403@163.com
//  Copyright © 2018年 linch All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LTSViewProtocol<NSObject>
//父实体界面发生变化时调用
-(void)LTSSuperViewUpdated;

@end
