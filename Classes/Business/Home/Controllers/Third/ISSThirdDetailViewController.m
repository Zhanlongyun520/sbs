//
//  ISSThirdDetailViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/30.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdDetailViewController.h"
#import "ISSThirdDetailTopTableViewCell.h"
#import "ISSThirdDetailVisitTableViewCell.h"
#import "ISSThirdDetailReplyTableViewCell.h"
#import "ISSReportModel.h"

#import "APIThirdDetailManager.h"
#import "ISSThirdDetailReformer.h"
#import "ISSThirdDetailModel.h"


@interface ISSThirdDetailViewController ()<APIManagerCallBackDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView                       * mainTableView;
@property(nonatomic ,strong) APIThirdDetailManager             * thirdDetailManager;
@property(nonatomic ,strong) ISSThirdDetailModel               * thirdDetailmodel;

@end

@implementation ISSThirdDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看巡查报告";
    self.isHiddenTabBar = YES;
    
    self.thirdDetailManager.patrolID = self.thirdListModel.thirdID;
    [self.thirdDetailManager loadData];
    [self.view addSubview:self.mainTableView];
    [self showLoadingView];
}


#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 360;
    }else{
        ISSReportModel * reportModel = self.thirdDetailmodel.reportsArray[indexPath.row - 1];
        if ([reportModel.category isEqualToString:@"1"]){
            return 380;
        }else{
            return 230;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
//    return self.thirdDetailmodel.reportsArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ISSThirdDetailTopTableViewCell * cell = [[ISSThirdDetailTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdDetailTop"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell conFigDataThirdDetailModel:self.thirdDetailmodel];
        return cell;
    }else{
        ISSReportModel * reportModel = self.thirdDetailmodel.reportsArray[indexPath.row - 1];
        if ([reportModel.category isEqualToString:@"1"]){
        ISSThirdDetailVisitTableViewCell * cell = [[ISSThirdDetailVisitTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdDetailChatLeft"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        }else{
        ISSThirdDetailReplyTableViewCell * cell = [[ISSThirdDetailReplyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdDetailReply"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        }
    }
}


#pragma mark - APIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    if([manager isKindOfClass:[APIThirdDetailManager class]])
    {
       self.thirdDetailmodel= [manager fetchDataWithReformer:[[ISSThirdDetailReformer alloc]init]];
        [self.mainTableView reloadData];
        [self hiddenLoadingView];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    ALERT(manager.errorMessage);
}


#pragma mark - Setter && Getter

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabbarHeight) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = ISSColorWhite;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

- (APIThirdDetailManager *)thirdDetailManager
{
    if (nil == _thirdDetailManager) {
        _thirdDetailManager = [[APIThirdDetailManager alloc] init];
        _thirdDetailManager.delegate = self;
    }
    return _thirdDetailManager;
}

@end
