//
//  UIViewController+LTS.m
//  LargeTitleStyle
//
//  Created by linch on 2018/1/31. email:dongyi2403@163.com
//  Copyright © 2018年 linch All rights reserved.
//

#import "UIViewController+LTS.h"
#import <objc/runtime.h>

@implementation UIViewController (LTS)
//对方法名进行置换
+ (BOOL)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Method origMethod = class_getInstanceMethod(self, origSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    
    if (origMethod && newMethod) {
        //先在目标类增加一个新的实现方法(override)，然后将复写的方法替换为原先(的实现(original one)。
        if (class_addMethod(self, origSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
            //如果添加成功(在父类中重写的方法)，再把目标类中的方法替换为旧有的实现
            class_replaceMethod(self, newSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        } else {
            method_exchangeImplementations(origMethod, newMethod);
        }
        return YES;
    }
    return NO;
}

+ (BOOL)swizzleClassMethod:(SEL)origSelector withClassMethod:(SEL)newSelector
{
    Method origMethod = class_getClassMethod(self, origSelector);
    Method newMethod = class_getClassMethod(self, newSelector);
    
    Class class = object_getClass((id)self);
    
    if (origMethod && newMethod) {
        //先在目标类增加一个新的实现方法(override)，然后将复写的方法替换为原先(的实现(original one)。
        if (class_addMethod(class, origSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        {
            //如果添加成功(在父类中重写的方法)，再把目标类中的方法替换为旧有的实现
            class_replaceMethod(class, newSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        } else {
            method_exchangeImplementations(origMethod, newMethod);
        }
        return YES;
    }
    return NO;
}
//交换方法
+ (void)load
{
    if(@available(iOS 11.0, *)){
        //与系统方法viewDidLoad交换为BLSViewDidLoad方法
        [UIViewController swizzleMethod:@selector(viewDidLoad) withMethod:@selector(BLSViewDidLoad)];
    }
}

-(void)BLSViewDidLoad
{
    [self BLSViewDidLoad];
    if (self.navigationController && self.navigationController.navigationBar.prefersLargeTitles == YES) {
        self.title = @"";
    }
    [self setupLTS];
}

//设置高度变化监听
-(void)setupLTS
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigationBarHeightChange:) name:KEY_UINavigationBar_Height_Changed object:nil];
}

//监听UINavigationBar高度变化
-(void)navigationBarHeightChange:(NSNotification *)notification
{
    LTSNavigationBar *notifyNavigationBar = notification.object;
    if ([notifyNavigationBar isKindOfClass:[LTSNavigationBar class]]) {
        [self navigationBarUpdated:notifyNavigationBar];
    }
}
//通知UINavigationBar高度变化
-(void)navigationBarUpdated:(LTSNavigationBar *)notifyNavigationBar
{
    if ([self respondsToSelector:@selector(LTSNavigationChanged:)]) {
        [self LTSNavigationChanged:notifyNavigationBar];
    }
}
@end
