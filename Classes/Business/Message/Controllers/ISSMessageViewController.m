//
//  ISSMessageViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMessageViewController.h"
#import "ISSMessageTableViewCell.h"

#import "ISSMessageReformer.h"
#import "ISSMessageModel.h"
#import "APIMessageTypeManager.h"

#import "ISSMessageListViewController.h"

@interface ISSMessageViewController ()<UITableViewDelegate, UITableViewDataSource,APIManagerCallBackDelegate>
{
    BOOL      isHeaderRefresh;
    BOOL      isFooterRefresh;
}

@property(nonatomic , strong) ISSRefreshTableView               * mainTableView;
@property(nonatomic , strong) APIMessageTypeManager             * messageTypeManager;

@property(nonatomic , strong) NSArray                           * messageArray;

@end

@implementation ISSMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    [self hiddenBackBarButtonItem];
    [kDefaultCenter addObserver:self selector:@selector(viewRefresh) name:kMessageVCRefresh object:nil];
    [self.messageTypeManager loadData];
    [self.view addSubview:self.mainTableView];
}

- (void)viewRefresh
{
    [self.messageTypeManager loadData];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if([manager isKindOfClass:[APIMessageTypeManager class]])
    {
        NSDictionary *dic = [manager fetchDataWithReformer:nil];
        self.messageArray = [manager fetchDataWithReformer:[ISSMessageReformer new]];
        [self.mainTableView reloadData];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    ALERT(@"请求出错");
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 10;
    }else if (indexPath.row == 3){
        return 10;
    }else if (indexPath.row == 5){
        return 10;
    }else if (indexPath.row == 7){
        return 10;
    }else if (indexPath.row == 9){
        return 10;
    }else{
        return 72;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.messageArray.count == 0) {
        return 0;
    }
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ISSMessageTableViewCell * cell = [[ISSMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.logoIV.image = [UIImage imageNamed:@"video_control"];
        cell.nameLabel.text = @"视屏监控";
        [cell conFigDataMessageModel:self.messageArray[0]];
        return cell;
    }else if (indexPath.row == 2){
        ISSMessageTableViewCell * cell = [[ISSMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.logoIV.image = [UIImage imageNamed:@"environment_control"];
        cell.nameLabel.text = @"环境监控";
        [cell conFigDataMessageModel:self.messageArray[1]];
        return cell;
    }else if (indexPath.row == 4){
        ISSMessageTableViewCell * cell = [[ISSMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.logoIV.image = [UIImage imageNamed:@"threeParty"];
        cell.nameLabel.text = @"三方协同";
        [cell conFigDataMessageModel:self.messageArray[2]];
        return cell;
    }else if (indexPath.row == 6){
        ISSMessageTableViewCell * cell = [[ISSMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.logoIV.image = [UIImage imageNamed:@"home-car-monitor"];
        cell.nameLabel.text = @"渣土车监控消息";
        [cell conFigDataMessageModel:self.messageArray[3]];
        return cell;
    }else if (indexPath.row == 8){
        ISSMessageTableViewCell * cell = [[ISSMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.logoIV.image = [UIImage imageNamed:@"home-patrol-task"];
        cell.nameLabel.text = @"巡查任务消息";
        [cell conFigDataMessageModel:self.messageArray[4]];
        return cell;
    }else if (indexPath.row == 10){
        ISSMessageTableViewCell * cell = [[ISSMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.logoIV.image = [UIImage imageNamed:@"home-patrol-plain"];
        cell.nameLabel.text = @"巡查计划消息";
        [cell conFigDataMessageModel:self.messageArray[5]];
        return cell;
    }else{
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeMessage"];
        cell.backgroundColor = ISSColorViewBg;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ISSMessageListViewController * messageListVC = [[ISSMessageListViewController alloc]init];
        messageListVC.title = @"视屏监控消息";
        messageListVC.messageType = @"2";
        [self.navigationController pushViewController:messageListVC animated:YES];
    }else if (indexPath.row == 2){
        ISSMessageListViewController * messageListVC = [[ISSMessageListViewController alloc]init];
        messageListVC.title = @"环境监控消息";
        messageListVC.messageType = @"1";
        [self.navigationController pushViewController:messageListVC animated:YES];
    } else if (indexPath.row == 4) {
        ISSMessageListViewController * messageListVC = [[ISSMessageListViewController alloc]init];
        messageListVC.title = @"三方协同消息";
        messageListVC.messageType = @"3";
        [self.navigationController pushViewController:messageListVC animated:YES];
    } else if (indexPath.row == 6) {
        ISSMessageListViewController * messageListVC = [[ISSMessageListViewController alloc]init];
        messageListVC.title = @"渣土车监控消息";
        messageListVC.messageType = @"4";
        [self.navigationController pushViewController:messageListVC animated:YES];
    } else if (indexPath.row == 8) {
        ISSMessageListViewController * messageListVC = [[ISSMessageListViewController alloc]init];
        messageListVC.title = @"巡查任务消息";
        messageListVC.messageType = @"7";
        [self.navigationController pushViewController:messageListVC animated:YES];
    } else if (indexPath.row == 10) {
        ISSMessageListViewController * messageListVC = [[ISSMessageListViewController alloc]init];
        messageListVC.title = @"巡查计划消息";
        messageListVC.messageType = @"110";
        [self.navigationController pushViewController:messageListVC animated:YES];
    }
}

#pragma mark - Setter && Getter

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[ISSRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = ISSColorViewBg;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}


- (APIMessageTypeManager *)messageTypeManager
{
    if (nil == _messageTypeManager) {
        _messageTypeManager = [[APIMessageTypeManager alloc] init];
        _messageTypeManager.delegate = self;
    }
    return _messageTypeManager;
}


@end
