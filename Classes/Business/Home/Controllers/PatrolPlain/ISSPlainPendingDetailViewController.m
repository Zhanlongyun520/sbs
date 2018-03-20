//
//  ISSPlainPendingDetailViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainPendingDetailViewController.h"
#import "ISSPlainPendingHeaderView.h"
#import "PGDatePicker.h"
#import "PGPickerView.h"
#import "ISSPlainPendingWeekView.h"
#import "ISSTaskListModel.h"
#import "ISSPlainWeekListCell.h"
#import "ISSTaskDetailViewController.h"
#import "ISSLoginUserModel.h"
#import "ISSPlainCreateViewController.h"

@interface ISSPlainPendingDetailViewController () <PGDatePickerDelegate>
{
    UIButton *_titleButton;
    ISSPlainPendingWeekView *_weekView;
    
    NSInteger _currentPage;
    NSMutableArray *_dataArray;
    
    NSMutableArray *_currentList;
    
    UIView *_bottomView;
}
@end

@implementation ISSPlainPendingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([ISSLoginUserModel shareInstance].privilegeCode.M_CPP) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"task-list-add"] style:UIBarButtonItemStyleDone target:self action:@selector(showAdd)];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    }
    
    _dataArray = @[].mutableCopy;
    _currentList = @[].mutableCopy;
    
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
    _weekView.previousWeekBlock = ^(NSDate *date) {
        [weakSelf getPreviousWeek:date];
    };
    _weekView.nextWeekBlock = ^(NSDate *date) {
        [weakSelf getNextWeek:date];
    };
    _weekView.clickDateBlock = ^(NSDate *date) {
        [weakSelf clickDate:date];
    };
    [headerView addSubview:_weekView];
    [_weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.right.equalTo(@-8);
        make.height.equalTo(@36);
        make.bottom.equalTo(@-10);
    }];
    
    BOOL showBottomView = NO;
    if ((_listModel.status == ISSPlainStatusPendingApprove &&
         [ISSLoginUserModel shareInstance].privilegeCode.M_CPPA) ||
        _listModel.status == ISSPlainStatusPendingSubmit ||
        _listModel.status == ISSPlainStatusReturned) {
        showBottomView = YES;
    }
    
    UIView *bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        if (showBottomView) {
            make.height.equalTo(@70);
        } else {
            make.height.equalTo(@0);
        }
    }];
    _bottomView = bottomView;
    
    [_tableView removeFromSuperview];
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    [_tableView registerClass:[ISSPlainWeekListCell class] forCellReuseIdentifier:@"ISSPlainWeekListCell"];
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(_weekView.mas_bottom).offset(22);
        make.bottom.equalTo(bottomView.mas_top);
    }];
    
    if (_listModel.status == ISSPlainStatusPendingApprove) {
        if ([ISSLoginUserModel shareInstance].privilegeCode.M_CPPA) {
            UIButton *approveButton = [UIButton buttonWithType:UIButtonTypeSystem];
            approveButton.backgroundColor = [UIColor colorWithRed:0.23 green:0.37 blue:0.82 alpha:1.00];
            approveButton.tintColor = [UIColor whiteColor];
            approveButton.layer.cornerRadius = 5;
            approveButton.layer.masksToBounds = YES;
            [approveButton setTitle:@"审批通过" forState:UIControlStateNormal];
            [approveButton addTarget:self action:@selector(doApprove) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:approveButton];
            [approveButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@120);
                make.height.equalTo(@44);
                make.centerY.equalTo(bottomView);
            }];
            
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
            backButton.backgroundColor = [UIColor colorWithRed:0.95 green:0.23 blue:0.24 alpha:1.00];
            backButton.tintColor = [UIColor whiteColor];
            backButton.layer.cornerRadius = 5;
            backButton.layer.masksToBounds = YES;
            [backButton setTitle:@"退回" forState:UIControlStateNormal];
            [backButton addTarget:self action:@selector(doReturn) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:backButton];
            [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@70);
                make.height.equalTo(approveButton);
                make.centerY.equalTo(bottomView);
            }];
            
            if ([ISSLoginUserModel shareInstance].privilegeCode.M_CPPA) {
                [approveButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(bottomView.mas_centerX).offset(-20);
                }];
                
                [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(approveButton.mas_left).offset(-15);
                }];
            }
        }
    } else if (_listModel.status == ISSPlainStatusPendingSubmit ||
               _listModel.status == ISSPlainStatusReturned) {
        
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [formatter dateFromString:_listModel.startDate];
    [self setWeekDate:date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _currentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ISSPlainWeekListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSPlainWeekListCell" forIndexPath:indexPath];
    cell.model = [_currentList objectAtIndex:indexPath.row];
    cell.statusImageView.backgroundColor = [_listModel getStatusColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ISSTaskListModel *model = [_currentList objectAtIndex:indexPath.row];
    
    ISSTaskDetailViewController *viewController = [[ISSTaskDetailViewController alloc] init];
    viewController.taskId = model.taskId;
    viewController.taskName = model.taskName;
    viewController.readonly = YES;
    [self.navigationController pushViewController:viewController animated:YES];
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

- (void)clickDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    [_currentList removeAllObjects];
    
    for (ISSTaskListModel *model in _dataArray) {
        NSDate *startDate = [formatter dateFromString:model.taskTimeStart];
        NSDate *endDate = [formatter dateFromString:model.taskTimeEnd];
        NSComparisonResult startResult = [startDate compare:date];
        NSComparisonResult endResult = [endDate compare:date];
        if (startResult != NSOrderedDescending && endResult != NSOrderedAscending) {
            [_currentList addObject:model];
        }
    }
    
    [_tableView reloadData];
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
            
            [_currentList setArray:_dataArray];
            
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
    [request getTaskDetailList:[formatter stringFromDate:_weekView.startDate] endTime:[formatter stringFromDate:_weekView.endDate] userId:_listModel.creator.id];
}

- (void)showData {
    _weekView.backgroundColor = [_listModel getStatusColor];
    
    [_tableView reloadData];
}

- (void)doApprove {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定巡查计划通过审批吗？"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"否"
                                                        style:UIAlertActionStyleDefault
                                                      handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"是"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          [weakSelf doApproveMethod];
                                                      }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)doApproveMethod {
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            [self.view makeToast:@"操作成功"];
            _bottomView.hidden = YES;
        }
    }];
    [request approvePlain:_listModel.id];
}

- (void)doReturn {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定巡查计划退回吗？"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"否"
                                                        style:UIAlertActionStyleDefault
                                                      handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"是"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          [weakSelf doReturnMethod];
                                                      }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)doReturnMethod {
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            [self.view makeToast:@"操作成功"];
            _bottomView.hidden = YES;
        }
    }];
    [request refusePlain:_listModel.id];
}

- (void)submitToApprove {
    
}

- (void)showAdd {
    ISSPlainCreateViewController *viewController = [[ISSPlainCreateViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
