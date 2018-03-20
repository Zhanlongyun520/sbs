//
//  ISSSettingViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSSettingViewController.h"
#import "ISSSettingsNotificationCell.h"
#import "ISSLoginUserModel.h"
//#import <StoreKit/StoreKit.h> // 评分库

@interface ISSSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic , strong) UITableView           * mainTableView;

@end

@implementation ISSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHiddenTabBar = YES;
    self.title = @"设置";
    
    [self.mainTableView registerClass:[ISSSettingsNotificationCell class] forCellReuseIdentifier:@"ISSSettingsNotificationCell"];
    [self.view addSubview:self.mainTableView];
}


#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 10;
    }
    return 54;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = ISSColorViewBg;
        return cell;
    } else if (indexPath.row == 1) {
        __weak typeof(self) weakSelf = self;
        ISSSettingsNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSSettingsNotificationCell" forIndexPath:indexPath];
        cell.label.text = @"接收推送通知";
        cell.theSwitch.on = [self.class isCarRecongizeOn];
        cell.changeSwitch = ^(BOOL isOn) {
            [weakSelf.class setCarRecongizeOn:isOn];
        };
        return cell;
    }else if (indexPath.row == 2){
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"去评分";
        cell.textLabel.font = ISSFont14;
        cell.textLabel.textColor = ISSColorDardGray2;
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(16, 54, kScreenWidth - 16, 0.5)];
        lineView.backgroundColor = ISSColorSeparatorLine;
        [cell addSubview:lineView];
        return cell;
    }else{
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageList"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"清理缓存";
        cell.textLabel.font = ISSFont14;
        cell.textLabel.textColor = ISSColorDardGray2;
        UILabel * caculateLabel = [[UILabel alloc]initForAutoLayout];
        caculateLabel.text = [NSString stringWithFormat:@"%.1fM",[self filePath]];
        caculateLabel.textColor = ISSColorDardGray6;
        caculateLabel.font = ISSFont14;
        [cell.contentView addSubview:caculateLabel];
        [cell.contentView addConstraint:[caculateLabel constraintCenterYInContainer]];
        [cell.contentView addConstraints:[caculateLabel constraintsRightInContainer:16]];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/%E5%85%89%E8%B0%B7%E4%B8%AD%E5%BF%83%E5%9F%8E%E7%BB%BF%E8%89%B2%E6%99%BA%E6%85%A7%E5%B7%A5%E5%9C%B0/id1324972995?l=zh&ls=1&mt=8"]];
    }else{
        [self clearFile];
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

#pragma mark - caculateFileSize
//清理缓存
-(void)clearFile
{
    NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSArray * files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    
    NSLog(@"cachpath = %@", cachPath);
    
    for (NSString * p in files) {
        
        NSError * error = nil;
        
        NSString * path = [cachPath stringByAppendingPathComponent:p];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            
        }
    }
    
//    [self clearCachSuccess];
    ALERT(@"清理完毕");
    [self.mainTableView reloadData];
}

//显示缓存大小
-(float)filePath
{
    NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [self folderSizeAtPath:cachPath];
}

//遍历文件夹获得文件夹大小
-(float)folderSizeAtPath:(NSString*) folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    return folderSize/(1024.0*1024.0);
}

-(unsigned long long)fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        
    }
    
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSString *)getCarRecongizeOnKey {
    return [NSString stringWithFormat:@"%@-CarRecongizeOn", [ISSLoginUserModel shareInstance].loginUser.account];
}

+ (BOOL)isCarRecongizeOn {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isOn = [userDefaults boolForKey:[self.class getCarRecongizeOnKey]];
    return isOn;
}

+ (void)setCarRecongizeOn:(BOOL)isOn {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isOn forKey:[self.class getCarRecongizeOnKey]];
    [userDefaults synchronize];
}

@end
