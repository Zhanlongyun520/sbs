//
//  ISSThirdListViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/30.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdListViewController.h"
#import "ISSThirdListTableViewCell.h"

#import "APIThirdListManager.h"
#import "ISSThirdListReformer.h"

#import "APIThirdReportManager.h"

#import "ISSAddThirdViewController.h"
#import "ISSThirdDetailViewController.h"
#import "ISSThirdReplyViewController.h"
#import "ISSThirdVisitViewController.h"

#import "ISSReportReadViewController.h"
#import "ISSReportReplyViewController.h"
#import "ISSReportVisitViewController.h"
#import "ISSReportAddViewController.h"

@interface ISSThirdListViewController ()<UITableViewDelegate, UITableViewDataSource,APIManagerCallBackDelegate>
{
    BOOL      isHeaderRefresh;
    BOOL      isFooterRefresh;
}

@property(nonatomic ,strong) ISSRefreshTableView         * mainTableView;
@property(nonatomic ,strong) NSMutableArray              * thirdListArray;

@property(nonatomic ,strong) APIThirdListManager         * thirdListManager;

@property(nonatomic ,strong) APIThirdReportManager       * thirdReportManager;

@end

@implementation ISSThirdListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"巡查报告";
    self.isHiddenTabBar = YES;
    [self.thirdListManager loadData];
    [self showLoadingView];
//    [self.thirdDetailManager loadData];
//    [self.thirdReportManager loadData];
    [self navigationSetUp];
    [self.view addSubview:self.mainTableView];
}

- (void)addButton
{
    ISSReportAddViewController * addThirdVC = [[ISSReportAddViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:addThirdVC animated:YES];
}

- (void)navigationSetUp
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 19, 19);
    [rightBtn setImage:[UIImage imageNamed:@"addreport"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    if([manager isKindOfClass:[APIThirdListManager class]])
    {
        NSDictionary *dataDic = [manager fetchDataWithReformer:[[ISSThirdListReformer alloc]init]];
        self.thirdListArray = dataDic[@"thirdListArray"];
        NSLog(@"%@",dataDic);
        [self hiddenLoadingView];
        [self.mainTableView reloadData];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    ALERT(manager.errorMessage);
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 152;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.thirdListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ISSThirdListTableViewCell * cell = [[ISSThirdListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoList"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell conFigDataThirdListModel:self.thirdListArray[indexPath.row]];
    cell.detailButton.tag = 1232000 + indexPath.row;
    cell.replyButton.tag = 1233000 + indexPath.row;
    cell.visitButton.tag = 1234000 + indexPath.row;

    [cell.detailButton addTarget:self action:@selector(detailButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.replyButton addTarget:self action:@selector(replyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.visitButton addTarget:self action:@selector(visitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - Button Action
- (void)detailButtonAction:(UIButton *)button
{
    ISSThirdListModel * model = self.thirdListArray[button.tag - 1232000];
    ISSReportReadViewController * thirdDetailVC = [[ISSReportReadViewController alloc]init];
    thirdDetailVC.thirdListModel = model;
    [self.navigationController pushViewController:thirdDetailVC animated:YES];
}

- (void)replyButtonAction:(UIButton *)button
{
    ISSThirdListModel * model = self.thirdListArray[button.tag - 1233000];
    ISSReportReplyViewController * thirdReplyVC = [[ISSReportReplyViewController alloc]init];
    thirdReplyVC.thirdListModel = model;
    [self.navigationController pushViewController:thirdReplyVC animated:YES];
}

- (void)visitButtonAction:(UIButton *)button
{
    ISSThirdListModel * model = self.thirdListArray[button.tag - 1234000];
    ISSReportVisitViewController * thirdVisitVC = [[ISSReportVisitViewController alloc]init];
    thirdVisitVC.thirdListModel = model;
    [self.navigationController pushViewController:thirdVisitVC animated:YES];
}

#pragma mark - Setter && Getter

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[ISSRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = ISSColorViewBg;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}


- (APIThirdListManager *)thirdListManager
{
    if (nil == _thirdListManager) {
        _thirdListManager = [[APIThirdListManager alloc] init];
        _thirdListManager.delegate = self;
    }
    return _thirdListManager;
}

- (APIThirdReportManager *)thirdReportManager
{
    if (nil == _thirdReportManager) {
        _thirdReportManager = [[APIThirdReportManager alloc] init];
        _thirdReportManager.delegate = self;
    }
    return _thirdReportManager;
}

@end
