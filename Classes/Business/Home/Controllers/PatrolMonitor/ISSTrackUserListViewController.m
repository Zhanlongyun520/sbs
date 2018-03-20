//
//  ISSTrackUserListViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTrackUserListViewController.h"
#import "ISSTrackPopupTitleCell.h"
#import "ISSTrackPopupCell.h"
#import "ISSMonitorListModel.h"
#import "ISSTaskDetailViewController.h"

@interface ISSTrackUserListViewController ()

@end

@implementation ISSTrackUserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"巡查人员列表";
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 15)];
    [_tableView registerClass:[ISSTrackPopupTitleCell class] forCellReuseIdentifier:@"ISSTrackPopupTitleCell"];
    [_tableView registerClass:[ISSTrackPopupCell class] forCellReuseIdentifier:@"ISSTrackPopupCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([view isMemberOfClass:[UITableViewHeaderFooterView class]]) {
        ((UITableViewHeaderFooterView *)view).contentView.backgroundColor = self.view.backgroundColor;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ISSMonitorListModel *model = [_dataList objectAtIndex:section];
    return 1 + model.patrolTaskArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ISSMonitorListModel *model = [_dataList objectAtIndex:indexPath.section];
    
    UITableViewCell *theCell;
    if (indexPath.row == 0) {
        ISSTrackPopupTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSTrackPopupTitleCell" forIndexPath:indexPath];
        cell.model = model;
        theCell = cell;
    } else {
        ISSTrackPopupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSTrackPopupCell" forIndexPath:indexPath];
        cell.model = [model.patrolTaskArray objectAtIndex:indexPath.row - 1];
        theCell = cell;
    }
    return theCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ISSMonitorListModel *model = [_dataList objectAtIndex:indexPath.section];
    if (indexPath.row > 0) {
        ISSTaskListModel *m = [model.patrolTaskArray objectAtIndex:indexPath.row - 1];
        
        ISSTaskDetailViewController *viewController = [[ISSTaskDetailViewController alloc] init];
        viewController.taskId = m.taskId;
        viewController.taskName = m.taskName;
        viewController.readonly = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
