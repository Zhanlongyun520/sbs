//
//  ISSPlainPendingListViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainPendingListViewController.h"
#import "ISSPlainPendingListCell.h"
#import "APIPlainPendListManager.h"
#import "ISSPlainListModel.h"
#import "ISSPlainAddViewController.h"
#import "ISSPlainPendingDetailViewController.h"
#import "IQKeyboardManager.h"
#import "ISSLoginUserModel.h"

@interface ISSPlainPendingListViewController () <APIManagerCallBackDelegate>
{
    NSInteger _currentPage;
    NSMutableArray *_dataArray;
    APIPlainPendListManager *_pendListManager;
}
@end

@implementation ISSPlainPendingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    self.navigationItem.title = @"待审批巡查计划";
    
    _dataArray = @[].mutableCopy;
    
    _pendListManager = [[APIPlainPendListManager alloc] init];
    _pendListManager.delegate = self;
    
    _tableView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_tableView registerClass:[ISSPlainPendingListCell class] forCellReuseIdentifier:@"ISSPlainPendingListCell"];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;
    
    [_tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!_tableView.mj_header.isRefreshing) {
        [self refreshData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    ISSPlainPendingListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSPlainPendingListCell" forIndexPath:indexPath];
    cell.model = [_dataArray objectAtIndex:indexPath.row];
    cell.detailBlock = ^(ISSPlainListModel *model) {
        [weakSelf showDetail:model];
    };
    return cell;
}

- (void)refreshData {
    _currentPage = 0;
    
    _tableView.mj_footer = nil;
    
    [self getData:YES];
}

- (void)getNextPage {
    _currentPage++;
    [self getData:NO];
}

- (void)getData:(BOOL)cleanData {
    _pendListManager.page = _currentPage;
    [_pendListManager loadData];
}

#pragma mark - APIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager {
    NSDictionary *result = [manager fetchDataWithReformer:nil];
    if ([manager isKindOfClass:[APIPlainPendListManager class]]) {
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
        if (_tableView.mj_footer.isRefreshing) {
            [_tableView.mj_footer endRefreshing];
        }
        
        if (_currentPage == 0) {
            [_dataArray removeAllObjects];
        }
        
        NSArray *array = [ISSPlainListModel arrayOfModelsFromDictionaries:[result objectForKey:@"content"] error:nil];
        [_dataArray addObjectsFromArray:array];
        
        NSInteger totolPage = [[result objectForKey:@"totalPages"] integerValue];
        
        if (totolPage - 1 > _currentPage) {
            if (!_tableView.mj_footer) {
                _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getNextPage)];
            }
        } else {
            _tableView.mj_footer = nil;
        }
        
        [_tableView reloadData];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager {
    if ([manager isKindOfClass:[APIPlainPendListManager class]]) {
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
        if (_tableView.mj_footer.isRefreshing) {
            [_tableView.mj_footer endRefreshing];
        }
    }
}

- (void)showDetail:(ISSPlainListModel *)model {
    ISSPlainPendingDetailViewController *viewController = [[ISSPlainPendingDetailViewController alloc] initWithStyle:UITableViewStylePlain];
    viewController.listModel = model;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
