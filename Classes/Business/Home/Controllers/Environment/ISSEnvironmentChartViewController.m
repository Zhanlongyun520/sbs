
//
//  ISSEnvironmentChartViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSEnvironmentChartViewController.h"
#import "ISSEnvironmentTopTableViewCell.h"
#import "ISSBarChartTableViewCell.h"
#import "ISSPieChartTableViewCell.h"
#import "ISSLineChartTableViewCell.h"

#import "ISSEnvironmentListViewController.h"
#import "APIENearestManager.h"
#import "APIDataRankingManager.h"
#import "APIDataComparisonManager.h"
#import "APIDaysProportionManager.h"
#import "APIWeatherLiveManager.h"

@interface ISSEnvironmentChartViewController ()<UITableViewDelegate, UITableViewDataSource,APIManagerCallBackDelegate>

@property(nonatomic , strong) ISSRefreshTableView           * mainTableView;
@property(nonatomic , strong) APIDataRankingManager         * dataRankingManager;
@property(nonatomic , strong) APIDataComparisonManager      * dataComparisonManager;
@property(nonatomic , strong) APIDaysProportionManager      * daysProportionManager;
@property(nonatomic , strong) APIWeatherLiveManager         * weatherLiveManager;

@end

@implementation ISSEnvironmentChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"环境监测";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.mainTableView];
    [self navigationSetUp];

//    [self.dataRankingManager loadData];
//    [self.dataComparisonManager loadData];
//    [self.daysProportionManager loadData];
    [self.weatherLiveManager loadData];
}

- (void)listButton
{
    ISSEnvironmentListViewController * environmentVC = [[ISSEnvironmentListViewController alloc]init];
    [self.navigationController pushViewController:environmentVC animated:YES];
}

- (void)navigationSetUp
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 19, 19);
    [rightBtn setImage:[UIImage imageNamed:@"environmentlist"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(listButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    ALERT(manager.errorMessage);
}


#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 200;
    }else if (indexPath.row == 3){
        return 270;
    }else if (indexPath.row == 5){
        return 200;
    }else if (indexPath.row == 7){
        return 200;
    }
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ISSEnvironmentTopTableViewCell * cell = [[ISSEnvironmentTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentTop"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1) {
        ISSBarChartTableViewCell * cell = [[ISSBarChartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BarChart"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 2){
        ISSEnvironmentTopTableViewCell * cell = [[ISSEnvironmentTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentTop"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 3){
        ISSPieChartTableViewCell * cell = [[ISSPieChartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentTop"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 4){
        ISSEnvironmentTopTableViewCell * cell = [[ISSEnvironmentTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentTop"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 5){
        ISSLineChartTableViewCell * cell = [[ISSLineChartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentTop"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 6){
        ISSEnvironmentTopTableViewCell * cell = [[ISSEnvironmentTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentTop"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        ISSLineChartTableViewCell * cell = [[ISSLineChartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnvironmentTop"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
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



- (APIDataRankingManager *)dataRankingManager
{
    if (nil == _dataRankingManager) {
        _dataRankingManager = [[APIDataRankingManager alloc] init];
        _dataRankingManager.delegate = self;
    }
    return _dataRankingManager;
}

- (APIDataComparisonManager *)dataComparisonManager
{
    if (nil == _dataComparisonManager) {
        _dataComparisonManager = [[APIDataComparisonManager alloc] init];
        _dataComparisonManager.delegate = self;
    }
    return _dataComparisonManager;
}

- (APIDaysProportionManager *)daysProportionManager
{
    if (nil == _daysProportionManager) {
        _daysProportionManager = [[APIDaysProportionManager alloc] init];
        _daysProportionManager.delegate = self;
    }
    return _daysProportionManager;
}

- (APIWeatherLiveManager *)weatherLiveManager
{
    if (nil == _weatherLiveManager) {
        _weatherLiveManager = [[APIWeatherLiveManager alloc] init];
        _weatherLiveManager.delegate = self;
    }
    return _weatherLiveManager;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
