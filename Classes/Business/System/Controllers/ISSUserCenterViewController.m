//
//  ISSUserCenterViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/26.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSUserCenterViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>


#import "ISSThirdAddTableViewCell.h"
#import "ISSUserCenterHeadPortraitTableViewCell.h"
#import "ISSUserCenterGreyTableViewCell.h"
#import "ISSThirdAddIsReportTableViewCell.h"
#import "ISSUserCenterPasswordTableViewCell.h"

#import "APIUpdateUserInfoManager.h"
#import "ISSLoginUserModel.h"
#import "UIImageView+WebImage.h"
#import "ISSLoginUserModel.h"

@interface ISSUserCenterViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    ISSUserCenterHeadPortraitTableViewCell  * headCell;
    ISSThirdAddTableViewCell                * nameCell;
    ISSUserCenterPasswordTableViewCell      * passwordCell;
}

@property(nonatomic , strong) APIUpdateUserInfoManager            * updateUserInfoManager;
@property(nonatomic , strong) UITableView                         * mainTableView;
//@property(nonatomic , strong) UIAlertController                   * alertController;


@end

@implementation ISSUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    self.isHiddenTabBar = YES;
    
    [self navigationSetUp];
    [self.view addSubview:self.mainTableView];
    [self.updateUserInfoManager loadData];
}

- (void)navigationSetUp
{
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"提交" forState:UIControlStateNormal];
    [cancelButton setTitleColor:ISSColorWhite forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:ISSFont12];
    [cancelButton setFrame:CGRectMake(0, 0, 15, 20)];
    [cancelButton addTarget:self action:@selector(sureButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    self.navigationItem.rightBarButtonItem = cancelItem;
}

#pragma mark - Button Action

- (void)sureButton
{
    
}

- (void)passwordCellButton
{
    if (passwordCell.hiddenButton.isSelected == NO) {
        passwordCell.hiddenButton.selected = YES;
        passwordCell.textField.secureTextEntry = NO;
    }else{
        passwordCell.hiddenButton.selected = NO;
        passwordCell.textField.secureTextEntry = YES;
    }
}


#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 72;
    }if (indexPath.row == 2) {
        return 54;
    }if (indexPath.row == 3) {
        return 54;
    }if (indexPath.row == 4) {
        return 54;
    }if (indexPath.row == 6) {
        return 54;
    }if (indexPath.row == 7) {
        return 54;
    }if (indexPath.row == 9) {
        return 54;
    }if (indexPath.row == 10) {
        return 54;
    }if (indexPath.row == 12) {
        return 54;
    }else{
        return 10;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        headCell = [[ISSUserCenterHeadPortraitTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeMessage"];
        headCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [headCell.headPortraitIV setImageWithPath:[ISSLoginUserModel shareInstance].loginUser.imageData placeholder:@"default-head"];
        return headCell;
    }else if (indexPath.row == 2){
        nameCell = [[ISSThirdAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAdd"];
        nameCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [nameCell conFigDataTitle:@"姓名" ISAddImage:NO HiddenText:NO];
        return nameCell;
    }else if (indexPath.row == 3){
        ISSUserCenterGreyTableViewCell * cell = [[ISSUserCenterGreyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAdd"];
        [cell conFigDataTitle:@"角色" SubTitle:@"监控人员"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 4){
        ISSThirdAddIsReportTableViewCell * cell = [[ISSThirdAddIsReportTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAdd"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 6){
        ISSUserCenterGreyTableViewCell * cell = [[ISSUserCenterGreyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAdd"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell conFigDataTitle:@"账号" SubTitle:[ISSLoginUserModel shareInstance].loginUser.account];
        return cell;
    }else if (indexPath.row == 7){
        passwordCell = [[ISSUserCenterPasswordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAdd"];
        passwordCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [passwordCell.hiddenButton addTarget:self action:@selector(passwordCellButton) forControlEvents:UIControlEventTouchUpInside];
        return passwordCell;
    }else if (indexPath.row == 9){
        ISSThirdAddTableViewCell * cell = [[ISSThirdAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAdd"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell conFigDataTitle:@"电话" ISAddImage:YES HiddenText:NO];
        return cell;
    }else if (indexPath.row == 10){
        ISSThirdAddTableViewCell * cell = [[ISSThirdAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAdd"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell conFigDataTitle:@"公司" ISAddImage:YES HiddenText:YES];
        return cell;
    }else if (indexPath.row == 12){
        ISSThirdAddTableViewCell * cell = [[ISSThirdAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAdd"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell conFigDataTitle:@"签名" ISAddImage:NO HiddenText:NO];
        return cell;
    }else{
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeMessage"];
        cell.backgroundColor = ISSColorViewBg;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self alertPhoto];
    }
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //照片原图
        UIImage* orImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        if (orImage) {
            NSString *dataStr = nil;
            NSData *data = UIImageJPEGRepresentation(orImage, 0.5);
            dataStr = [data base64EncodedStringWithOptions:0];
            headCell.headPortraitIV.image = [UIImage imageWithData:data];
            [picker dismissViewControllerAnimated:YES completion:nil];
        }else {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"图片无效"];
        }
    }
}

- (void)alertPhoto
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shootButtonAction];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [self libraryButtonAction];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)shootButtonAction
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:picker animated:NO completion:nil];
}

- (void)libraryButtonAction
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:NO completion:nil];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    if([manager isKindOfClass:[APIUpdateUserInfoManager class]])
    {
        
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    ALERT(manager.errorMessage);
}


#pragma mark - Setter && Getter

- (APIUpdateUserInfoManager *)updateUserInfoManager
{
    if (nil == _updateUserInfoManager) {
        _updateUserInfoManager = [[APIUpdateUserInfoManager alloc] init];
        _updateUserInfoManager.delegate = self;
    }
    return _updateUserInfoManager;
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = ISSColorViewBg;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}


@end
