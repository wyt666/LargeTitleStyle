//
//  MenuTableViewController.m
//  LargeTitleStyle
//
//  Created by linch on 2018/1/31. email:dongyi2403@163.com
//  Copyright © 2018年 linch All rights reserved.
//

#import "MenuTableViewController.h"
#import "UIViewController+LTS.h"
#import "LTSCustomContainerView.h"
#import "LTSMenuView.h"

@interface MenuTableViewController ()
@property(nonatomic,strong) LTSCustomContainerView *headerView;
@end


@implementation MenuTableViewController

-(LTSCustomContainerView *)headerView
{
    if(!_headerView)
    {
        CGRect frame = self.navigationController.navigationBar.bounds;
        LTSMenuView *titleView = [[LTSMenuView alloc] initViewWithFrame:frame andTextArray:@[@"时刻", @"人物", @"地点", @"动画影集"]];
        _headerView = [[LTSCustomContainerView alloc] initWithFrame:frame contentView:titleView];
        [_headerView setMaxStretchMode:NO];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"";
    self.tabBarItem.title = @"菜单大标题";
     if(@available(iOS 11.0, *)){
         [self.navigationController.navigationBar setPrefersLargeTitles:YES];
     }
    [self.navigationController.navigationBar addSubview:self.headerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark LTSNavigationChangedDelegate 
-(void)LTSNavigationChanged:(UINavigationBar *)navigationBar
{
    [self.headerView updateUIWithNavigationBar:navigationBar.frame.size.height scrollView:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = @"菜单行";
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
