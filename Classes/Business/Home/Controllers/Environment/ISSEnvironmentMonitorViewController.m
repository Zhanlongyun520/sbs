//
//  ISSEnvironmentMonitorViewController.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSEnvironmentMonitorViewController.h"
#import "ISSEnvironmentListViewController.h"
#import "ISSBarChartTableViewCell.h"
#import "ISSPieChartTableViewCell.h"
#import "ISSLineChartTableViewCell.h"
#import "ISSCarMonitorHeaderView.h"

#import "ActionSheetStringPicker.h"
#import "NetworkRequest.h"
#import "PopupPickerControl.h"
#import "PopupCustomMenuCell.h"

@interface ISSEnvironmentMonitorViewController ()

@property (nonatomic, strong) NSArray *allDataSource;
@property (nonatomic, strong) NSArray *archs;

@end

@implementation ISSEnvironmentMonitorViewController

static NSString * const tableReuseIdentifier = @"Cell";
static NSString * const tableReuseIdentifier1 = @"Cell1";
static NSString * const tableReuseIdentifier2 = @"Cell2";
static NSString * const tableReuseIdentifier3 = @"Cell3";
static NSString * const tableReuseIdentifier4 = @"Cell4";

static NSString * const tableHeaderViewReuseIdentifier = @"HeaderView";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"环境监控";
    self.isHiddenTabBar = YES;
    
    [self navigationSetUp];
    
    //注册tableView控件
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableReuseIdentifier];
    [_tableView registerClass:[ISSBarChartTableViewCell class] forCellReuseIdentifier:tableReuseIdentifier1];
    [_tableView registerClass:[ISSPieChartTableViewCell class] forCellReuseIdentifier:tableReuseIdentifier2];
    [_tableView registerClass:[ISSLineChartTableViewCell class] forCellReuseIdentifier:tableReuseIdentifier3];
    [_tableView registerClass:[ISSLineChartTableViewCell class] forCellReuseIdentifier:tableReuseIdentifier4];
    
    [_tableView registerClass:[ISSCarMonitorHeaderView class] forHeaderFooterViewReuseIdentifier:tableHeaderViewReuseIdentifier];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    NSDate *date = [NSDate date];
    
    NSDictionary *dict1 = @{@"headTitle":@"区域月度综合排名",
                            @"date":date, @"btnTitles":@[@"AQI"], @"selectedIndex":@[@(0)],
                            @"dataSource":@{@"AQI":@[]},
                            };
    NSDictionary *dict2 = @{@"headTitle":@"优良天数占比",
                            @"date":date, @"btnTitles":@[], @"selectedIndex":@[@(0)],
                            @"dataSource":@[],
                            };
    NSDictionary *dict3 = @{@"headTitle":@"AQI变化趋势同期对比",
                            @"date":date, @"btnTitles":@[], @"selectedIndex":@[@(0)],
                            @"dataSource":@[],
                            };
    NSDictionary *dict4 = @{@"headTitle":@"AQI变化趋势区域对比",
                            @"date":date, @"btnTitles":@[@"",@""], @"selectedIndex":@[@(0), @(1)],
                            @"dataSource":@[],
                            };
    
    _allDataSource = @[dict1.mutableCopy, dict2.mutableCopy, dict3.mutableCopy, dict4.mutableCopy];
    
    
    [self getDataWithIndex:0 completion:^{
        [self getDataWithIndex:1 completion:^{
            [self getDataWithIndex:2 completion:^{
                [self getDataWithIndex:3 completion:^{
                    
                    [_tableView reloadData];
                }];
            }];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)listButton {
    ISSEnvironmentListViewController * environmentVC = [[ISSEnvironmentListViewController alloc]init];
    [self.navigationController pushViewController:environmentVC animated:YES];
}

- (void)navigationSetUp {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 19, 19);
    [rightBtn setImage:[UIImage imageNamed:@"environmentlist"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(listButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)getDataWithIndex:(NSInteger)index completion:(dispatch_block_t)completion {
    NSMutableDictionary *mDict = self.allDataSource[index];
    NSDate *date = mDict[@"date"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM";
    NSString *dateString = [formatter stringFromDate:date];
    
    __block  NSString *archId = _archs.firstObject[@"archId"] ?: @"";
    
    NSMutableArray *btnTitles = @[].mutableCopy;
    [_archs enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        [btnTitles addObject:dict[@"archName"] ?: @""];
    }];
    mDict[@"btnTitles"] = btnTitles ?: @[];
    
    NetworkRequest *request = [[NetworkRequest alloc] init];
    switch (index) {
        case 0:
        {
            [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:result];
                [dict removeObjectForKey:@"archs"];
                
                //默认显示AQI
                __block NSInteger selectedIndex = 0;
                NSArray *btnTitles = [dict allKeys] ?: @[];
                [btnTitles enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([str isEqualToString:@"AQI"]) {
                        selectedIndex = idx;
                    }
                }];
                
                NSArray *arr = [dict objectForKey:@"AQI"];
                if (arr && [arr isKindOfClass:[NSArray class]]) {
                    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                        return [obj2[@"data"] integerValue] > [obj1[@"data"] integerValue];
                    }];
                    [dict setObject:arr forKey:@"AQI"];
                }
                
                mDict[@"dataSource"] = dict ?: @{};
                mDict[@"btnTitles"] = btnTitles;
                mDict[@"selectedIndex"] = @[@(selectedIndex)];

                //可选路段
                NSArray *archs = result[@"archs"];
                _archs = archs;
                
                NSArray *datas = dict[btnTitles[selectedIndex]];
                //按流量从多到少排序
                datas = [datas sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    return [obj2[@"data"] integerValue] > [obj1[@"data"] integerValue];
                }];
                NSDictionary *maxDict = datas.firstObject; //AQI数值最大的一个
                id maxArchId = maxDict[@"archId"];
                
                _archs = datas;
                
                [_archs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj[@"archId"] isEqual:maxArchId]) {
                        selectedIndex = idx;
                    }
                }];
                
                NSString *archId1 = [[arr objectAtIndex:0] objectForKey:@"archId"];
                NSString *archId2 = [[arr objectAtIndex:1] objectForKey:@"archId"];
                __block NSInteger archId1Index = 0;
                __block NSInteger archId2Index = 0;
                [_archs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj[@"archId"] isEqual:archId1]) {
                        archId1Index = idx;
                    } else if ([obj[@"archId"] isEqual:archId2]) {
                        archId2Index = idx;
                    }
                }];
                
                NSMutableDictionary *mDict1 = self.allDataSource[1];
                NSMutableDictionary *mDict2 = self.allDataSource[2];
                NSMutableDictionary *mDict3 = self.allDataSource[3];
                mDict1[@"selectedIndex"] = @[@(selectedIndex)];
                mDict2[@"selectedIndex"] = @[@(selectedIndex)];
                mDict3[@"selectedIndex"] = @[@(archId1Index), @(archId2Index)];

                
                if (completion) {
                    completion();
                }
            }];
            [request getEnvironmentRank:@"1" dateTime:dateString];
        }
            break;
         case 1:
        {
            [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
                NSArray *array = (NSArray *)result;

                mDict[@"dataSource"] = array ?: @[];
                
                if (completion) {
                    completion();
                }
            }];
            [request getEnvironmentDaysProportion:archId dateTime:dateString];
        }
            break;
            case 2:
        {
            [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
                mDict[@"dataSource"] = result ?: @{};
                
                if (completion) {
                    completion();
                }
            }];
            [request getEnvironmentComparison:archId dateTime:dateString type:@(1)];
        }
            break;
            case 3:
        {
            [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
                NSArray *array = (NSArray *)result ?: @[];
                NSMutableDictionary *temp = @{@"currentMonth":array}.mutableCopy;
                
                //请求对比
                NetworkRequest *request1 = [[NetworkRequest alloc] init];
                [request1 completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
                    NSArray *array1 = (NSArray *)result ?: @[];
                    [temp setObject:array1 forKey:@"beforeMonth"];
                    
                    mDict[@"dataSource"] = temp;
                    
                    if (completion) {
                        completion();
                    }
                }];
                NSInteger selectedIndex1 = [((NSArray *)mDict[@"selectedIndex"]).lastObject integerValue];
                
                NSString *ontherArchId = _archs[selectedIndex1] [@"archId"];
                [request1 getEnvironmentComparison:ontherArchId dateTime:dateString type:@(0)];
                
            }];
            [request getEnvironmentComparison:archId dateTime:dateString type:@(0)];
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *mDict = self.allDataSource[indexPath.section];
    
    id dataSource = mDict[@"dataSource"];
    NSArray *btnTitles = mDict[@"btnTitles"];
    NSInteger selectedIndex = [((NSArray *)mDict[@"selectedIndex"]).firstObject integerValue];
    
    if (indexPath.section == 0) {
        if (btnTitles.count > 0 && ((NSDictionary *)dataSource).count > 0) {
            NSString *btnTitle = btnTitles[selectedIndex];
            NSArray *array = dataSource[btnTitle];
            
            if (array.count > 0) {
                return array.count * 50;
            }
        }
        return 294;
    }
    if (indexPath.section == 1) {
        return 320;
    }
    return 280;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.allDataSource.count;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    
    NSDictionary *mDict = self.allDataSource[section];
    
    id dataSource = mDict[@"dataSource"];
    NSDate *date = mDict[@"date"];
    NSArray *btnTitles = mDict[@"btnTitles"];
    NSInteger selectedIndex = [((NSArray *)mDict[@"selectedIndex"]).firstObject integerValue];
    

    switch (section) {
        case 0:
        {
            ISSBarChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableReuseIdentifier1 forIndexPath:indexPath];

            NSArray *array = @[];
            NSString *btnTitle = @"请选择";
            
            if (btnTitles.count > 0 && ((NSDictionary *)dataSource).count > 0) {
                btnTitle = btnTitles[selectedIndex];
                array = dataSource[btnTitle];
            }
            
            [cell fillChatDataSource:array];
            
            NSString *dateString = [cell formatterBtnTitle:date type:0];
            [cell.timeButton setTitle:dateString forState:UIControlStateNormal];
            [cell.choiceButton setTitle:btnTitle forState:UIControlStateNormal];
            
            [self cellBtnAction:mDict cell:cell section:section];
            
            return cell;
        }
            break;
            case 1:
        {
            ISSPieChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableReuseIdentifier2 forIndexPath:indexPath];
            
            [cell fillChatDataSource:dataSource];

            NSString *btnTitle = @"选择路段";
            if (btnTitles.count > 0) {
                btnTitle = btnTitles[selectedIndex];
            }

            NSString *dateString = [cell formatterBtnTitle:date type:0];
            [cell.timeButton setTitle:dateString forState:UIControlStateNormal];
            [cell.choiceButton setTitle:btnTitle forState:UIControlStateNormal];
            
            [self cellBtnAction:mDict cell:cell section:section];
            
            return cell;
        }
            break;
            case 2:
        {
            ISSLineChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableReuseIdentifier3 forIndexPath:indexPath];
            
            [cell fillChatDataSource:dataSource];
            
            NSString *btnTitle = @"选择路段";
            if (btnTitles.count > 0) {
                btnTitle = btnTitles[selectedIndex];
            }
            
            NSString *dateString = [cell formatterBtnTitle:date type:0];
            [cell.timeButton setTitle:dateString forState:UIControlStateNormal];
            [cell.choiceButton setTitle:btnTitle forState:UIControlStateNormal];
            
            [self cellBtnAction:mDict cell:cell section:section];
            
            return cell;
        }
            break;
            case 3:
        {
            ISSLineChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableReuseIdentifier3 forIndexPath:indexPath];
            
            NSArray *archs = @[];
            NSInteger selectedIndex1 = [((NSArray *)mDict[@"selectedIndex"]).lastObject integerValue];
            
            if (_archs.count > 1) {
                NSString *archName = _archs[selectedIndex] [@"archName"];
                NSString *ontherArchName = _archs[selectedIndex1] [@"archName"];
                
                archs = @[archName, ontherArchName];
            }

            NSDictionary *newDataSource;
            if ([dataSource isKindOfClass:[NSDictionary class]]) {
                newDataSource = @{@"beforeMonth": [dataSource objectForKey:@"currentMonth"],
                                  @"currentMonth": [dataSource objectForKey:@"beforeMonth"]
                                  };
            } else {
                newDataSource = dataSource;
            }
            
            [cell fillChatDataSource:@{@"archs":archs, @"data":newDataSource}];
            
            [cell.choiceButton setTitle:@"选择对比" forState:UIControlStateNormal];
            
            NSString *dateString = [cell formatterBtnTitle:date type:0];
            [cell.timeButton setTitle:dateString forState:UIControlStateNormal];
            [self cellBtnAction:mDict cell:cell section:section];
            
            return cell;
        }
            break;
        default:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableReuseIdentifier forIndexPath:indexPath];
            return cell;
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 38.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ISSCarMonitorHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:tableHeaderViewReuseIdentifier];
    
    NSDictionary *mDict = self.allDataSource[section];
    NSString *headTitle = mDict[@"headTitle"];
    
    headView.titleLabel.text = headTitle;
    
    return headView;
}

- (void)cellBtnAction:(NSDictionary *)mDict cell:(ISSBaseChatTableViewCell *)cell section:(NSInteger)section {
    cell.btnAction = ^(ISSBaseChatTableViewCell *innerCell, UIButton *btn, NSDate *date) {
        if ([btn isEqual:innerCell.timeButton]) {
            [mDict setValue:date forKey:@"date"];
            
            [self getDataWithIndex:section completion:^{
                [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:section]]
                                  withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
        
        if ([btn isEqual:innerCell.choiceButton]) {
            NSArray *btnTitles = mDict[@"btnTitles"];
            
            [self choiceButtonActionSection:btnTitles section:section];
        }
    };
}

- (void)choiceButtonActionSection:(NSArray *)btnTitles section:(NSInteger)section {
    NSMutableDictionary *mDict = self.allDataSource[section];
    NSInteger currentIndex = [((NSArray *)mDict[@"selectedIndex"]).firstObject integerValue];
    
    if (section == 3) {
        NSInteger selectedIndex = [((NSArray *)mDict[@"selectedIndex"]).firstObject integerValue];
        NSInteger selectedIndex1 = [((NSArray *)mDict[@"selectedIndex"]).lastObject integerValue];

        [PopupPickerControl setCellClass:[PopupCustomMenuCell class]];
        [PopupPickerControl showWithTitle:@"选择对比"
                               WithTitles:btnTitles
                             defaultIndex:@[@(selectedIndex), @(selectedIndex1)]
                            selectedBlock:^(NSArray *indexs) {
                                if (indexs.count > 0) {
                                    NSMutableDictionary *mDict = self.allDataSource[section];
                                    mDict[@"selectedIndex"] = indexs;
                                    
                                    [self getDataWithIndex:section completion:^{
                                        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:section]]
                                                          withRowAnimation:UITableViewRowAnimationNone];
                                    }];
                                }

                            }];
        
        return;
    }
    __weak typeof(self) weakSelf = self;
    [ActionSheetStringPicker showPickerWithTitle:@"选择路段"
                                            rows:btnTitles
                                initialSelection:currentIndex
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           [weakSelf alertBtnSelectedAction:selectedIndex section:section];
                                       } cancelBlock:nil
                                          origin:self.view];
}

- (void)alertBtnSelectedAction:(NSInteger)index section:(NSInteger)section {
    NSMutableDictionary *mDict = self.allDataSource[section];
    mDict[@"selectedIndex"] = @[@(index)];
    
    if (section!=0) {
        [self getDataWithIndex:section completion:^{
            [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:section]]
                              withRowAnimation:UITableViewRowAnimationNone];
        }];
    } else {
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:section]]
                          withRowAnimation:UITableViewRowAnimationNone];
    }

}

@end
