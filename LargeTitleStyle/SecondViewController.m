//
//  SecondViewController.m
//  LargeTitleStyle
//
//  Created by linch on 2018/1/31. email:dongyi2403@163.com
//  Copyright © 2018年 linch All rights reserved.
//

#import "SecondViewController.h"
#import "LTSCustomContainerView.h"
#import "LTSMenuView.h"

@interface SecondViewController ()
@property(nonatomic,strong) LTSCustomContainerView *headerView;
@end

@implementation SecondViewController

-(LTSCustomContainerView *)headerView
{
    if(!_headerView)
    {
        CGRect frame = self.navigationController.navigationBar.bounds;
        LTSMenuView *titleView = [[LTSMenuView alloc] initViewWithFrame:frame andTextArray:@[@"时刻", @"人物", @"地点", @"动画影集"]];
        _headerView = [[LTSCustomContainerView alloc] initWithFrame:frame contentView:titleView];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    if(@available(iOS 11.0, *)){
        [self.navigationController.navigationBar setPrefersLargeTitles:YES];
        [self.navigationController.navigationBar addSubview:self.headerView];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
