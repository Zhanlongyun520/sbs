//
//  ISSPlainAddViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/15.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainCreateViewController.h"
#import "ISSPlainPendingWeekView.h"
#import "ISSPlainPendingHeaderView.h"
#import "Masonry.h"
#import "PGDatePicker.h"
#import "ISSPlainAddViewController.h"
#import "ISSLoginUserModel.h"
#import "ISSPlainWeekListCell.h"
#import "ISSPlainListModel.h"

@interface ISSPlainCreateViewController () <PGDatePickerDelegate>
{
    UIButton *_titleButton;
    ISSPlainPendingWeekView *_weekView;
    
    NSInteger _currentPage;
    NSMutableArray *_dataArray;
    
    UIButton *_submitButton;
}
@end

@implementation ISSPlainCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHiddenTabBar = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"task-list-add"] style:UIBarButtonItemStyleDone target:self action:@selector(showAdd)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    _titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _titleButton.frame = CGRectMake(0, 0, 100, 44);
    _titleButton.tintColor = [UIColor whiteColor];
    [_titleButton addTarget:self action:@selector(showDatePicker) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = _titleButton;
    
    ISSPlainPendingHeaderView *headerView = [[ISSPlainPendingHeaderView alloc] init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.height.equalTo(@85);
    }];
    
    __weak typeof(self) weakSelf = self;
    _weekView = [[ISSPlainPendingWeekView alloc] init];
    _weekView.layer.cornerRadius = 18;
    _weekView.textColor = [UIColor darkTextColor];
    _weekView.previousWeekBlock = ^(NSDate *date) {
        [weakSelf getPreviousWeek:date];
    };
    _weekView.nextWeekBlock = ^(NSDate *date) {
        [weakSelf getNextWeek:date];
    };
    [headerView addSubview:_weekView];
    [_weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.right.equalTo(@-8);
        make.height.equalTo(@36);
        make.bottom.equalTo(@-10);
    }];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    submitButton.backgroundColor = [UIColor colorWithRed:0.23 green:0.37 blue:0.82 alpha:1.00];
    submitButton.tintColor = [UIColor whiteColor];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    submitButton.hidden = YES;
    [submitButton setTitle:@"提交审批" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitToApprove) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@120);
        make.height.equalTo(@44);
        make.bottom.equalTo(@-20);
        make.centerX.equalTo(self.view);
    }];
    _submitButton = submitButton;
    
    _dataArray = @[].mutableCopy;
    
    [_tableView removeFromSuperview];
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    [_tableView registerClass:[ISSPlainWeekListCell class] forCellReuseIdentifier:@"ISSPlainWeekListCell"];
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(_weekView.mas_bottom).offset(22);
        make.bottom.equalTo(submitButton.mas_top).offset(-20);
    }];
    
    NSArray *arr = [self getStartEndTime];
    NSString *startDate = [arr firstObject];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [formatter dateFromString:startDate];
    
    [self setWeekDate:date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ISSTaskListModel *model = [_dataArray objectAtIndex:indexPath.row];
    
    ISSPlainWeekListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSPlainWeekListCell" forIndexPath:indexPath];
    cell.model = model;
    cell.statusImageView.backgroundColor = [model taskStatusColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark 处理日期

- (void)showDatePicker {
    PGDatePicker *datePicker = [[PGDatePicker alloc] init];
    datePicker.delegate = self;
    [datePicker showWithShadeBackgroud];
    datePicker.datePickerType = PGPickerViewType3;
    datePicker.datePickerMode = PGDatePickerModeYearAndMonth;
    datePicker.titleLabel.text = @"请选择时间";
    datePicker.tag = 100;
}

#pragma PGDatePickerDelegate

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    if (datePicker.tag == 100) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *date = [calendar dateFromComponents:dateComponents];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM";
        NSString *d = [formatter stringFromDate:date];
        d = [NSString stringWithFormat:@"%@-01", d];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSDate *dt = [formatter dateFromString:d];
        
        [self setWeekFromTitle:dt];
    }
}

- (void)setWeekFromTitle:(NSDate *)date {
    [self setWeekDate:date];
}

- (void)getPreviousWeek:(NSDate *)date {
    NSDate *dt = [NSDate dateWithTimeInterval:-24*7*60*60 sinceDate:date];
    [self setWeekDate:dt];
}

- (void)getNextWeek:(NSDate *)date {
    NSDate *dt = [NSDate dateWithTimeInterval:24*7*60*60 sinceDate:date];
    [self setWeekDate:dt];
}

- (void)setWeekDate:(NSDate *)date {
    _weekView.currentDate = date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月";
    NSString *dString = [formatter stringFromDate:date];
    
    NSString *title = [NSString stringWithFormat:@"%@ ▼", dString];
    NSDictionary *attribs = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]};
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedText setAttributes:attribs range:NSMakeRange(title.length - 2, 2)];
    [_titleButton setAttributedTitle:attributedText forState:UIControlStateNormal];
    
    [self refreshData];
}

- (void)showAdd {
    ISSPlainAddViewController *viewController = [[ISSPlainAddViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSArray *)getStartEndTime {
    NSDate *today = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *startDate;
    NSString *endDate;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:today];
    NSInteger week = [comps weekday];
    
    week -= 1; // 周一是第一天
    for (NSInteger i = 0; i < 7; i++) {
        NSDate *d = [today dateByAddingTimeInterval:-(week - 1 - i) * 24 * 60 * 60];
        switch (i) {
            case 0:
                startDate = [formatter stringFromDate:d];
                break;
                
            case 6:
                endDate = [formatter stringFromDate:d];
                break;
                
            default:
                break;
        }
    }
    
    return @[startDate, endDate];
}

- (void)submitToApprove {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            [self.view makeToast:@"提交成功"];
        }
    }];
    [request addPlain:[formatter stringFromDate:_weekView.startDate] taskTimeEnd:[formatter stringFromDate:_weekView.endDate]];
}

#pragma mark 获取数据

- (void)refreshData {
    _currentPage = 0;
    
    _tableView.mj_footer = nil;
    
    [self getData:YES];
}

- (void)getNextPage {
    _currentPage++;
    [self getData:NO];
}

- (void)getData:(BOOL)cleanData {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
        if (_tableView.mj_footer.isRefreshing) {
            [_tableView.mj_footer endRefreshing];
        }
        
        if (_currentPage == 0) {
            [_dataArray removeAllObjects];
        }
        
        if (success) {
            NSArray *array = [ISSTaskListModel arrayOfModelsFromDictionaries:(NSArray *)result error:nil];
            [_dataArray addObjectsFromArray:array];
            
//            NSInteger totolPage = [[result objectForKey:@"totalPages"] integerValue];
//
//            if (totolPage - 1 > _currentPage) {
//                if (!_tableView.mj_footer) {
//                    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getNextPage)];
//                }
//            } else {
//                _tableView.mj_footer = nil;
//            }

            [self showData];
        }
    }];
    [request getTaskDetailList:[formatter stringFromDate:_weekView.startDate] endTime:[formatter stringFromDate:_weekView.endDate] userId:[ISSLoginUserModel shareInstance].loginUser.id];
}

- (void)showData {
    [_tableView reloadData];
    
    BOOL showSubmitButton = NO;
    if (_dataArray.count == 0) {
        showSubmitButton = YES;
    } else {
        ISSTaskListModel *model = _dataArray.firstObject;
        if (model.planStatus == ISSPlainStatusPendingSubmit ||
            model.planStatus == ISSPlainStatusReturned) {
            
            showSubmitButton = YES;
        }
    }
    
    _submitButton.hidden = !showSubmitButton;
}

@end
