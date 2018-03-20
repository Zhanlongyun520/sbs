//
//  ISSEvidenceViewController.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSEvidenceViewController.h"
#import "ISSEvidenceTableViewCell.h"
#import "ISSUploadPhotosViewController.h"

#import "ISSCarListModel.h"
#import "NetworkRequest.h"
#import "TKAlertCenter.h"

@interface ISSEvidenceViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ISSEvidenceViewController

static NSString * const tableReuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"取证列表";
    
    self.isHiddenTabBar = YES;
    
    [self navigationSetUp];
    
    [_tableView registerClass:[ISSEvidenceTableViewCell class] forCellReuseIdentifier:tableReuseIdentifier];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getAllDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getAllDataSource {
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        NSArray *list = result[@"content"];
        
        if (list.count == 0) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"暂无数据"];
        } 
        
        _dataSource = [ISSEvidencePhotoModel arrayOfModelsFromDictionaries:list error:nil];
        
        [_tableView reloadData];
    }];
    [request getEvidencePhotoList:self.model.licence ?: @""];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ISSEvidencePhotoModel *model = self.dataSource[indexPath.row];

    NSArray *imgs = [model.smallPhotoSrc componentsSeparatedByString:@","];

    NSInteger rows = ceilf(imgs.count/(3.0));
    CGFloat btnWidth = (CGRectGetWidth(self.view.window.frame)-60)/3;
    return rows*(btnWidth+5) + 115;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ISSEvidenceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableReuseIdentifier forIndexPath:indexPath];
    
    ISSEvidencePhotoModel *model = self.dataSource[indexPath.row];
    [cell fillDataSource:model];

    return cell;
}

- (void)navigationSetUp {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    rightBtn.tintColor = [UIColor whiteColor];
    [rightBtn setBackgroundImage:[[UIImage imageNamed:@"capture"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
              forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(photoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)photoButtonAction {
    ISSUploadPhotosViewController *vc = [[ISSUploadPhotosViewController alloc] init];
    vc.licence = self.model.licence;
    vc.refreshAction = ^{
        [self getAllDataSource];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

@end
