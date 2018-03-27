//
//  ISSEnvironmentListViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/20.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSEnvironmentListViewController.h"
#import "ISSEnvironmentListTableViewCell.h"

#import "ISSEnvironmentListReformer.h"
#import "APIEHistoryListManager.h"
#import "ISSEnvironmentListModel.h"

#import "ISSEnvironmentRealTimeViewController.h"
#import "ISSEnvironmentHistoryViewController.h"
#import "ISSMapViewController.h"
#import "NetworkRequest.h"

@interface ISSEnvironmentListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic , strong) ISSRefreshTableView           * mainTableView;

@property(nonatomic , strong) NSMutableArray                * environmentListArray;

@end

@implementation ISSEnvironmentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设备列表";
    self.isHiddenTabBar = YES;
    
    [self.view addSubview:self.mainTableView];
    
    [self getData];
}

- (void)getData {
    _environmentListArray = @[].mutableCopy;
    
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            NSArray *datas = (NSArray *)result[@"content"];
            
            [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ISSEnvironmentListModel *model = [[ISSEnvironmentListModel alloc] initWithDictionary:obj ?: @{}];
                [_environmentListArray addObject:model];
            }];
        }
        [self.mainTableView reloadData];
    }];
    [request getMapEqiList];
}

#pragma mark - navigationSearch

- (void)searchButton
{
    
}

- (void)navigationSetUp
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 19, 19);
    [rightBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(searchButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

#pragma mark - Button Action
- (void)realTimeButtonAction:(UIButton *)button
{
    ISSEnvironmentListModel * environmentListModel = self.environmentListArray[button.tag - 123000];
    ISSEnvironmentRealTimeViewController * realTimeVC = [[ISSEnvironmentRealTimeViewController alloc]init];
    realTimeVC.environmentListModel = environmentListModel;
    [self.navigationController pushViewController:realTimeVC animated:YES];
}

- (void)historyButtonAction:(UIButton *)button
{
    ISSEnvironmentListModel * environmentListModel = self.environmentListArray[button.tag - 123000];
    ISSEnvironmentHistoryViewController * historyVC = [[ISSEnvironmentHistoryViewController alloc]init];
    historyVC.environmentListModel = environmentListModel;
    [self.navigationController pushViewController:historyVC animated:YES];
}

- (void)mapButtonAction:(UIButton *)button {
    ISSEnvironmentListModel * environmentListModel = self.environmentListArray[button.tag - 123000];
    ISSMapViewController *vc = [[ISSMapViewController alloc] init];
    vc.selectedDeviceId = environmentListModel.deviceId;
    vc.showType = 2;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if([manager isKindOfClass:[APIEHistoryListManager class]])
    {
        NSDictionary * dic = [manager fetchDataWithReformer:[[ISSEnvironmentListReformer alloc]init]];
        self.environmentListArray = dic[@"environmentArray"];
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
    return 196;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.environmentListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ISSEnvironmentListModel *model = self.environmentListArray[indexPath.row];
    
    ISSEnvironmentListTableViewCell * cell = [[ISSEnvironmentListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentList"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    [cell.mapButton addTarget:self action:@selector(mapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.realTimeButton.tag = 123000 + indexPath.row;
    cell.historyButton.tag = 123000 + indexPath.row;
    cell.mapButton.tag = 123000 + indexPath.row;
    [cell.realTimeButton addTarget:self action:@selector(realTimeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.historyButton addTarget:self action:@selector(historyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.mapButton addTarget:self action:@selector(mapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell conFigDataEnvironmentListModel:model];
    
    UIImage *img = [[UIImage imageNamed:@"time"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [cell.realTimeButton setImage:img forState:UIControlStateNormal];
    if ([model.deviceStatus integerValue] == 0) {
        cell.realTimeButton.enabled = YES;
        cell.realTimeButton.imageView.tintColor = [UIColor colorWithRed:0.24 green:0.39 blue:0.87 alpha:1.00];
    } else {
        cell.realTimeButton.enabled = NO;
        cell.realTimeButton.imageView.tintColor = [UIColor lightGrayColor];
    }
    [cell.realTimeButton setTitleColor:cell.realTimeButton.imageView.tintColor forState:UIControlStateNormal];
    
    return cell;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
