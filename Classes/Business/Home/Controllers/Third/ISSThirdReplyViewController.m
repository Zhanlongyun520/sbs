//
//  ISSThirdReplyViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdReplyViewController.h"
#import "ISSThirdDetailTopTableViewCell.h"
#import "ISSThirdDetailVisitTableViewCell.h"
#import "ISSThirdDetailReplyTableViewCell.h"
#import "ISSThirdAddHeadTableViewCell.h"
#import "ISSThirdAddReportTableViewCell.h"
#import "ISSReportModel.h"

#import "APIThirdDetailManager.h"
#import "ISSThirdDetailReformer.h"
#import "ISSThirdDetailModel.h"

@interface ISSThirdReplyViewController ()<APIManagerCallBackDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView                       * mainTableView;
@property(nonatomic ,strong) APIThirdDetailManager             * thirdDetailManager;
@property(nonatomic ,strong) ISSThirdDetailModel               * thirdDetailmodel;
@property(nonatomic ,strong) ISSThirdAddReportTableViewCell    * reportCell;

@end

@implementation ISSThirdReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHiddenTabBar = YES;
    self.title = @"巡查报告回复";
    [self.view addSubview:self.mainTableView];
    self.thirdDetailManager.patrolID = self.thirdListModel.thirdID;
    [self.thirdDetailManager loadData];
    [self showLoadingView];
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

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 360;
    }else if (indexPath.row == 3){
        return 64;
    }else if (indexPath.row == 4){
        return 176+54+16;
    }else if (indexPath.row == 5){
        return 108;
    } else{
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
    return 4 + 2;
//    return self.thirdDetailmodel.reportsArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ISSThirdDetailTopTableViewCell * cell = [[ISSThirdDetailTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdDetailTop"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell conFigDataThirdDetailModel:self.thirdDetailmodel];
        return cell;
    }else if (indexPath.row == 3){
        ISSThirdAddHeadTableViewCell * cell = [[ISSThirdAddHeadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAddHead"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 4){
        self.reportCell.controller = self;
//        self.reportCell.imagesArray = self.imagesArray;
//        __weak typeof(self) weakself = self;
        _reportCell.thirdAddReportCellBlock = ^(CGFloat height,NSMutableArray * array){
//            reportCellHeight = height;
//            weakself.imagesArray = array;
            //需要更新的组数中的cell
//            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:4 inSection:0];
//            [weakself.mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        return _reportCell;
    }else if (indexPath.row == 5){
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAddReportTime"];
        cell.backgroundColor = ISSColorViewBg;
        UIButton * submitButton = [[UIButton alloc]initWithFrame:CGRectMake(16, 20, kScreenWidth - 32, 50)];
        [submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [submitButton setTitleColor:ISSColorWhite forState:UIControlStateNormal];
        [submitButton.titleLabel setFont:ISSFont15];
        [submitButton setBackgroundImage:[ISSUtilityMethod createImageWithColor:ISSColorNavigationBar] forState:UIControlStateDisabled];
        [submitButton setBackgroundImage:[ISSUtilityMethod createImageWithColor:ISSColorNavigationBar] forState:UIControlStateNormal];
        submitButton.layer.masksToBounds = YES;
        submitButton.layer.cornerRadius = 4;
        [submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:submitButton];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else{
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


- (void)submitButtonAction
{
    if ([_reportCell.textView.text isEqualToString:@""]){
        ALERT(@"请输入报告内容");
        return;
    }
    ALERT(@"回复成功");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (ISSThirdAddReportTableViewCell *)reportCell
{
    if (_reportCell == nil) {
        _reportCell = [[ISSThirdAddReportTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAddReport"];
        _reportCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _reportCell;
}

@end
