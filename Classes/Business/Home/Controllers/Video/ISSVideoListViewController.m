//
//  ISSVideoListViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/20.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSVideoListViewController.h"
#import "ISSVideoListTableViewCell.h"

#import "ISSVideoListReformer.h"
#import "APIVideoListManager.h"

#import "ISSVideoListSearchViewController.h"
#import "ISSSelectMapViewController.h"
#import "ISSRealTimeViewController.h"
#import "ISSHistoryViewController.h"
#import "ISSVideoPhotoViewController.h"
#import "ISSVideoPhotoManager.h"
#import "ISSMapViewController.h"

@interface ISSVideoListViewController ()<UITableViewDelegate, UITableViewDataSource,APIManagerCallBackDelegate>
{
    BOOL      isHeaderRefresh;
    BOOL      isFooterRefresh;
}

@property(nonatomic , strong) ISSRefreshTableView           * mainTableView;
@property(nonatomic , strong) APIVideoListManager           * videoListManager;
@property(nonatomic , strong) NSMutableArray                * videoListArray;


@end

@implementation ISSVideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视屏监控";
    self.isHiddenTabBar = YES;
    
    [self.view addSubview:self.mainTableView];
    [self.videoListManager loadData];

//    [self navigationSetUp];
}

- (void)searchButton
{
    ISSVideoListSearchViewController * videoListSearchVC = [[ISSVideoListSearchViewController alloc]init];
    [self.navigationController pushViewController:videoListSearchVC animated:YES];
}

- (void)navigationSetUp
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 19, 19);
    [rightBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(searchButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}



#pragma mark - ButtonAction
- (void)mapButtonAction:(UIButton *)button
{
    ISSVideoModel *model = self.videoListArray[button.tag - 123000];
    
    ISSMapViewController *viewController = [[ISSMapViewController alloc]init];
    viewController.selectedDeviceId = model.deviceId;
    viewController.showType = 1;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)realTimeButtonAction:(UIButton *)button
{
    ISSVideoModel * model =  self.videoListArray[button.tag];
//    if ([model.deviceStatus isEqualToString:@"1"]) {
//        [self.view makeToast:@"设备不在线"];
//        return;
//    } else if ([model.deviceStatus isEqualToString:@"2"]) {
//        [self.view makeToast:@"设备故障"];
//        return;
//    }
    
    ISSRealTimeViewController * realTimeVC = [[ISSRealTimeViewController alloc]init];
    realTimeVC.listModel = model;
    [self.navigationController pushViewController:realTimeVC animated:YES];
}

- (void)historyButtonAction:(UIButton *)button
{
    ISSVideoModel * model =  self.videoListArray[button.tag];
    ISSHistoryViewController * historyVC = [[ISSHistoryViewController alloc]init];
    historyVC.listModel = model;
    [self.navigationController pushViewController:historyVC animated:YES];
}

- (void)ssButtonAction:(UIButton *)button
{
    ISSVideoModel *model = self.videoListArray[button.tag];
    NSArray *array = [ISSVideoPhotoManager getPhotos:model.deviceCoding];
    if (array.count == 0) {
        [self.view makeToast:@"此设备没有视频抓拍记录"];
        return;
    }
    
    ISSVideoPhotoViewController *viewController = [[ISSVideoPhotoViewController alloc] init];
    viewController.code = model.deviceCoding;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - RequestData
- (void)requestData{
    
    if (self.videoListArray.count > 0) {
        [self.videoListArray removeAllObjects];
    }
    self.videoListManager.shouldCleanData = YES;
    self.videoListManager.page = @"0";
    [self.videoListManager loadData];
}

#pragma mark - WJRefreshTableView Delegate
- (void)startHeadRefreshToDo:(ISSRefreshTableView *)tableView
{
    if (!isHeaderRefresh && !isFooterRefresh) {
        isHeaderRefresh = YES;
        self.videoListManager.shouldCleanData = YES;
        [self requestData];
    }
    
}

- (void)startFootRefreshToDo:(ISSRefreshTableView *)tableView
{
    if (!isFooterRefresh && !isHeaderRefresh) {
        isFooterRefresh = YES;
        self.videoListManager.shouldCleanData = NO;
        [self.videoListManager loadData];
    }
}

- (void)endGetData:(BOOL)needReloadData{
    
    if (isHeaderRefresh) {
        isHeaderRefresh = NO;
        [self.mainTableView endHeadRefresh];
    }
    
    if (isFooterRefresh){
        isFooterRefresh = NO;
        [self.mainTableView endFootFefresh];
    }
    
    if (needReloadData) {
        [self.mainTableView reloadData];
    }
}

- (void)refreshFooterStatus:(BOOL)status{

    if (status) {
        [self.mainTableView hiddenFooter];
    } else {
        [self.mainTableView showFooter];
    }
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if([manager isKindOfClass:[APIVideoListManager class]])
    {
        NSDictionary * dic = [manager fetchDataWithReformer:[[ISSVideoListReformer alloc]init]];

        if (self.videoListArray.count == 0) {
            self.videoListArray = dic[@"videoArray"];
        } else {
            if ([self.videoListManager.page integerValue] < [dic[@"totalPages"] integerValue] - 1) {
                [self.videoListArray addObjectsFromArray: dic[@"videoArray"]];
            }
        }

        [self endGetData:YES];
        [self refreshFooterStatus:manager.hadGotAllData];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    if (manager.errorType == APIManagerErrorTypeNoData) {
        [self refreshFooterStatus:YES];
        
        if (isHeaderRefresh) {
            if (self.videoListArray.count > 0) {
                [self.videoListArray removeAllObjects];
            }
            [self endGetData:YES];
            return;
        }
        [self endGetData:NO];
    } else {
        [self refreshFooterStatus:self.videoListManager.hadGotAllData];
        if (isHeaderRefresh) {
            if (self.videoListArray.count > 0) {
                [self.videoListArray removeAllObjects];
            }
            [self endGetData:YES];
            return;
        }
        [self endGetData:NO];
    }
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 152;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videoListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ISSVideoListTableViewCell * cell = [[ISSVideoListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoList"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell conFigDataVideoModel:self.videoListArray[indexPath.row]];
    cell.mapButton.tag = 123000 + indexPath.row;
    [cell.mapButton addTarget:self action:@selector(mapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.realTimeButton.tag = indexPath.row;
    [cell.realTimeButton addTarget:self action:@selector(realTimeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.historyButton.tag = indexPath.row;
    [cell.historyButton addTarget:self action:@selector(historyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.ssButton addTarget:self action:@selector(ssButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.ssButton.tag = indexPath.row;
    return cell;
}

#pragma mark - Setter && Getter

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[ISSRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain refreshNow:NO refreshViewType:ISSRefreshViewTypeBoth];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = ISSColorViewBg;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

- (APIVideoListManager *)videoListManager
{
    if (nil == _videoListManager) {
        _videoListManager = [[APIVideoListManager alloc] init];
        _videoListManager.delegate = self;
        _videoListManager.deviceType = @"1"; //视屏设备
    }
    return _videoListManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
