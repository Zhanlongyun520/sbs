//
//  ISSSystemViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSSystemViewController.h"
#import "ISSSystemTopTableViewCell.h"
#import "ISSSystemTableViewCell.h"

#import "ISSUserCenterViewController.h"
#import "ISSAboutUsViewController.h"
#import "ISSFreedBackViewController.h"
#import "ISSSettingViewController.h"
#import "ISSLoginUserModel.h"
#import "ISSUserInfoViewController.h"

@interface ISSSystemViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic , strong) UITableView           * mainTableView;

@end

@implementation ISSSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"系统";
    self.ishiddenNav = YES;
    self.isHiddenNavLine = YES;
    [self hiddenBackBarButtonItem];
    [self.view addSubview:self.mainTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 227;
    }else if(indexPath.row == 2){
        return 10;
    }else if(indexPath.row == 6){
        return 10;
    }else{
        return 48;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //顶部
        ISSSystemTopTableViewCell * cell = [[ISSSystemTopTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"HomeTop"];
        [cell.headIV setImageWithPath:[ISSLoginUserModel shareInstance].loginUser.imageData placeholder:@"default-head"];
        cell.usernameLabel.text = [ISSLoginUserModel shareInstance].loginUser.name;
        cell.signatureLabel.text = [ISSLoginUserModel shareInstance].loginUser.des;
        return cell;
    }else if(indexPath.row == 1){
        ISSSystemTableViewCell * cell = [[ISSSystemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"usercenter"];
        [cell conFigDataTitle:@"个人中心" Image:@"usercenter" HiddenLine:YES];
        return cell;
    }else if (indexPath.row == 3){
        ISSSystemTableViewCell * cell = [[ISSSystemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeMessage"];
        [cell conFigDataTitle:@"关于我们" Image:@"about"  HiddenLine:NO];
        return cell;
    }else if (indexPath.row == 4){
        ISSSystemTableViewCell * cell = [[ISSSystemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeMessage"];
        [cell conFigDataTitle:@"意见反馈" Image:@"suggestion"  HiddenLine:NO];
        return cell;
    }else if (indexPath.row == 5){
        ISSSystemTableViewCell * cell = [[ISSSystemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeMessage"];
        [cell conFigDataTitle:@"设置" Image:@"setting"  HiddenLine:YES];
        return cell;
    } else if (indexPath.row == 7){
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeMessage"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * signOutLabel = [[UILabel alloc]initForAutoLayout];
        signOutLabel.font = ISSFont16;
        signOutLabel.textColor = ISSColorNavigationBar;
        signOutLabel.text = @"退出";
        signOutLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:signOutLabel];
        [cell.contentView addConstraint:[signOutLabel constraintCenterXInContainer]];
        [cell.contentView addConstraint:[signOutLabel constraintCenterYInContainer]];
        return cell;
    }else if (indexPath.row == 8){
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeMessage"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = ISSColorViewBg;
        UILabel * vLabel = [[UILabel alloc]initForAutoLayout];
        vLabel.font = ISSFont10;
        vLabel.textColor = ISSColorDardGray9;
        vLabel.text = [NSString stringWithFormat:@"V%@\n光谷中心城绿色智慧工地",BuildeVersion];
        vLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:vLabel];
        [cell.contentView addConstraint:[vLabel constraintCenterXInContainer]];
        [cell.contentView addConstraints:[vLabel constraintsTopInContainer:16]];
        UILabel * nLabel = [[UILabel alloc]initForAutoLayout];
        nLabel.font = ISSFont10;
        nLabel.textColor = ISSColorDardGray9;
        nLabel.text = @"光谷中心城绿色智慧工地";
        nLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:nLabel];
        [cell.contentView addConstraint:[nLabel constraintCenterXInContainer]];
        [cell.contentView addConstraints:[nLabel constraintsTop:1 FromView:vLabel]];
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
    if (indexPath.row == 1) {
        ISSUserInfoViewController * userCenterVC = [[ISSUserInfoViewController alloc]initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:userCenterVC animated:YES];
    }else if (indexPath.row == 3){
        ISSAboutUsViewController * aboutUsVC = [[ISSAboutUsViewController alloc]init];
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }else if (indexPath.row == 4){
        ISSFreedBackViewController * freedBackVC = [[ISSFreedBackViewController alloc]init];
        [self.navigationController pushViewController:freedBackVC animated:YES];
    }else if (indexPath.row == 5){
        ISSSettingViewController * settingVC = [[ISSSettingViewController alloc]init];
        [self.navigationController pushViewController:settingVC animated:YES];
    }else if (indexPath.row == 7){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginAccount"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [ISSLoginUserModel removeAccount];
        
        [ISSLoginUserModel shareInstance].loginUser = nil;

        [kDefaultCenter postNotificationName:kLoginOut object:nil];
    }
}


-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight + 20) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = ISSColorViewBg;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _mainTableView.userInteractionEnabled = NO;
    }
    return _mainTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
