//
//  ISSEnvironmentHistoryViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSEnvironmentHistoryViewController.h"
#import "ISSERealTimeTopTableViewCell.h"
#import "ISSESpaceTableViewCell.h"
#import "ISSEHistoryTableViewCell.h"

#import "ISSEnvironmentListReformer.h"
#import "NetworkRequest.h"
#import "ActionSheetStringPicker.h"
#import <MJRefresh/MJRefresh.h>
#import "ISSEnvironmentRealTimeViewController.h"

@interface ISSEnvironmentHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic , strong) ISSRefreshTableView           * tableView;
@property(nonatomic , strong) NSMutableArray                * environmentListArray;
@property(nonatomic , strong) NSMutableDictionary *btnTitlesDict;

@property(nonatomic , assign) NSInteger page;

@end

@implementation ISSEnvironmentHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"历史数据";
    self.isHiddenTabBar = YES;
    
    [self.view addSubview:self.mainTableView];
    
    _btnTitlesDict = @{@"btnTitles":@[@"5分钟", @"1小时", @"24小时", @"1个月"],
                       @"selectedIndex":@(0),
                       }.mutableCopy;
    

    [self getMoreDataWithRefresh:NO];
    _environmentListArray = @[].mutableCopy;
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //页码
        self.page++;
        
        [self getMoreDataWithRefresh:NO];
    }];
    
}

- (void)getMoreDataWithRefresh:(BOOL)refresh {
    if (refresh) {
        self.page = 0;
        [_environmentListArray removeAllObjects];
    }
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            NSArray *datas = (NSArray *)result[@"content"];
            
            [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ISSEnvironmentListModel *model = [[ISSEnvironmentListModel alloc] initWithDictionary:obj ?: @{}];
                model.installTime = self.environmentListModel.installTime;
                model.deviceCoding = self.environmentListModel.deviceCoding;
                model.latitude = self.environmentListModel.latitude;
                model.longitude = self.environmentListModel.longitude;
                [_environmentListArray addObject:model];
            }];
            
            self.tableView.mj_footer.hidden = (datas.count < 20);
        }
        
        [self.tableView.mj_footer endRefreshing];
        [self.mainTableView reloadData];
    }];
    
    NSInteger type = [self.btnTitlesDict[@"selectedIndex"] integerValue];
    //数据类型：0代表实时数据，1代表5分钟查询，2代表小时查询，3代表天查询，4代表月查询
    [request getDeviceHistoryData:self.environmentListModel.deviceId type:@(type+1) page:@(self.page) deviceId:_environmentListModel.deviceId];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 108;
    }else if (indexPath.row == 1){
        return 48;
    }else{
        return 68;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.environmentListArray.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ISSERealTimeTopTableViewCell * cell = [[ISSERealTimeTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell conFigDataEnvironmentModel:self.environmentListModel isComeFromHistory:NO];
        return cell;
    }else if (indexPath.row == 1){
        ISSESpaceTableViewCell * cell = [[ISSESpaceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *btnTitles = self.btnTitlesDict[@"btnTitles"];
        NSInteger currentIndex = [self.btnTitlesDict[@"selectedIndex"] integerValue];
        
        [cell conFigDataTitle:@"查询间隔" ButtonHidden:NO ButtonTitle:btnTitles[currentIndex]];
        [cell.choiceButton addTarget:self action:@selector(choiceButtonActionSection) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else{
        ISSEHistoryTableViewCell * cell = [[ISSEHistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell conFigDataEnvironmentModel:self.environmentListArray[indexPath.row-2]];
        return cell;
    }
}

#pragma mark - Setter && Getter

-(UITableView *)mainTableView
{
    if (!_tableView) {
        _tableView = [[ISSRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = ISSColorViewBg;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)choiceButtonActionSection {
    NSArray *btnTitles = self.btnTitlesDict[@"btnTitles"];
    NSInteger currentIndex = [self.btnTitlesDict[@"selectedIndex"] integerValue];
    
    __weak typeof(self) weakSelf = self;
    [ActionSheetStringPicker showPickerWithTitle:@"请选择"
                                            rows:btnTitles
                                initialSelection:currentIndex
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           [weakSelf alertBtnSelectedAction:selectedIndex];
                                       } cancelBlock:nil
                                          origin:self.view];
}

- (void)alertBtnSelectedAction:(NSInteger)index {
    self.btnTitlesDict[@"selectedIndex"] = @(index);
    
    [self getMoreDataWithRefresh:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= 2) {
        ISSEnvironmentRealTimeViewController *vc = [[ISSEnvironmentRealTimeViewController alloc] init];
        ISSEnvironmentListModel *model = self.environmentListArray[indexPath.row-2];
        vc.environmentListModel = model;
        vc.isComeFromHistory = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
