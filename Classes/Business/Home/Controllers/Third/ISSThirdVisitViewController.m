//
//  ISSThirdVisitViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/12/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdVisitViewController.h"
#import "ISSThirdDetailTopTableViewCell.h"
#import "ISSThirdDetailVisitTableViewCell.h"
#import "ISSThirdDetailReplyTableViewCell.h"
#import "ISSThirdAddHeadTableViewCell.h"
#import "ISSThirdAddTableViewCell.h"
#import "ISSThirdAddTimeTableViewCell.h"
#import "ISSThirdAddTimeTableViewCell.h"
#import "ISSThirdAddReportTableViewCell.h"
#import "ISSThirdAddReportTimeTableViewCell.h"
#import "ISSThirdAddIsReportTableViewCell.h"
#import "ISSReportModel.h"
#import "XTPickView.h"

#import "APIThirdDetailManager.h"
#import "ISSThirdDetailReformer.h"
#import "ISSThirdDetailModel.h"

typedef NS_ENUM(NSInteger, TimeSelectType) {
    TimeSelectTypeStar,
    TimeSelectTypeEnd,
    TimeSelectTypeReport
};

@interface ISSThirdVisitViewController ()<APIManagerCallBackDelegate,UITableViewDelegate,UITableViewDataSource,XTPickViewDelegate>
{
    BOOL              isReport;
}

@property(nonatomic ,strong) UITableView                       * mainTableView;
@property(nonatomic ,strong) APIThirdDetailManager             * thirdDetailManager;
@property(nonatomic ,strong) ISSThirdDetailModel               * thirdDetailmodel;
@property(nonatomic ,strong) ISSThirdAddTableViewCell          * peopleCell;
@property(nonatomic ,strong) ISSThirdAddTimeTableViewCell      * timeCell;
@property(nonatomic ,strong) ISSThirdAddTableViewCell          * thirdNameCell;
@property(nonatomic ,strong) ISSThirdAddReportTableViewCell    * reportCell;
@property(nonatomic ,strong) ISSThirdAddReportTimeTableViewCell* reportTimeCell;
@property(nonatomic ,strong) ISSThirdAddIsReportTableViewCell  * isReportCell;

@property (nonatomic, strong) XTPickView                       * pickerView;
@property (nonatomic, assign) TimeSelectType                     timeSelectType;


@end

@implementation ISSThirdVisitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenTabBar = YES;
    self.title = @"巡查报告回复";
    [self.view addSubview:self.mainTableView];
    self.thirdDetailManager.patrolID = self.thirdListModel.thirdID;
    [self.thirdDetailManager loadData];
    [self showLoadingView];
}

#pragma mark - APIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    if([manager isKindOfClass:[APIThirdDetailManager class]])
    {
        self.thirdDetailmodel= [manager fetchDataWithReformer:[[ISSThirdDetailReformer alloc]init]];
        [self.mainTableView reloadData];
        [self hiddenLoadingView];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    ALERT(manager.errorMessage);
}

#pragma mark - WJPickViewDelegate
- (void)pickerView:(XTPickView *)pickerView didSelectRow:(NSString *)selectTimeString;
{
    if (self.timeSelectType == TimeSelectTypeStar) {
        [_timeCell.startTimeButton setTitle:selectTimeString forState:UIControlStateNormal];
    }else if (self.timeSelectType == TimeSelectTypeEnd) {
        [_timeCell.endTimeButton setTitle:selectTimeString forState:UIControlStateNormal];
    }else{
        [_reportTimeCell.reportTimeButton setTitle:selectTimeString forState:UIControlStateNormal];
    }
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 360;
    }if (indexPath.row == 1) {
        return 380;
    }if (indexPath.row == 2) {
        return 230;
    }if (indexPath.row == 4) {
        return 64;
    }if (indexPath.row == 6) {
        return 54;
    }if (indexPath.row == 7) {
        return 108;
    }if (indexPath.row == 9) {
        return 54;
    }else if (indexPath.row == 10){
        return 176+54+16;
    }if (indexPath.row == 12) {
        return 54;
    }if (indexPath.row == 13) {
        return 54;
    }if (indexPath.row == 14) {
        return 108;
    }else{
        return 10;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3 + 12;

//    return self.thirdDetailmodel.reportsArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ISSThirdDetailTopTableViewCell * cell = [[ISSThirdDetailTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdDetailTop"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell conFigDataThirdDetailModel:self.thirdDetailmodel];
        return cell;
    }else if (indexPath.row == 1){
        ISSThirdDetailVisitTableViewCell * cell = [[ISSThirdDetailVisitTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdDetailChatLeft"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 2){
        ISSThirdDetailReplyTableViewCell * cell = [[ISSThirdDetailReplyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdDetailReply"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 4){
        ISSThirdAddHeadTableViewCell * cell = [[ISSThirdAddHeadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAddHead"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 6){
        [self.peopleCell conFigDataTitle:@"巡查人员" ISAddImage:YES HiddenText:NO];
        return _peopleCell;
    }else if (indexPath.row == 7){
        [self.timeCell.startTimeButton addTarget:self action:@selector(startTimeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.timeCell.endTimeButton addTarget:self action:@selector(endTimeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        return _timeCell;
    }else if (indexPath.row == 9){
        [self.thirdNameCell conFigDataTitle:@"报告名称" ISAddImage:YES HiddenText:NO];
        return _thirdNameCell;
    }else if (indexPath.row == 10){
        self.reportCell.controller = self;
//        self.reportCell.imagesArray = self.imagesArray;
//        __weak typeof(self) weakself = self;
//        _reportCell.thirdAddReportCellBlock = ^(CGFloat height,NSMutableArray * array){
//            reportCellHeight = height;
//            weakself.imagesArray = array;
//            //需要更新的组数中的cell
//            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:10 inSection:0];
//            [weakself.mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        };
        return _reportCell;
        
    }else if (indexPath.row == 12){
        self.isReportCell = [[ISSThirdAddIsReportTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAddIsReport"];
        _isReportCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [_isReportCell.leftButton addTarget:self action:@selector(cellYesButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_isReportCell.rightButton addTarget:self action:@selector(cellNoButtonAction) forControlEvents:UIControlEventTouchUpInside];
        if (isReport == NO) {
            _isReportCell.rightButton.selected = YES;
            _isReportCell.leftButton.selected = NO;
        }else{
            _isReportCell.rightButton.selected = NO;
            _isReportCell.leftButton.selected = YES;
        }
        return _isReportCell;
    }else if (indexPath.row == 13){
        
        [self.reportTimeCell.reportTimeButton addTarget:self action:@selector(reportTimeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        return _reportTimeCell;
    }else if (indexPath.row == 14){
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAddReportTime"];
        cell.backgroundColor = ISSColorViewBg;
        UIButton * submitButton = [[UIButton alloc]initWithFrame:CGRectMake(16, 20, kScreenWidth - 32, 50)];
        [submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [submitButton setTitleColor:ISSColorWhite forState:UIControlStateNormal];
        [submitButton.titleLabel setFont:ISSFont15];
        [submitButton setBackgroundImage:[ISSUtilityMethod createImageWithColor:ISSColorNavigationBar] forState:UIControlStateDisabled];
        [submitButton setBackgroundImage:[ISSUtilityMethod createImageWithColor:ISSColorNavigationBar] forState:UIControlStateNormal];
        submitButton.layer.masksToBounds = YES;
        submitButton.layer.cornerRadius = 4;
        [submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:submitButton];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeMessage"];
        cell.backgroundColor = ISSColorViewBg;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - Button Action

- (void)cellNoButtonAction
{
    if (isReport == YES) {
        _isReportCell.rightButton.selected = YES;
        _isReportCell.leftButton.selected = NO;
        isReport = NO;
    }
}

- (void)cellYesButtonAction
{
    if (isReport == NO) {
        _isReportCell.leftButton.selected = YES;
        _isReportCell.rightButton.selected = NO;
        isReport=YES;
    }
}

- (void)startTimeButtonAction
{
    self.timeSelectType = TimeSelectTypeStar;
    [self.pickerView presentViewController:self];
}

- (void)endTimeButtonAction
{
    self.timeSelectType = TimeSelectTypeEnd;
    [self.pickerView presentViewController:self];
}

- (void)reportTimeButtonAction
{
    self.timeSelectType = TimeSelectTypeReport;
    [self.pickerView presentViewController:self];
}


- (void)submitButtonAction
{
    if ([_peopleCell.textField.text isEqualToString:@""]){
        ALERT(@"请输入人员");
        return;
    }else if ([_timeCell.startTimeButton.titleLabel.text isEqualToString:@""]){
        ALERT(@"请输入开始时间");
        return;
    }else if ([_timeCell.endTimeButton.titleLabel.text isEqualToString:@""]){
        ALERT(@"请输入结束时间");
        return;
    }else if ([_thirdNameCell.textField.text isEqualToString:@""]){
        ALERT(@"请输入报告名称");
        return;
    }else if ([_reportCell.textView.text isEqualToString:@""]){
        ALERT(@"请输入报告内容");
        return;
    }
    ALERT(@"回复成功");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter && Getter

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabbarHeight) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = ISSColorWhite;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}
- (APIThirdDetailManager *)thirdDetailManager
{
    if (nil == _thirdDetailManager) {
        _thirdDetailManager = [[APIThirdDetailManager alloc] init];
        _thirdDetailManager.delegate = self;
    }
    return _thirdDetailManager;
}

- (ISSThirdAddTableViewCell *)peopleCell
{
    if (_peopleCell == nil) {
        _peopleCell = [[ISSThirdAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAdd"];
        _peopleCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _peopleCell;
}

- (ISSThirdAddTimeTableViewCell *)timeCell
{
    if (_timeCell == nil) {
        _timeCell = [[ISSThirdAddTimeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAddTime"];
        _timeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _timeCell;
}

- (ISSThirdAddTableViewCell *)thirdNameCell
{
    if (_thirdNameCell == nil) {
        _thirdNameCell = [[ISSThirdAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAdd"];
        _thirdNameCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _thirdNameCell;
}

- (ISSThirdAddReportTimeTableViewCell *)reportTimeCell
{
    if (_reportTimeCell == nil) {
        _reportTimeCell = [[ISSThirdAddReportTimeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAddReportTime"];
        _reportTimeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _reportTimeCell;
}

- (ISSThirdAddReportTableViewCell *)reportCell
{
    if (_reportCell == nil) {
        _reportCell = [[ISSThirdAddReportTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAddReport"];
        _reportCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _reportCell;
}

- (XTPickView *)pickerView
{
    if (!_pickerView) {
        
        _pickerView = [[XTPickView alloc] initWithTitle:@"选择时间" delegate:self pickViewDataType:PickViewDataTypeTime];
    }
    return _pickerView;
}

@end
