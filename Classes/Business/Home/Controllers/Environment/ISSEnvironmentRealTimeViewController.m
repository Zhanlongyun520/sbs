//
//  ISSEnvironmentRealTimeViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSEnvironmentRealTimeViewController.h"
#import "ISSERealTimeTopTableViewCell.h"
#import "ISSESpaceTableViewCell.h"
#import "ISSEContaminantTableViewCell.h"
#import "ISSELineChartTableViewCell.h"

#import "NetworkRequest.h"
#import "ActionSheetStringPicker.h"
#import "ISSMapViewController.h"

@interface ISSEnvironmentRealTimeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic , strong) ISSRefreshTableView           * mainTableView;
@property(nonatomic , strong) NSMutableDictionary *nearestDict;

@end

@implementation ISSEnvironmentRealTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.isHiddenTabBar = YES;
    
    self.navigationItem.title = self.isComeFromHistory ? @"历史数据详情" : @"实时数据";
    
    [self.view addSubview:self.mainTableView];
    
    [self getData];
}

- (void)getData {
    NSMutableArray *nearestArray = @[].mutableCopy;
    
    _nearestDict = @{@"btnTitles":@[@"PM2.5", @"PM10", @"CO2"],
                     @"selectedIndex":@(0),
                     @"dataSource":nearestArray
                     }.mutableCopy;

    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            NSArray *datas = (NSArray *)result;

            [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ISSEnvironmentListModel *model = [[ISSEnvironmentListModel alloc] initWithDictionary:obj ?: @{}];
                [nearestArray addObject:model];
            }];
        }
        [self.mainTableView reloadData];
    }];
    [request getEnvironmentNearestData:@([self.environmentListModel.deviceId integerValue])];
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 108;
    }else if (indexPath.row == 1){
        return 48;
    }else if (indexPath.row == 2){
        return 80;
    }else if (indexPath.row == 3){
        return 48;
    }else if (indexPath.row == 4){
        return 80;
    }else if (indexPath.row == 5){
        return 48;
    }else{
        return 210;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        ISSERealTimeTopTableViewCell * cell = [[ISSERealTimeTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell conFigDataEnvironmentModel:self.environmentListModel isComeFromHistory:self.isComeFromHistory];
        return cell;
    }else if (indexPath.row == 1){
        ISSESpaceTableViewCell * cell = [[ISSESpaceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell conFigDataTitle:@"污染物数据" ButtonHidden:YES ButtonTitle:nil];
        return cell;
    }else if (indexPath.row == 2){
        ISSEContaminantTableViewCell * cell = [[ISSEContaminantTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell conFigDataEnvironmentModel:self.environmentListModel IsContamint:YES];
        return cell;
    }else if (indexPath.row == 3){
        ISSESpaceTableViewCell * cell = [[ISSESpaceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell conFigDataTitle:@"自然状态数据" ButtonHidden:YES ButtonTitle:nil];
        return cell;
    }else if (indexPath.row == 4){
        ISSEContaminantTableViewCell * cell = [[ISSEContaminantTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell conFigDataEnvironmentModel:self.environmentListModel IsContamint:NO];
        return cell;
    }else if (indexPath.row == 5){
        ISSESpaceTableViewCell * cell = [[ISSESpaceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell conFigDataTitle:@"AQI24小时数据" ButtonHidden:NO ButtonTitle:@"AQI"];
        
        NSArray *btnTitles = self.nearestDict[@"btnTitles"];
        NSInteger currentIndex = [self.nearestDict[@"selectedIndex"] integerValue];
        [cell.choiceButton setTitle:btnTitles[currentIndex] forState:UIControlStateNormal];
        [cell.choiceButton addTarget:self action:@selector(choiceButtonActionSection) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        ISSELineChartTableViewCell * cell = [[ISSELineChartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *nearestArray = self.nearestDict[@"dataSource"];
        
        NSArray *btnTitles = self.nearestDict[@"btnTitles"];
        NSInteger currentIndex = [self.nearestDict[@"selectedIndex"] integerValue];
        
        NSString *key = btnTitles[currentIndex];
        [cell conFigDataArray:nearestArray accessory:key];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        ISSMapViewController *vc = [[ISSMapViewController alloc] init];
        vc.selectedDeviceId = self.environmentListModel.deviceId;
        vc.showType = 2;
        [self.navigationController pushViewController:vc animated:YES];
    }
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

- (void)choiceButtonActionSection {
    NSArray *btnTitles = self.nearestDict[@"btnTitles"];
    NSInteger currentIndex = [self.nearestDict[@"selectedIndex"] integerValue];
    
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
    self.nearestDict[@"selectedIndex"] = @(index);
    
    [self.mainTableView reloadData];
}

@end
