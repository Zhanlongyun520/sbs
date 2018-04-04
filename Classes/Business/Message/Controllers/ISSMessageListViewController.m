//
//  ISSMessageListViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/27.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMessageListViewController.h"
#import "ISSMessageListTableViewCell.h"
#import "ISSMessageModel.h"
#import "Masonry.h"
#import "ISSMapViewController.h"
#import "ISSVideoModel.h"
@interface ISSMessageListViewController ()
{
    NSInteger _currentPage;
    NSMutableArray *_dataArray;
}
@end

@implementation ISSMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHiddenTabBar = YES;
    
    _dataArray = @[].mutableCopy;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[ISSMessageListTableViewCell class] forCellReuseIdentifier:@"ISSMessageListTableViewCell"];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;
    [_tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ISSMessageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSMessageListTableViewCell" forIndexPath:indexPath];
    [cell conFigDataMessageModel:[_dataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ISSMessageModel *model = [_dataArray objectAtIndex:indexPath.row];

    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {

        
    
    }];
     [request setMessageRead:model.infoId];
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
            NSArray *array = [ISSMessageModel arrayOfModelsFromDictionaries:[result objectForKey:@"content"] error:nil];
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
    [request getMessageList:_messageType page:_currentPage];
}

@end
