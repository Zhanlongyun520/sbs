//
//  ISSCarListViewController.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSCarListViewController.h"
#import "ISSCarListTableViewCell.h"
#import "NetworkRequest.h"

#import "ISSCarListModel.h"
#import "ISSEvidenceViewController.h"
#import "ISSCarTrackViewController.h"

@interface ISSCarListViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) ISSRefreshTableView * mainTableView;
@property(nonatomic, strong) NSArray *dataSource;

@end

@implementation ISSCarListViewController

static NSString * const tableReuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"渣土车车辆列表";
    self.isHiddenTabBar = YES;
    
    [self.view addSubview:self.mainTableView];
    
    //注册tableView控件
    [self.mainTableView registerClass:[ISSCarListTableViewCell class] forCellReuseIdentifier:tableReuseIdentifier];
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [self getAllDataSource];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mainTableView.mj_header = header;
    
    [self.mainTableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getAllDataSource {
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        
        NSArray *list = result[@"content"];
        
        _dataSource = [ISSCarListModel arrayOfModelsFromDictionaries:list error:nil];
        
        [self.mainTableView reloadData];
        
        if (self.mainTableView.mj_header.isRefreshing) {
            [self.mainTableView.mj_header endRefreshing];
        }
    }];
    [request getCarList:@""];
}


#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 146;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ISSCarListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableReuseIdentifier forIndexPath:indexPath];
    
    ISSCarListModel *model = self.dataSource[indexPath.row];
    [cell conFigDataCarListModel:model];
    
    //按钮事件
    cell.btnAction = ^(ISSCarListTableViewCell *cellIn, UIButton *btn) {
        //拍照取证
        if ([btn isEqual:cellIn.photoButton]) {
            ISSEvidenceViewController *vc = [[ISSEvidenceViewController alloc] init];
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        //历史轨迹
        if ([btn isEqual:cellIn.historyButton]) {
            ISSCarTrackViewController *vc = [[ISSCarTrackViewController alloc] init];
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    
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
        
        _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    }
    return _mainTableView;
}

@end

