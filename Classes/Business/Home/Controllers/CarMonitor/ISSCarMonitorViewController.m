//
//  ISSCarMonitorViewController.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSCarMonitorViewController.h"

#import "ISSHorizontalBarChartTableViewCell.h"
#import "ISSCubicLineChartTableViewCell.h"
#import "ISSDualLineChartTableViewCell.h"

#import "ISSCarMonitorHeaderView.h"
#import "HMSegmentedControl.h"

#import "ISSCarListViewController.h"
#import "NetworkRequest.h"
#import "MBProgressHUD.h"

#import "ActionSheetStringPicker.h"
#import "PopupPickerControl.h"
#import "PopupCustomMenuCell.h"

@interface ISSCarMonitorViewController ()

@property (nonatomic, strong) NSDictionary *headDataSource;

@property (nonatomic, strong) NSArray *flowRankList;
@property (nonatomic, strong) NSDictionary *flowContrastDict;
@property (nonatomic, strong) NSArray *flowContrastList;

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation ISSCarMonitorViewController

static NSString * const tableReuseIdentifier = @"Cell";
static NSString * const tableReuseIdentifier1 = @"Cell1";
static NSString * const tableReuseIdentifier2 = @"Cell2";
static NSString * const tableReuseIdentifier3 = @"Cell3";

static NSString * const tableHeaderViewReuseIdentifier = @"HeaderView";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"渣土车概况";
    self.isHiddenTabBar = YES;
    
    [self navigationSetUp];
    
    //注册tableView控件
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableReuseIdentifier];
    [_tableView registerClass:[ISSHorizontalBarChartTableViewCell class] forCellReuseIdentifier:tableReuseIdentifier1];
    [_tableView registerClass:[ISSCubicLineChartTableViewCell class] forCellReuseIdentifier:tableReuseIdentifier2];
    [_tableView registerClass:[ISSDualLineChartTableViewCell class] forCellReuseIdentifier:tableReuseIdentifier3];
    
    [_tableView registerClass:[ISSCarMonitorHeaderView class] forHeaderFooterViewReuseIdentifier:tableHeaderViewReuseIdentifier];
    _tableView.contentInset = UIEdgeInsetsMake(44, 0, 5, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //上部选择
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"月视图", @"日视图"]];
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl.selectionIndicatorHeight = 2.0;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.backgroundColor = ISSColorViewBg;
    segmentedControl.selectionIndicatorColor = IndicatorColorBlue;
    segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline],
                                             NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:ISSColorNavigationBar};
    segmentedControl.indexChangeBlock = ^(NSInteger index) {

        [self getAllDataSource];
    };
    [self.view addSubview:segmentedControl];
    _segmentedControl = segmentedControl;
    
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.equalTo(@44);
    }];

    [self getAllDataSource];
}

- (void)listButton {
    ISSCarListViewController * environmentVC = [[ISSCarListViewController alloc]init];
    [self.navigationController pushViewController:environmentVC animated:YES];
}

- (void)navigationSetUp {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 19, 19);
    [rightBtn setImage:[UIImage imageNamed:@"environmentlist"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(listButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)getAllDataSource {
    NSDate *date = [NSDate date];
    
    NSString *typeStr = self.segmentedControl.selectedSegmentIndex == 1 ? @"日" : @"月度";
    
    NSString *section0Title = [NSString stringWithFormat:@"路段渣土车%@流量排名", typeStr];
    NSString *section1Title = [NSString stringWithFormat:@"路段渣土车%@流量对比", typeStr];
    
    NSArray *titleString = @[section0Title,
                             section1Title,
                             @"渣土车流量路段对比"];
    NSMutableArray *dateArray = [NSMutableArray arrayWithArray:@[date, date, date]];
    NSMutableArray *choiceDatas = [NSMutableArray arrayWithArray:@[@"",
                                                                   @{@"name":@"中心城",
                                                                     @"id":@"2"},
                                                                   @[@{@"name":@"光谷五路",
                                                                       @"id":@"1"},
                                                                     @{@"name":@"光谷六路",
                                                                       @"id":@"2"}]
                                                                   ]
                                   ];
    
    _headDataSource = @{@"title" :titleString,
                        @"dateArray" : dateArray,
                        @"choiceDatas" : choiceDatas
                        };
    
    //分别请求
    [self getDataWithIndex:0 completion:^{
        if (self.flowRankList.count == 0) {
            [_tableView reloadData];
            return;
        }
        
        [_tableView reloadData];
        //获取到各个id后调用
        [self getDataWithIndex:1 completion:^{
            [_tableView reloadData];
        }];
        [self getDataWithIndex:2 completion:^{
            [_tableView reloadData];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getDataWithIndex:(NSInteger)index completion:(dispatch_block_t)completion {
    NetworkRequest *request = [[NetworkRequest alloc] init];
    
    NSDate *date = self.headDataSource[@"dateArray"] [index];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM";
    NSString *dateString = [formatter stringFromDate:date];
    
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateTimeString = [formatter stringFromDate:date];
    
    NSNumber *dateTimeType = self.segmentedControl.selectedSegmentIndex==1 ? @(0) : @(1);
    
    //渣土车流量路段对比
    if (index == 0) {
        [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
            if (success) {
                NSLog(@"%@",[ISSUtilityMethod objToJson:result]);
                NSArray *array = (NSArray *)result;
                
                //按流量从多到少排序
                _flowRankList = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    return [obj2[@"count"] integerValue] > [obj1[@"count"] integerValue];
                }];
                
                //获取到区域数据后，替换比较的对象，取前两位
                NSDictionary *dict = _flowRankList.firstObject[@"arch"];
                NSDictionary *dict1 = _flowRankList[1] [@"arch"];
                
                NSDictionary *idenx1Dict = @{@"id":dict[@"id"], @"name":dict[@"name"]};
                NSDictionary *idenx2Dict = @{@"id":dict1[@"id"], @"name":dict1[@"name"]};
                
                NSMutableArray *choiceDatas = self.headDataSource[@"choiceDatas"];
                [choiceDatas replaceObjectAtIndex:1 withObject:idenx1Dict];
                [choiceDatas replaceObjectAtIndex:2 withObject:@[idenx1Dict, idenx2Dict]];
            }
            completion();
        }];
        
        [request getDayFlow:dateTimeType parentId:@"1" timeMonth:dateString time:dateTimeString];
    }
    
    //渣土车月度流量排名
    if (index == 1) {
        [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
            NSLog(@"%@",[ISSUtilityMethod objToJson:result]);
            
            _flowContrastDict = result;

            completion();
        }];
        
        //获取到区域数据后，替换比较的对象
        NSDictionary *dict  = self.headDataSource[@"choiceDatas"] [index];
 
        NSNumber *archId = dict[@"id"];
        [request getArchMonthFlow:dateTimeType archId:archId timeMonth:dateString time:dateTimeString];
    }
    
    //渣土车月度流量路段对比
    if (index == 2) {
        [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
            NSLog(@"%@",[ISSUtilityMethod objToJson:result]);
            
            //对比的车流数组
            NSArray *mcFlows = result[@"mcFlows"];
            
            _flowContrastList = mcFlows;

            completion();
        }];
        
        NSArray *compareObjs = self.headDataSource[@"choiceDatas"] [index];
        
        NSArray *archIds = @[compareObjs.firstObject[@"id"],
                             compareObjs[1] [@"id"]];

        //    时间标记(0为日，1为月)， time当前时间， timeMonth当前月份， archIds对比的区域编号数组
        [request getAlarmData:dateTimeType archIds:archIds timeMonth:dateString time:dateTimeString];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (self.flowRankList.count > 0) {
            return 77 + self.flowRankList.count * 45;
        }
    }
    
    return 280;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 38.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *dateArray = self.headDataSource[@"dateArray"];
    
    switch (indexPath.section) {
        case 0:
        {
            ISSHorizontalBarChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableReuseIdentifier1 forIndexPath:indexPath];
            
            NSString *dateString = [cell formatterBtnTitle:dateArray[indexPath.section]
                                                      type:self.segmentedControl.selectedSegmentIndex];
            [cell.timeButton setTitle:dateString forState:UIControlStateNormal];
            
            cell.btnAction = ^(ISSBaseChatTableViewCell *innerCell, UIButton *btn, NSDate *date) {
                if ([btn isEqual:innerCell.timeButton]) {
                    [dateArray replaceObjectAtIndex:indexPath.section withObject:date];
                    
                    [self getDataWithIndex:0 completion:^{
                        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:indexPath.section]]
                                          withRowAnimation:UITableViewRowAnimationNone];
                    }];
      
                }
            };
                               
            [cell fillChatDataSource:self.flowRankList];
            
            return cell;
        }
            break;
        case 1:
        {
            ISSCubicLineChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableReuseIdentifier2 forIndexPath:indexPath];
            
            NSString *dateString = [cell formatterBtnTitle:dateArray[indexPath.section]
                                                      type:self.segmentedControl.selectedSegmentIndex];
            [cell.timeButton setTitle:dateString forState:UIControlStateNormal];
            
            NSDictionary *choiceDatas = self.headDataSource[@"choiceDatas"] [indexPath.section];
            NSString *choiceString = choiceDatas [@"name"];
            [cell.choiceButton setTitle:choiceString forState:UIControlStateNormal];
            
            cell.btnAction = ^(ISSBaseChatTableViewCell *innerCell, UIButton *btn, NSDate *date) {
                if ([btn isEqual:innerCell.timeButton]) {
                    [dateArray replaceObjectAtIndex:indexPath.section withObject:date];
                    
                    [self getDataWithIndex:1 completion:^{
                        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:indexPath.section]]
                                          withRowAnimation:UITableViewRowAnimationNone];
                    }];
                    
                }
                
                if ([btn isEqual:innerCell.choiceButton]) {
                    [self choiceButtonActionSection1:btn];
                }
            };
            
            [cell fillChatDataSource:self.flowContrastDict];
            
            return cell;
        }
            break;
        case 2:
        {
            ISSDualLineChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableReuseIdentifier3 forIndexPath:indexPath];
            
            NSString *dateString = [cell formatterBtnTitle:dateArray[indexPath.section]
                                                      type:self.segmentedControl.selectedSegmentIndex];
            [cell.timeButton setTitle:dateString forState:UIControlStateNormal];
            
            NSArray *choiceDatas = self.headDataSource[@"choiceDatas"] [indexPath.section];

            [cell.choiceButton setTitle:@"选择对比路段" forState:UIControlStateNormal];
            
            cell.btnAction = ^(ISSBaseChatTableViewCell *innerCell, UIButton *btn, NSDate *date) {
                if ([btn isEqual:innerCell.timeButton]) {
                    [dateArray replaceObjectAtIndex:indexPath.section withObject:date];
                    
                    [self getDataWithIndex:2 completion:^{
                        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:indexPath.section]]
                                          withRowAnimation:UITableViewRowAnimationNone];
                    }];
                }

                if ([btn isEqual:innerCell.choiceButton]) {
                    [self choiceButtonActionSection2:btn];
                }
            };
            
            [cell fillChatDataSource:@{@"compareObjs":choiceDatas ?: @[],
                                       @"datas":self.flowContrastList ?: @[]}];
            
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ISSCarMonitorHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:tableHeaderViewReuseIdentifier];
    headView.titleLabel.text = (self.headDataSource[@"title"]) [section];
    
    return headView;
}

- (void)choiceButtonActionSection1:(UIButton *)btn {
    NSMutableArray *btnTitles = @[].mutableCopy;
    
    __block NSInteger currentIndex = 0;
    [self.flowRankList enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *obj = dict [@"arch"];
        NSString *name = obj[@"name"];
        [btnTitles addObject:name];
        
        if ([name isEqualToString:btn.currentTitle]) {
            currentIndex = idx;
        }
    }];
    
    __weak typeof(self) weakSelf = self;
    [ActionSheetStringPicker showPickerWithTitle:@"选择路段"
                                            rows:btnTitles
                                initialSelection:currentIndex
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           [weakSelf btnSelectedAction:selectedIndex];
                                       } cancelBlock:nil
                                          origin:self.view];
  /*
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择路段"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [self.flowRankList enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *obj = dict [@"arch"];
        [alert addAction:[UIAlertAction actionWithTitle:obj[@"name"]
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    [self alertBtnAction:idx];
                                                }]];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    [root presentViewController:alert animated:YES completion:nil];
   */
}

- (void)btnSelectedAction:(NSInteger)index {
    NSDictionary *obj = self.flowRankList[index] [@"arch"];
    NSString *archId = obj[@"id"];
    NSString *name = obj[@"name"];
    
    NSMutableArray *choiceDatas = self.headDataSource[@"choiceDatas"];
    
    NSInteger section = 1;
    NSDictionary *idenx1Dict = @{@"id":archId,
                                 @"name":name};
    [choiceDatas replaceObjectAtIndex:section withObject:idenx1Dict];
    
    [self getDataWithIndex:1 completion:^{
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:section]]
                          withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)choiceButtonActionSection2:(UIButton *)btn {
    NSMutableArray *btnTitles = @[].mutableCopy;
    
    __block NSInteger firstIndex = 0, secondIndex = 1;
    
    NSInteger section = 2;
    NSArray *choiceDatas = self.headDataSource[@"choiceDatas"] [section];
    
    [self.flowRankList enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *obj = dict [@"arch"];
        NSString *name = obj[@"name"];
        [btnTitles addObject:name];
        
        if ([choiceDatas.firstObject[@"name"] isEqualToString:name]) {
            firstIndex = idx;
        }
        if ([choiceDatas.lastObject[@"name"] isEqualToString:name]) {
            secondIndex = idx;
        }
    }];
    
    [PopupPickerControl setCellClass:[PopupCustomMenuCell class]];
    [PopupPickerControl showWithTitle:@"选择对比"
                           WithTitles:btnTitles
                         defaultIndex:@[@(firstIndex), @(secondIndex)]
                        selectedBlock:^(NSArray *indexs) {
                            if (indexs.count > 0) {

                                NSDictionary *dict = self.flowRankList[[indexs.firstObject integerValue]] [@"arch"];
                                NSDictionary *dict1 = self.flowRankList[[indexs.lastObject integerValue]] [@"arch"];
                                
                                NSDictionary *idenx1Dict = @{@"id":dict[@"id"], @"name":dict[@"name"]};
                                NSDictionary *idenx2Dict = @{@"id":dict1[@"id"], @"name":dict1[@"name"]};
                                
                                NSMutableArray *choiceDatas = self.headDataSource[@"choiceDatas"];
                                [choiceDatas replaceObjectAtIndex:section withObject:@[idenx1Dict, idenx2Dict]];
                                
                                [self getDataWithIndex:section completion:^{
                                    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:section]]
                                                      withRowAnimation:UITableViewRowAnimationNone];
                                    
                                }];
                            }
                            
                        }];
}
/*
    NSString *title = [NSString stringWithFormat:@"%@\n\n\n\n\n\n\n\n\n", @"选择对比路段"];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];

    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [alert.view addSubview:pickerView];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                
                                                NSInteger row = [pickerView selectedRowInComponent:0];
                                                NSInteger row1 = [pickerView selectedRowInComponent:1];
                                                
                                                NSDictionary *dict = self.flowRankList[row] [@"arch"];
                                                NSDictionary *dict1 =  [self filterDatas:pickerView][row1] [@"arch"];
                                                
      
                                                NSDictionary *idenx1Dict = @{@"id":dict[@"id"], @"name":dict[@"name"]};
                                                NSDictionary *idenx2Dict = @{@"id":dict1[@"id"], @"name":dict1[@"name"]};
                                                
                                                NSMutableArray *choiceDatas = self.headDataSource[@"choiceDatas"];
                                                [choiceDatas replaceObjectAtIndex:2 withObject:@[idenx1Dict, idenx2Dict]];
                                                
                                                NSInteger section = 2;
                                                [self getDataWithIndex:2 completion:^{
                                                    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:section]]
                                                                      withRowAnimation:UITableViewRowAnimationNone];
                                                    
                                                }];
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@27);
        make.height.equalTo(@185);
    }];
    
    [self presentViewController:alert animated:YES completion:nil];

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component==1) {
        return [self filterDatas:pickerView].count;
    }
    return self.flowRankList.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [pickerView reloadComponent:1];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *array = self.flowRankList;
    if (component==1) {
        array = [self filterDatas:pickerView];
    }
    NSDictionary *arch = array[row] [@"arch"];

    return arch[@"name"];
}

//比较对象去重
- (NSArray *)filterDatas:(UIPickerView *)pickerView {
    NSDictionary *arch = self.flowRankList[[pickerView selectedRowInComponent:0]] [@"arch"];
    NSArray *temp = [self.flowRankList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"arch != %@", arch]];
    
    return temp;
}
*/
    
@end

