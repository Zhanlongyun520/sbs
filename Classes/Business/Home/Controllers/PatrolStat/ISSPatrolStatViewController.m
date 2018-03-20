//
//  ISSPatrolStatViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPatrolStatViewController.h"
#import "ISSStatTotalTaskView.h"
#import "ISSStatMonthUserView.h"
#import "ISSStatMonthTaskView.h"
#import "ISSStatTaskCompareView.h"
#import "ISSStatMonthReportView.h"
#import "NetworkRequest.h"
#import "PGDatePicker.h"
#import "ActionSheetPicker.h"
#import "ISSTaskDepartmentModel.h"
#import "ISSStatMonthTaskModel.h"
#import "PopupPickerControl.h"
#import "PopupCustomMenuCell.h"
#import "ISSStatTotalTaskModel.h"

@interface ISSPatrolStatViewController () <PGDatePickerDelegate>
{
    ISSStatTotalTaskView *_totalTaskView;
    ISSStatMonthUserView *_monthUserView;
    ISSStatMonthTaskView *_monthTaskView;
    ISSStatTaskCompareView *_taskCompareView;
    ISSStatMonthReportView *_monthReportView; 
}
@end

@implementation ISSPatrolStatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"巡查概况";
    self.isHiddenTabBar = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    __weak typeof(self) weakSelf = self;
    
    _totalTaskView = [[ISSStatTotalTaskView alloc] init];
    _totalTaskView.tag = 1;
    _totalTaskView.showDatePickerBlock = ^(NSDate *date, NSInteger tag) {
        [weakSelf showDatePicker:date tag:tag];
    };
    _totalTaskView.showDepartmentPickerBlock = ^(NSString *departmentId, NSInteger tag) {
        [weakSelf showDepartmentPicker:departmentId tag:tag];
    };
    [contentView addSubview:_totalTaskView];
    [_totalTaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
    }];
    
    _monthUserView = [[ISSStatMonthUserView alloc] init];
    _monthUserView.tag = 2;
    _monthUserView.showDatePickerBlock = ^(NSDate *date, NSInteger tag) {
        [weakSelf showDatePicker:date tag:tag];
    };
    _monthUserView.showDepartmentPickerBlock = ^(NSString *departmentId, NSInteger tag) {
        [weakSelf showDepartmentPicker:departmentId tag:tag];
    };
    [contentView addSubview:_monthUserView];
    [_monthUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_totalTaskView);
        make.top.equalTo(_totalTaskView.mas_bottom);
    }];
    
    _monthTaskView = [[ISSStatMonthTaskView alloc] init];
    _monthTaskView.tag = 3;
    _monthTaskView.showDatePickerBlock = ^(NSDate *date, NSInteger tag) {
        [weakSelf showDatePicker:date tag:tag];
    };
    _monthTaskView.showDepartmentPickerBlock = ^(NSString *departmentId, NSInteger tag) {
        [weakSelf showDepartmentPicker:departmentId tag:tag];
    };
    [contentView addSubview:_monthTaskView];
    [_monthTaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_totalTaskView);
        make.top.equalTo(_monthUserView.mas_bottom);
    }];
    
    _taskCompareView = [[ISSStatTaskCompareView alloc] init];
    _taskCompareView.tag = 4;
    _taskCompareView.showDatePickerBlock = ^(NSDate *date, NSInteger tag) {
        [weakSelf showDatePicker:date tag:tag];
    };
    _taskCompareView.showDepartmentArrayPickerBlock = ^(NSArray *departmentIndexArray, NSInteger tag) {
        [weakSelf showDoubleDepartment:departmentIndexArray tag:tag];
    };
    [contentView addSubview:_taskCompareView];
    [_taskCompareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_totalTaskView);
        make.top.equalTo(_monthTaskView.mas_bottom);
    }];
    
    _monthReportView = [[ISSStatMonthReportView alloc] init];
    _monthReportView.tag = 5;
    _monthReportView.showDatePickerBlock = ^(NSDate *date, NSInteger tag) {
        [weakSelf showDatePicker:date tag:tag];
    };
    _monthReportView.showDepartmentArrayPickerBlock = ^(NSArray *departmentIndexArray, NSInteger tag) {
        [weakSelf showDoubleDepartment:departmentIndexArray tag:tag];
    };
    [contentView addSubview:_monthReportView];
    [_monthReportView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_totalTaskView);
        make.top.equalTo(_taskCompareView.mas_bottom);
        make.bottom.equalTo(@-15);
    }];
    
    [self getTotalTask];
    
    [self getStatMonthUser];
    
    [self getStatMonthTask];
    
    [self getStatTaskCompare];
    
    [self getStatMonthReport];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 时间选择

- (void)showDatePicker:(NSDate *)date tag:(NSInteger)tag {
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.delegate = self;
    [datePicker showWithShadeBackgroud];
    datePicker.titleLabel.text = @"请选择时间";
    datePicker.tag = tag;
    datePicker.datePickerType = PGPickerViewType3;
    datePicker.datePickerMode = PGDatePickerModeYearAndMonth;
    [datePicker setDate:date animated:YES];
}

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:dateComponents];
    
    switch (datePicker.tag) {
        case 1:
            [self getTotalTaskWithDate:date];
            break;
            
        case 2:
            [self getStatMonthUserWithDate:date];
            
            break;
            
        case 3:
            [self getStatMonthTaskWithDate:date];
            
            break;
            
        case 4:
            [self getStatTaskCompareWithDate:date];
            
            break;
            
        case 5:
            [self getStatMonthReportWithDate:date];
            
            break;
            
        default:
            break;
    }
}

#pragma mark 选择部门

- (void)showDepartmentPicker:(NSString *)departmentId tag:(NSInteger)tag {
    __block NSInteger currendIndex = 0;
    NSMutableArray *rows = @[].mutableCopy;
    [[ISSTaskDepartmentModel shareInstance].dataList enumerateObjectsUsingBlock:^(ISSTaskDepartmentModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.content.length > 0) {
            [rows addObject:model.content];
            
            if ([model.value isEqualToString:departmentId]) {
                currendIndex = idx;
            }
        }
    }];
    
    __weak typeof(self) weakSelf = self;
    [ActionSheetStringPicker showPickerWithTitle:@"选择单位"
                                            rows:rows
                                initialSelection:currendIndex
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           [weakSelf departmentSelected:selectedIndex tag:tag];
                                       } cancelBlock:nil
                                          origin:self.view];
}

- (void)departmentSelected:(NSInteger)selectedIndex tag:(NSInteger)tag {
    ISSTaskDepartmentModel *model = [[ISSTaskDepartmentModel shareInstance].dataList objectAtIndex:selectedIndex];
    
    switch (tag) {
        case 2:
            [self getStatMonthUserWithDepartmentId:model.value];
            break;
            
        case 3:
            [self getStatMonthTaskWithDepartmentId:model.value];
            break;
            
        default:
            break;
    }
}

// 选择2个部门

- (void)showDoubleDepartment:(NSArray *)departmentIndexArray tag:(NSInteger)tag {
    NSMutableArray *rows = @[].mutableCopy;
    [[ISSTaskDepartmentModel shareInstance].dataList enumerateObjectsUsingBlock:^(ISSTaskDepartmentModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.content.length > 0) {
            [rows addObject:model.content];
        }
    }];
    
    __weak typeof(self) weakSelf = self;
    [PopupPickerControl setCellClass:[PopupCustomMenuCell class]];
    [PopupPickerControl showWithTitle:@"请选择两个部门"
                           WithTitles:rows
                         defaultIndex:departmentIndexArray
                        selectedBlock:^(NSArray *indexs) {
                            [weakSelf departmentArraySelected:indexs tag:tag];
                        }];
}

- (void)departmentArraySelected:(NSArray *)selectedIndexArray tag:(NSInteger)tag {
    switch (tag) {
        case 4:
            [self getStatTaskCompareWithDepartmentIndexArray:selectedIndexArray];
            break;
            
        case 5:
            [self getStatMonthReportWithDepartmentIndexArray:selectedIndexArray];
            break;
            
        default:
            break;
    }
}

#pragma mark 巡查单位任务排名

- (void)getTotalTask {
    [self getTotalTaskWithDate:_totalTaskView.date];
}

- (void)getTotalTaskWithDate:(NSDate *)date {
    _totalTaskView.date = date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM";
    NSString *dateString = [formatter stringFromDate:date];
    
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            NSArray *dataList = [ISSStatTotalTaskModel arrayOfModelsFromDictionaries:(NSArray *)result error:nil];
            [weakSelf reloadStatTotalTask:dataList];
        }
    }];
    [request getStatTotalTask:dateString];
}

- (void)reloadStatTotalTask:(NSArray *)dataList {
    // 巡查单位任务排名图，请根据任务总量大小（由多到少），从上到下排列单位
    NSArray *array = [dataList sortedArrayUsingComparator:^NSComparisonResult(ISSStatTotalTaskModel *p1, ISSStatTotalTaskModel *p2){
        return [p2.offDecimalNumber compare:p1.offDecimalNumber];
    }];
    if (array.count > 5) {
        array = [array subarrayWithRange:NSMakeRange(0, 5)];
    }
    
    _totalTaskView.dataList = array;
}

#pragma mark 单位月度人员任务完成情况排名

- (void)getStatMonthUser {
    [self getStatMonthUserWithDate:_monthUserView.date withDepartmentId:_monthUserView.departmentId];
}

- (void)getStatMonthUserWithDate:(NSDate *)date {
    [self getStatMonthUserWithDate:date withDepartmentId:_monthUserView.departmentId];
}

- (void)getStatMonthUserWithDepartmentId:(NSString *)departmentId {
    [self getStatMonthUserWithDate:_monthUserView.date withDepartmentId:departmentId];
}

- (void)getStatMonthUserWithDate:(NSDate *)date withDepartmentId:(NSString *)departmentId {
    _monthUserView.date = date;
    _monthUserView.departmentId = departmentId;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM";
    NSString *dateString = [formatter stringFromDate:date];
    
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            NSArray *dataList = [ISSStatMonthUserModel arrayOfModelsFromDictionaries:(NSArray *)result error:nil];
            [weakSelf reloadStatMonthUser:dataList];
        }
    }];
    [request getStatMonthUser:dateString departmentId:departmentId];
}

- (void)reloadStatMonthUser:(NSArray *)dataList {
    // 单位月度人员任务完成情况排名图默认 显示完成数量总量前5名的人员，从大到小排列
    NSMutableArray *array = [dataList sortedArrayUsingComparator:^NSComparisonResult(ISSStatMonthUserModel *p1, ISSStatMonthUserModel *p2){
        return [p2.offCountDecimalNumber compare:p1.offCountDecimalNumber];
    }].mutableCopy;
    if (array.count > 5) {
        array = [array subarrayWithRange:NSMakeRange(0, 5)].mutableCopy;
    } else {
        NSInteger addCount = 5 - array.count;
        for (NSInteger i = 0; i < addCount; i++) {
            ISSStatMonthUserModel *m = [[ISSStatMonthUserModel alloc] init];
            m.user = [[ISSTaskPeopleModel alloc] init];
            [array addObject:m];
        }
    }
    
    _monthUserView.dataList = array;
}

#pragma mark 单位月度任务量

- (void)getStatMonthTask {
    [self getStatMonthTaskWithDate:_monthTaskView.date withDepartmentId:_monthTaskView.departmentId];
}

- (void)getStatMonthTaskWithDate:(NSDate *)date {
    [self getStatMonthTaskWithDate:date withDepartmentId:_monthTaskView.departmentId];
}

- (void)getStatMonthTaskWithDepartmentId:(NSString *)departmentId {
    [self getStatMonthTaskWithDate:_monthTaskView.date withDepartmentId:departmentId];
}

- (void)getStatMonthTaskWithDate:(NSDate *)date withDepartmentId:(NSString *)departmentId {
    _monthTaskView.date = date;
    _monthTaskView.departmentId = departmentId;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM";
    NSString *dateString = [formatter stringFromDate:date];
    
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            ISSStatMonthTaskGroupModel *model = [[ISSStatMonthTaskGroupModel alloc] initWithDictionary:result error:nil];
            [weakSelf reloadStatMonthTask:model];
        }
    }];
    [request getStatMonthTask:dateString departmentId:departmentId];
}

- (void)reloadStatMonthTask:(ISSStatMonthTaskGroupModel *)model {
    _monthTaskView.dataModel = model;
}

#pragma mark 单位月度任务量对比

- (void)getStatTaskCompare {
    [self getStatTaskCompareWithDate:_taskCompareView.date withDepartmentId:_taskCompareView.departmentIndexArray];
}

- (void)getStatTaskCompareWithDate:(NSDate *)date {
    [self getStatTaskCompareWithDate:date withDepartmentId:_taskCompareView.departmentIndexArray];
}

- (void)getStatTaskCompareWithDepartmentIndexArray:(NSArray *)departmentIndexArray {
    [self getStatTaskCompareWithDate:_taskCompareView.date withDepartmentId:departmentIndexArray];
}

- (void)getStatTaskCompareWithDate:(NSDate *)date withDepartmentId:(NSArray *)departmentIndexArray {
    if (departmentIndexArray.count != 2 || [ISSTaskDepartmentModel shareInstance].dataList.count < 2) {
        return;
    }
    
    _taskCompareView.date = date;
    _taskCompareView.departmentIndexArray = departmentIndexArray;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSMutableArray *ids = @[].mutableCopy;
    for (NSNumber *num in departmentIndexArray) {
        ISSTaskDepartmentModel *model = [[ISSTaskDepartmentModel shareInstance].dataList objectAtIndex:[num integerValue]];
        [ids addObject:model.value];
    }
    
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            NSMutableArray *dataList = @[].mutableCopy;
            NSArray *list = [result objectForKey:@"list"];
            [list enumerateObjectsUsingBlock:^(NSArray *array, NSUInteger idx, BOOL * _Nonnull stop) {
                NSArray *modelArray = [ISSStatMonthTaskModel arrayOfModelsFromDictionaries:array error:nil];
                [dataList addObject:modelArray];
                
                for (ISSStatMonthTaskModel *obj in modelArray) {
                    if (obj.departmentId.length == 0) {
                        obj.departmentId = [ids objectAtIndex:idx];
                    }
                }
            }];
            [weakSelf reloadStatTaskCompare:dataList];
        }
    }];
    [request getStatTaskCompare:dateString departmentIds:ids];
}

- (void)reloadStatTaskCompare:(NSArray *)dataList {
    _taskCompareView.dataList = dataList;
}

#pragma mark 单位月度报告量

- (void)getStatMonthReport {
    [self getStatMonthReportWithDate:_monthReportView.date withDepartmentId:_monthReportView.departmentIndexArray];
}

- (void)getStatMonthReportWithDate:(NSDate *)date {
    [self getStatMonthReportWithDate:date withDepartmentId:_monthReportView.departmentIndexArray];
}

- (void)getStatMonthReportWithDepartmentIndexArray:(NSArray *)departmentIndexArray {
    [self getStatMonthReportWithDate:_monthReportView.date withDepartmentId:departmentIndexArray];
}

- (void)getStatMonthReportWithDate:(NSDate *)date withDepartmentId:(NSArray *)departmentIndexArray {
    if (departmentIndexArray.count != 2 || [ISSTaskDepartmentModel shareInstance].dataList.count < 2) {
        return;
    }
    
    _monthReportView.date = date;
    _monthReportView.departmentIndexArray = departmentIndexArray;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSMutableArray *ids = @[].mutableCopy;
    for (NSNumber *num in departmentIndexArray) {
        ISSTaskDepartmentModel *model = [[ISSTaskDepartmentModel shareInstance].dataList objectAtIndex:[num integerValue]];
        [ids addObject:model.value];
    }
    
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            NSMutableArray *dataList = @[].mutableCopy;
            NSArray *list = [result objectForKey:@"data"];
            [list enumerateObjectsUsingBlock:^(NSArray *array, NSUInteger idx, BOOL * _Nonnull stop) {
                NSArray *modelArray = [ISSStatMonthTaskModel arrayOfModelsFromDictionaries:array error:nil];
                [dataList addObject:modelArray];
                
                for (ISSStatMonthTaskModel *obj in modelArray) {
                    if (obj.departmentId.length == 0) {
                        obj.departmentId = [ids objectAtIndex:idx];
                    }
                }
            }];
            [weakSelf reloadStatMonthReport:dataList];
        }
    }];
    [request getStatMonthReport:dateString departmentIds:ids];
}

- (void)reloadStatMonthReport:(NSArray *)dataList {
    _monthReportView.dataList = dataList;
}

@end
