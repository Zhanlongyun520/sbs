//
//  ISSHomeViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSHomeViewController.h"
#import "ISSHomeTopTableViewCell.h"
#import "ISSHomeFunctionTableViewCell.h"
#import "ISSHomeMessageTableViewCell.h"
#import "ISSHomeSpaceTableViewCell.h"

#import "ISSHomeReformer.h"
#import "ISSHomeModel.h"
#import "ISSUnRecListReformer.h"

#import "APIHomeManager.h"
#import "APIUnRecListManager.h"
#import "APIRecForMobileManager.h"

#import "ISSVideoListViewController.h"
#import "ISSEnvironmentListViewController.h"
#import "ISSEnvironmentMonitorViewController.h"
#import "ISSThirdListViewController.h"
#import "ISSPatrolReportViewController.h"
#import "ISSTabBarController.h"
#import "ISSPlainPendingListViewController.h"
#import "ISSTaskListViewController.h"
#import "ISSPatrolMonitorViewController.h"
#import "ISSTaskDepartmentModel.h"
#import "ISSPatrolStatViewController.h"
#import "ISSCarMonitorViewController.h"
#import "ISSLoginUserModel.h"
#import "ISSPlainCreateViewController.h"
#import "ISSThirdViewController.h"

#import "NetworkRequest.h"
#import "STPopup.h"
#import "ISSCarRecognitionViewController.h"

#import "ISSReportCategoryModel.h"
#import "ISSLoginUserModel.h"
#import "ISSReportCheckViewController.h"
#import "ISSCameraManager.h"
#import "ISSSettingViewController.h"

@interface ISSHomeViewController ()<UITableViewDelegate, UITableViewDataSource,APIManagerCallBackDelegate>

@property(nonatomic , strong) ISSHomeTopTableViewCell                  * homeTopView;
@property(nonatomic , strong) ISSHomeFunctionTableViewCell             * homeFunctionView;
@property(nonatomic , strong) UITableView                              * mainTableView;

@property(nonatomic , strong) APIHomeManager                           * homeManager;
@property(nonatomic , strong) ISSHomeModel                             * homeModel;
@property(nonatomic , strong) APIUnRecListManager                      * unRecListManager;
@property(nonatomic , strong) APIRecForMobileManager                   * recForMobileManager;

@property(nonatomic , strong) NSMutableArray *carRecognitionList;

@end

@implementation ISSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"光谷中心城智慧工地";
    self.ishiddenNav = YES;
    self.isHiddenNavLine = YES;
    [self hiddenBackBarButtonItem];
    
    [self.view addSubview:self.homeTopView];
    [self.view addSubview:self.homeFunctionView];
    [self.view addSubview:self.mainTableView];
    
    [self.homeManager loadData];
    [self hiddenLoadingView];
//    [self.unRecListManager loadData];
//    [self getBallastCarView];
    
    [self loadDepartmentDictionary];
    
    [self getInitData];
    
    [[ISSCameraManager shareInstance] loginUV];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([ISSSettingViewController isCarRecongizeOn]) {
        [self getUnRecList];
    }
}

#pragma mark - APIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if([manager isKindOfClass:[APIHomeManager class]])
    {
        self.homeModel = [manager fetchDataWithReformer:[[ISSHomeReformer alloc]init]];
        [self.homeTopView conFigDataHomeModel:self.homeModel];
        [self.mainTableView reloadData];
        [self hiddenLoadingView];
//        [self getBallastCarView];
    }
    if([manager isKindOfClass:[APIUnRecListManager class]])
    {
        NSDictionary * dic = [manager fetchDataWithReformer:[[ISSUnRecListReformer alloc]init]];
        NSLog(@"dic:%@",[manager fetchDataWithReformer:nil]);
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    if([manager isKindOfClass:[APIHomeManager class]])
    {
        ALERT(@"请求异常");
    }
}

#pragma maek - BallastCar

- (void)getBallastCarView
{
    self.ballastCarView.hidden = NO;
    [self.ballastCarView.confirmButton addTarget:self action:@selector(ballastCarViewConfirm) forControlEvents:UIControlEventTouchUpInside];
    [self.ballastCarView.cancelButton addTarget:self action:@selector(ballastCarViewConfirm) forControlEvents:UIControlEventTouchUpInside];
}

- (void)ballastCarViewConfirm
{
    self.ballastCarView.hidden = YES;
    self.recForMobileManager.carLicence = @"sadaad";
    self.recForMobileManager.recResult = @"0";
    [self.recForMobileManager loadData];
}

#pragma mark - Button Action

- (void)topMessageButtonAction
{
    ISSTaskListViewController *viewController = [[ISSTaskListViewController alloc]init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)topPendingButtonAction
{
    ISSThirdViewController *viewController = [[ISSThirdViewController alloc]init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)topVideoButtonAction
{
    ISSVideoListViewController * viewController = [[ISSVideoListViewController alloc]init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)topEnvironmentButtonAction
{
    ISSEnvironmentListViewController * viewController = [[ISSEnvironmentListViewController alloc]init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Button Action
//视频监控
- (void)videoButtonAction
{
    ISSVideoListViewController * viewController = [[ISSVideoListViewController alloc]init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
//环境监测
- (void)environmentButtonAction
{
    ISSEnvironmentMonitorViewController * viewController = [[ISSEnvironmentMonitorViewController alloc]init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
//三方协同
- (void)thirdartyButtonAction
{
    ISSThirdViewController * thirdListVC = [[ISSThirdViewController alloc]init];
    thirdListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:thirdListVC animated:YES];
}
//渣土车监控
- (void)carMonitorButtonAction
{
    ISSCarMonitorViewController * vc = [[ISSCarMonitorViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//巡查计划
- (void)patrolPlainButtonAction
{
    if ([ISSLoginUserModel shareInstance].privilegeCode.M_CPPA) {
        ISSPlainPendingListViewController *viewController = [[ISSPlainPendingListViewController alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    } else if ([ISSLoginUserModel shareInstance].privilegeCode.M_CPP) {
        ISSPlainCreateViewController *viewController = [[ISSPlainCreateViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
//巡查任务
- (void)patrolTaskButtonAction
{
    ISSTaskListViewController *viewController = [[ISSTaskListViewController alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
//巡查监控
- (void)patrolMonitorButtonAction
{
    ISSPatrolMonitorViewController *viewController = [[ISSPatrolMonitorViewController alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
//巡查概况
- (void)patrolStatButtonAction
{
    ISSPatrolStatViewController *viewController = [[ISSPatrolStatViewController alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0){
        return 48;
    }else{
        ISSMessageModel * messageModel = self.homeModel.messageArray[indexPath.row - 1];
        CGSize textSize = [self sizeWithText:messageModel.content font:ISSFont12 maxWidth:kScreenWidth-64];
        return textSize.height + 70;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homeModel.messageArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0){
        ISSHomeSpaceTableViewCell * cell = [[ISSHomeSpaceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeSpace"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        //消息
        ISSHomeMessageTableViewCell * cell = [[ISSHomeMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeMessage"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.homeModel != nil) {
            ISSMessageModel * messageModel = self.homeModel.messageArray[indexPath.row - 1];
            [cell conFigDataMessageModel:messageModel];
        }
        return cell;
    }
}

// 根据指定文本,字体和最大宽度计算尺寸
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}

#pragma make - Setter && Getter
   
-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        //_mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.homeFunctionView.frame), kScreenWidth, kScreenHeight - CGRectGetHeight(self.homeFunctionView.frame) - kTabbarHeight) style:UITableViewStylePlain];
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.homeFunctionView.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(self.homeFunctionView.frame) - kTabbarHeight) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = ISSColorViewBg;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

- (APIHomeManager *)homeManager
{
    if (nil == _homeManager) {
        _homeManager = [[APIHomeManager alloc] init];
        _homeManager.delegate = self;
    }
    return _homeManager;
}

- (APIUnRecListManager *)unRecListManager
{
    if (_unRecListManager == nil) {
        _unRecListManager = [[APIUnRecListManager alloc]init];
        _unRecListManager.delegate = self;
    }
    return _unRecListManager;
}

- (APIRecForMobileManager *)recForMobileManager
{
    if (_recForMobileManager == nil) {
        _recForMobileManager = [[APIRecForMobileManager alloc]init];
        _recForMobileManager.delegate = self;
    }
    return _recForMobileManager;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ISSHomeTopTableViewCell *)homeTopView
{
    if (_homeTopView == nil) {
        _homeTopView = [[ISSHomeTopTableViewCell alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
        [_homeTopView.videoButton addTarget:self action:@selector(topVideoButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_homeTopView.messageButton addTarget:self action:@selector(topMessageButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_homeTopView.pendingButton addTarget:self action:@selector(topPendingButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_homeTopView.environmentButton addTarget:self action:@selector(topEnvironmentButtonAction) forControlEvents:UIControlEventTouchUpInside];


    }
    return _homeTopView;
}

- (ISSHomeFunctionTableViewCell *)homeFunctionView
{
    if (_homeFunctionView == nil) {
        NSArray *menuArray = [ISSHomeFunctionTableViewCell getHomeMenuData];
        CGFloat menuHeight = CGFLOAT_MIN;
        if (!menuArray || menuArray.count == 0) {
            menuHeight = CGFLOAT_MIN;
        } else if (menuArray.count <= 4) {
            menuHeight = 88;
        } else {
            menuHeight = 175;
        }
        __weak typeof(self) weakSelf = self;
        _homeFunctionView = [[ISSHomeFunctionTableViewCell alloc]initWithFrame:CGRectMake(0, 250, kScreenWidth, menuHeight)];
        _homeFunctionView.homeFunctionBlock = ^(NSInteger index) {
            switch (index) {
                case 0:
                    [weakSelf videoButtonAction];
                    break;
                    
                case 1:
                    [weakSelf environmentButtonAction];
                    break;
                    
                case 2:
                    [weakSelf thirdartyButtonAction];
                    break;

                case 3:
                    [weakSelf carMonitorButtonAction];
                    break;
                    
                case 4:
                    [weakSelf patrolStatButtonAction];
                    break;
                    
                case 5:
                    [weakSelf patrolPlainButtonAction];
                    break;
                    
                case 6:
                    [weakSelf patrolTaskButtonAction];
                    break;
                    
                case 7:
                    [weakSelf patrolMonitorButtonAction];
                    break;
                    
                default:
                    break;
            }
        };
        _homeFunctionView.backgroundColor = ISSColorWhite;
    }
    return _homeFunctionView;
}

- (void)loadDepartmentDictionary {
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            [ISSTaskDepartmentModel shareInstance].dataList = [ISSTaskDepartmentModel arrayOfModelsFromDictionaries:[result objectForKey:@"rawRecords"] error:nil];
        }
    }];
    [request getSystemDictionary];
}

- (void)getUnRecList {
    _carRecognitionList = [NSMutableArray array];
    
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        
        NSArray *list = result[@"content"];
        if (list.count > 0) {
            NSArray *dataSource = [ISSunRecListModel arrayOfModelsFromDictionaries:list error:nil];
            
            [_carRecognitionList addObjectsFromArray:dataSource];
            
            [self prsentPopView:self.carRecognitionList.firstObject];
        }
    }];
    [request getUnRecList:@(100)];
}

- (void)prsentPopView:(ISSunRecListModel *)model {
    ISSCarRecognitionViewController *vc = [[ISSCarRecognitionViewController alloc] init];
    vc.model = model;

    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:vc];

    vc.btnAction = ^(NSInteger tag) {
        //保存识别结果
        NetworkRequest *request = [[NetworkRequest alloc] init];
        [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
            [popupController dismiss]; //有返回结果就直接dismiss，不管成功与否
            
            if (success) {
                BOOL successed = result[@"success"];
                if (successed) {
                    NSString *msg = result[@"msg"];
                    [[TKAlertCenter defaultCenter] postAlertWithMessage:msg];
                }
                
                //已经识别过，则移除对象
                [self.carRecognitionList removeObject:model];

                //继续识别下一辆
                [self goNextCarRecognition];
            }
        }];
        [request carRecognition:model.licence recResult:@(tag)];
    };
    
    popupController.navigationBarHidden = YES;
    [popupController presentInViewController:self];
}

- (void)goNextCarRecognition {
    
    if (self.carRecognitionList.count == 0) {
        return;
    }
    [self prsentPopView:self.carRecognitionList.firstObject];
}

- (void)getInitData {
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            [ISSReportCategoryModel shareInstance].dataList = [ISSReportCategoryModel arrayOfModelsFromDictionaries:[result objectForKey:@"rawRecords"] error:nil];
        }
    }];
    [request getReportCategoryDictionary];
}

@end
