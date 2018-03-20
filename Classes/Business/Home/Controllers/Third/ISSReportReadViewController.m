//
//  ISSReportReadViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportReadViewController.h"
#import "ISSReportDetailCell.h"
#import "ISSReportCategoryModel.h"
#import "ISSReportReplyLeftCell.h"
#import "ISSReportReplyRightCell.h"
#import "LGPhoto.h"
#import "UIImageView+WebImage.h"

@interface ISSReportReadViewController () <LGPhotoPickerBrowserViewControllerDataSource, LGPhotoPickerBrowserViewControllerDelegate>
{
    NSArray *_detailList;
    NSArray *_replyList;
    NSMutableArray *_photoList;
}
@end

@implementation ISSReportReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查看巡查报告";
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[ISSReportDetailCell class] forCellReuseIdentifier:@"ISSReportDetailCell"];
    [_tableView registerClass:[ISSReportReplyLeftCell class] forCellReuseIdentifier:@"ISSReportReplyLeftCell"];
    [_tableView registerClass:[ISSReportReplyRightCell class] forCellReuseIdentifier:@"ISSReportReplyRightCell"];
    
    [self getDictionaryData];
    
    [self getReplyData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = CGFLOAT_MIN;
    if (section == 1) {
        height = 1;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    switch (section) {
        case 0:
            count = _detailList.count;
            break;
            
        case 1:
            count = _replyList.count;
            break;
            
        default:
            break;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    UITableViewCell *theCell;
    if (indexPath.section == 0) {
        ISSReportDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportDetailCell" forIndexPath:indexPath];
        cell.model = [_detailList objectAtIndex:indexPath.row];
        theCell = cell;
    } else if (indexPath.section == 1) {
        ISSReportReplyModel *model = [_replyList objectAtIndex:indexPath.row];
        if (model.status == 4 || model.status == 5) { // 右边
            ISSReportReplyRightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportReplyRightCell" forIndexPath:indexPath];
            cell.model = model;
            theCell = cell;
        } else { // 左边
            ISSReportReplyLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportReplyLeftCell" forIndexPath:indexPath];
            cell.model = model;
            theCell = cell;
        }
        ((ISSReportReplyBaseCell *)theCell).showPhotoBlock = ^(ISSReportReplyModel *model, NSInteger index) {
            [weakSelf showFullPhoto:model photoIndex:index];
        };
    }
    return theCell;
}

#pragma mark 详情

- (void)getDictionaryData {
    [self getDetailData];
}

- (void)getDetailData {
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            _detailModel = [[ISSReportDetailModel alloc] initWithDictionary:result error:nil];
            [weakSelf showDetail:_detailModel];
        }
    }];
    [request getThirdReportDetail:_thirdListModel.id];
}

- (void)showDetail:(ISSReportDetailModel *)model {
    NSMutableArray *array = @[@{@"key": @"巡查地点：", @"value": model.address ? : @""},
                              @{@"key": @"巡查单位：", @"value": model.company ? : @""},
                              @{@"key": @"报告状态：", @"value": model.statusDes ? : @""},
                              @{@"key": @"报告类型：", @"value": model.categoryDes ? : @""},
                              @{@"key": @"回访时间：", @"value": model.visitDate ? : @"无"}
                              ].mutableCopy;
    if (model.constructionCompany.length > 0 ||
        model.developmentCompany.length > 0 ||
        model.supervisionCompany.length > 0) {
        
        NSArray *arr = @[@{@"key": @"建设单位：", @"value": model.constructionCompany ? : @""},
                         @{@"key": @"施工单位：", @"value": model.developmentCompany ? : @""},
                         @{@"key": @"监理单位：", @"value": model.supervisionCompany ? : @""}
                         ];
        [array addObjectsFromArray:arr];
    }
    _detailList = [ISSKeyValueModel arrayOfModelsFromDictionaries:array error:nil];
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark 回复

- (void)getReplyData {
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            _replyList = [ISSReportReplyModel arrayOfModelsFromDictionaries:[result objectForKey:@"content"] error:nil];
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
    [request getThirdReportReply:_thirdListModel.id];
}

#pragma mark 浏览大图

- (void)showFullPhoto:(ISSReportReplyModel *)model photoIndex:(NSInteger)photoIndex {
    if (_photoList) {
        [_photoList removeAllObjects];
    } else {
        _photoList = @[].mutableCopy;
    }
    
    for (NSString *path in model.filesArray) {
        LGPhotoPickerBrowserPhoto *photo = [[LGPhotoPickerBrowserPhoto alloc] init];
        photo.photoURL = [NSURL URLWithString:[UIImageView getFileURLString:path]];
        [_photoList addObject:photo];
    }
    
    [self showPhotoBroswer:photoIndex];
}

- (void)showPhotoBroswer:(NSInteger)index {
    LGPhotoPickerBrowserViewController *browserViewController = [[LGPhotoPickerBrowserViewController alloc] init];
    browserViewController.delegate = self;
    browserViewController.dataSource = self;
    browserViewController.showType = LGShowImageTypeImageURL;
    browserViewController.currentIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self presentViewController:browserViewController animated:YES completion:nil];
}

#pragma mark - LGPhotoPickerBrowserViewControllerDataSource

- (NSInteger)photoBrowser:(LGPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{
    return _photoList.count;
}

- (id<LGPhotoPickerBrowserPhoto>)photoBrowser:(LGPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath{
    return [_photoList objectAtIndex:indexPath.item];
}

@end
