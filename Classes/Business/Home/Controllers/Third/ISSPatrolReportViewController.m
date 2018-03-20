//
//  ISSPatrolReportViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/25.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPatrolReportViewController.h"
#import "ISSPatrolReportCell.h"
#import "ISSReportReadViewController.h"
#import "ISSReportReplyViewController.h"
#import "ISSReportVisitViewController.h"
#import "ISSReportAddViewController.h"

@interface ISSPatrolReportViewController ()
{
    NSInteger _currentPage;
}
@end

@implementation ISSPatrolReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn setImage:[UIImage imageNamed:@"addreport"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addReport) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    _dataArray = @[].mutableCopy;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[ISSPatrolReportCell class] forCellReuseIdentifier:@"ISSPatrolReportCell"];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;
    [_tableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!_tableView.mj_header.isRefreshing) {
        [self refreshData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    ISSPatrolReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSPatrolReportCell" forIndexPath:indexPath];
    cell.model = [_dataArray objectAtIndex:indexPath.row];
    cell.showDetailBlock = ^(NSInteger tag) {
        [weakSelf showDetail:tag index:indexPath.row];
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
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
        if (_tableView.mj_footer.isRefreshing) {
            [_tableView.mj_footer endRefreshing];
        }
        
        if (cleanData) {
            [_dataArray removeAllObjects];
        }
        
        if (success) {
            NSArray *array = [ISSReportDetailModel arrayOfModelsFromDictionaries:[result objectForKey:@"content"] error:nil];
            [_dataArray addObjectsFromArray:array];
            
            NSInteger totolPage = [[result objectForKey:@"totalPages"] integerValue];
            
            if (totolPage - 1 > _currentPage) {
                if (!_tableView.mj_footer) {
                    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getNextPage)];
                }
            } else {
                _tableView.mj_footer = nil;
            }
        }
        
        [_tableView reloadData];
    }];
    [request getPatrolReportList:_currentPage dep:_limitDep];
}

- (void)addReport {
    ISSReportAddViewController *viewController = [[ISSReportAddViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)showDetail:(NSInteger)tag index:(NSInteger)index {
    ISSReportDetailModel *model = [_dataArray objectAtIndex:index];
    switch (tag) {
        case 0: {
            ISSReportReadViewController *viewController = [[ISSReportReadViewController alloc] init];
            viewController.thirdListModel = model;
            [self.navigationController pushViewController:viewController animated:YES];
            
            break;
        }
            
        case 1: {
            ISSReportReplyViewController *viewController = [[ISSReportReplyViewController alloc] init];
            viewController.thirdListModel = model;
            [self.navigationController pushViewController:viewController animated:YES];
            
            break;
        }
            
        case 2: {
            ISSReportVisitViewController *viewController = [[ISSReportVisitViewController alloc] init];
            viewController.thirdListModel = model;
            [self.navigationController pushViewController:viewController animated:YES];
            
            break;
        }
            
        default:
            break;
    }
}

@end
