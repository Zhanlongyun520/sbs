//
//  ISSPlainAddViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainAddViewController.h"
#import "ISSPlainAddNameCell.h"
#import "ISSPlainAddLocationCell.h"
#import "ISSPlainAddLocationContentCell.h"
#import "ISSPlainAddPeopleCell.h"
#import "ISSPlainAddDateCell.h"
#import "ISSPlainAddTaskCell.h"
#import "PGDatePicker.h"
#import "ISSTaskPeopleViewController.h"
#import "ISSTaskLocationViewController.h"
#import "ISSTaskPeopleModel.h"
#import "ISSNewTaskAnnotation.h"
#import "NetworkRequest.h"

@interface ISSPlainAddViewController () <PGDatePickerDelegate>

@end

@implementation ISSPlainAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"新增巡查任务";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(doSubmit)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    if (!_addModel) {
        _addModel = [[ISSTaskAddModel alloc] init];
    }
    
    [_tableView registerClass:[ISSPlainAddNameCell class] forCellReuseIdentifier:@"ISSPlainAddNameCell"];
    [_tableView registerClass:[ISSPlainAddLocationCell class] forCellReuseIdentifier:@"ISSPlainAddLocationCell"];
    [_tableView registerClass:[ISSPlainAddLocationContentCell class] forCellReuseIdentifier:@"ISSPlainAddLocationContentCell"];
    [_tableView registerClass:[ISSPlainAddPeopleCell class] forCellReuseIdentifier:@"ISSPlainAddPeopleCell"];
    [_tableView registerClass:[ISSPlainAddDateCell class] forCellReuseIdentifier:@"ISSPlainAddDateCell"];
    [_tableView registerClass:[ISSPlainAddTaskCell class] forCellReuseIdentifier:@"ISSPlainAddTaskCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldTextChanged:(NSNotification *)notification {
    UITextField *textField = notification.object;
    NSString *text = textField.text;
    if (textField.tag == 100) {
        _addModel.taskName = text;
    }
}

- (void)textViewTextChanged:(NSNotification *)notification {
    UITextView *textView = notification.object;
    NSString *text = textView.text;
    if (textView.tag == 100) {
        _addModel.taskContent = text;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    switch (section) {
        case 0:
            count = 3;
            break;
            
        case 1:
            count = 2;
            break;
            
        case 2:
            count = 1;
            break;
            
        case 3:
            count = 1;
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
        if (indexPath.row == 0) {
            ISSPlainAddNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSPlainAddNameCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"任务名称";
            cell.textField.tag = 100;
            cell.textField.text = _addModel.taskName;
            
            theCell = cell;
        } else if (indexPath.row == 1) {
            ISSPlainAddLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSPlainAddLocationCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"任务地点";
            cell.valueLabel.text = @"请选择地点";
            
            theCell = cell;
        } else if (indexPath.row == 2) {
            ISSPlainAddLocationContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSPlainAddLocationContentCell" forIndexPath:indexPath];
            cell.removeBlock = ^(NSInteger index) {
                [weakSelf removeLocation:index];
            };
            cell.dataList = _addModel.positionArray;
            
            theCell = cell;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ISSPlainAddLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSPlainAddLocationCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"任务执行人员";
            cell.valueLabel.text = @"请选择";
            
            theCell = cell;
        } else if (indexPath.row == 1) {
            ISSPlainAddPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSPlainAddPeopleCell" forIndexPath:indexPath];
            cell.dataList = _addModel.peopleArray;
            
            theCell = cell;
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            
            ISSPlainAddDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSPlainAddDateCell" forIndexPath:indexPath];
            cell.showPickerBlock = ^(NSInteger tag) {
                [weakSelf showTimePicker:tag];
            };
            cell.keyLabel.text = @"起止时间";
            
            if (_addModel.startTime) {
                cell.startLabel.text = [formatter stringFromDate:_addModel.startTime];
            }
            if (_addModel.endTime) {
                cell.endLabel.text = [formatter stringFromDate:_addModel.endTime];
            }
            
            theCell = cell;
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            ISSPlainAddTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSPlainAddTaskCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"任务内容";
            cell.textView.tag = 100;
            cell.textView.text = _addModel.taskContent;
            
            theCell = cell;
        }
    }
    return theCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            [self showLocationPicker];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self showPeopleList];
        }
    }
}

#pragma mark 时间

- (void)showTimePicker:(NSInteger)tag {
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.delegate = self;
    [datePicker showWithShadeBackgroud];
    datePicker.datePickerType = PGPickerViewType2;
    datePicker.datePickerMode = PGDatePickerModeDateHourMinute;
    datePicker.titleLabel.text = @"请选择时间";
    datePicker.tag = 100 + tag;
    [datePicker setDate:tag == 0 ? _addModel.startTime : _addModel.endTime animated:YES];
}

#pragma PGDatePickerDelegate

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:dateComponents];
    
    if (datePicker.tag == 101) {
        _addModel.startTime = date;
    } else if (datePicker.tag == 102) {
        _addModel.endTime = date;
    }
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark 人员

- (void)showPeopleList {
    __weak typeof(self) weakSelf = self;
    ISSTaskPeopleViewController *viewController = [[ISSTaskPeopleViewController alloc] initWithStyle:UITableViewStylePlain];
    viewController.selectedArray = _addModel.peopleArray;
    viewController.selectedBlock = ^(NSArray *array) {
        [weakSelf showPeople:array];
    };
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)showPeople:(NSArray *)array {
    NSMutableArray *newArray = @[].mutableCopy;
    for (ISSTaskPeopleModel *model in array) {
        BOOL repeat = NO;
        for (ISSTaskPeopleModel *obj in _addModel.peopleArray) {
            if ([obj.id isEqualToString:model.id]) {
                repeat = YES;
                break;
            }
        }
        if (!repeat) {
            [newArray addObject:model];
        }
    }
    [_addModel.peopleArray addObjectsFromArray:newArray];
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark 地点

- (void)showLocationPicker {
    __weak typeof(self) weakSelf = self;
    ISSTaskLocationViewController *viewController = [[ISSTaskLocationViewController alloc] init];
    viewController.selectedBlock = ^(NSArray *array) {
        [weakSelf showLocation:array];
    };
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)showLocation:(NSArray *)array {
    [_addModel.positionArray addObjectsFromArray:array];
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)removeLocation:(NSInteger)index {
    [_addModel.positionArray removeObjectAtIndex:index];
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark 提交

- (void)doSubmit {
    NSString *tips = nil;
    if (_addModel.taskName.length == 0) {
        tips = @"请输入任务名称";
    } else if (_addModel.positionArray.count == 0) {
        tips = @"请选择任务地点";
    } else if (_addModel.peopleArray.count == 0) {
        tips = @"请选择任务执行人员";
    } else if (_addModel.startTime == nil) {
        tips = @"请选择开始时间";
    } else if (_addModel.endTime == nil) {
        tips = @"请选择结束时间";
    } else if (_addModel.taskContent.length == 0) {
        tips = @"请输入任务内容";
    }
    if (tips) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:tips];
        return;
    }
    
    NSMutableArray *positionArray = @[].mutableCopy;
    for (ISSNewTaskAnnotation *model in _addModel.positionArray) {
        NSDictionary *dic = @{@"position": model.title,
                              @"longitude": @(model.coordinate.longitude),
                              @"latitude": @(model.coordinate.latitude)
                              };
        [positionArray addObject:dic];
    }
    
    NSMutableArray *userArray = @[].mutableCopy;
    for (ISSTaskPeopleModel *model in _addModel.peopleArray) {
        NSDictionary *dic = @{@"id": model.id,
                              @"account": model.account
                              };
        [userArray addObject:dic];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [request submitTask:userArray
               taskName:_addModel.taskName
        patrolPositions:positionArray
          taskTimeStart:[formatter stringFromDate:_addModel.startTime]
            taskTimeEnd:[formatter stringFromDate:_addModel.endTime]
            taskContent:_addModel.taskContent];
}

@end
