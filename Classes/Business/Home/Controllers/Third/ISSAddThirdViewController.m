//
//  ISSAddThirdViewController.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/30.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSAddThirdViewController.h"
#import "ISSThirdAddTableViewCell.h"
#import "ISSThirdAddHeadTableViewCell.h"
#import "ISSThirdAddTimeTableViewCell.h"
#import "ISSThirdAddReportTableViewCell.h"
#import "ISSThirdAddIsReportTableViewCell.h"
#import "ISSThirdAddReportTimeTableViewCell.h"
#import "XTPickView.h"

#import "APIAddThirdManager.h"
#import "APIThirdImageUploadManager.h"
#import "APIUserIMageUploadManager.h"

#import "APIDictionaryListManager.h"
#import "ISSDictionaryListReformer.h"
#import "ISSDictionaryListModel.h"


#import <AFNetworking/AFNetworking.h>
#import "APIBaseService.h"
#import "APIServiceFactory.h"

typedef NS_ENUM(NSInteger, TimeSelectType) {
    TimeSelectTypeStar,
    TimeSelectTypeEnd,
    TimeSelectTypeReport
};

@interface ISSAddThirdViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,XTPickViewDelegate>
{
    NSString        * addressStr;
    BOOL              isReport;
    CGFloat           reportCellHeight;
}
@property(nonatomic ,strong) UITableView                       * mainTableView;

@property(nonatomic ,strong) ISSThirdAddTableViewCell          * addressCell;
@property(nonatomic ,strong) ISSThirdAddTableViewCell          * companyCell;
@property(nonatomic ,strong) ISSThirdAddTableViewCell          * stateCell;
@property(nonatomic ,strong) ISSThirdAddTableViewCell          * peopleCell;
@property(nonatomic ,strong) ISSThirdAddTimeTableViewCell      * timeCell;
@property(nonatomic ,strong) ISSThirdAddTableViewCell          * thirdNameCell;
@property(nonatomic ,strong) ISSThirdAddReportTableViewCell    * reportCell;
@property(nonatomic ,strong) ISSThirdAddReportTimeTableViewCell* reportTimeCell;
@property(nonatomic ,strong) ISSThirdAddIsReportTableViewCell  * isReportCell;

@property (nonatomic, strong) XTPickView                       * pickerView;
@property (nonatomic, assign) TimeSelectType                     timeSelectType;

@property(nonatomic ,strong) APIAddThirdManager                * addThirdManager;
@property(nonatomic ,strong) APIDictionaryListManager          * dictionaryListManager;
@property(nonatomic ,strong) APIThirdImageUploadManager        * thirdImageUploadManager;

@property(nonatomic ,strong) NSMutableArray                    * dictionaryArray;
@property(nonatomic ,strong) NSMutableArray                    * imagesArray;



@property(nonatomic ,strong) APIUserIMageUploadManager         * userIMageUploadManager;

@end

@implementation ISSAddThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增巡查报告";
    self.isHiddenTabBar = YES;
    [self navigationSetUp];
    isReport = YES;

    [self.dictionaryListManager loadData];
    [self showLoadingView];
//    [self.addThirdManager loadData];
    
//    [self camera];
}

- (void)navigationSetUp
{
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"保存" forState:UIControlStateNormal];
    [cancelButton setTitleColor:ISSColorWhite forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:ISSFont12];
    [cancelButton setFrame:CGRectMake(0, 0, 15, 20)];
    [cancelButton addTarget:self action:@selector(sureButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    self.navigationItem.rightBarButtonItem = cancelItem;
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    if([manager isKindOfClass:[APIDictionaryListManager class]])
    {
        self.dictionaryArray = [manager fetchDataWithReformer:[ISSDictionaryListReformer new]];
        [self.view addSubview:self.mainTableView];
        [self hiddenLoadingView];
    }
    if([manager isKindOfClass:[APIAddThirdManager class]])
    {
        NSDictionary *dataDic = [manager fetchDataWithReformer:nil];
        for (int i = 0; i<_reportCell.imagesArray.count; i++) {
            UIImage * image = _reportCell.imagesArray[i];
            NSData *data = UIImageJPEGRepresentation(image, 0.5);
            if (i == _reportCell.imagesArray.count) {
                [self uploadToServer:data ReportId:dataDic[@"id"] Islast:YES];
            }else{
                [self uploadToServer:data ReportId:dataDic[@"id"] Islast:NO];
            }
        }

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
    if (indexPath.row == 3) {
        return 10;
    }else if (indexPath.row == 4){
        return 64;
    }else if (indexPath.row == 5){
        return 10;
    }else if (indexPath.row == 7){
        return 108;
    }else if (indexPath.row == 8){
        return 10;
    }else if (indexPath.row == 10){
        return reportCellHeight?:176+54+16;
    }else if (indexPath.row == 11){
        return 10;
    }else if (indexPath.row == 14){
        return 90;
    }else{
        return 54;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self.addressCell conFigDataTitle:@"巡查地点" ISAddImage:YES HiddenText:NO];
        return _addressCell;
    }else if (indexPath.row == 1){
        [ self.companyCell conFigDataTitle:@"巡查单位" ISAddImage:YES HiddenText:NO];
        return _companyCell;
    }else if (indexPath.row == 2){
        [self.stateCell conFigDataTitle:@"报告类型" ISAddImage:YES HiddenText:YES];
        return _stateCell;
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
        self.reportCell.imagesArray = self.imagesArray;
        __weak typeof(self) weakself = self;
        _reportCell.thirdAddReportCellBlock = ^(CGFloat height,NSMutableArray * array){
            reportCellHeight = height;
            weakself.imagesArray = array;
            //需要更新的组数中的cell
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:10 inSection:0];
            [weakself.mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        //报告类型
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"报告类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        for (int i = 0; i < self.dictionaryArray.count; i++) {
            ISSDictionaryListModel * model = self.dictionaryArray[i];
            [alert addAction:[UIAlertAction actionWithTitle:model.content style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                for (ISSDictionaryListModel * model in self.dictionaryArray) {
                    if ([model.content isEqualToString:action.title]) {
                        _stateCell.textRightLabel.text = model.content;
                        NSLog(@"%@",model.content);
                    }
                }
            }]];
        }
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
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

- (void)sureButton
{
    
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
    if ([_addressCell.textField.text isEqualToString:@""]) {
        ALERT(@"请输入地址");
        return;
    }else if ([_companyCell.textField.text isEqualToString:@""]){
        ALERT(@"请输入公司");
        return;
    }else if ([_peopleCell.textField.text isEqualToString:@""]){
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
    self.addThirdManager.address = _addressCell.textField.text;
    self.addThirdManager.company = _companyCell.textField.text;
    
    self.addThirdManager.patrolUser = _peopleCell.textField.text;
    self.addThirdManager.patrolDateStart = _timeCell.startTimeButton.titleLabel.text;
    self.addThirdManager.patrolDateEnd = _timeCell.endTimeButton.titleLabel.text;
    self.addThirdManager.name = _thirdNameCell.textField.text;
    self.addThirdManager.content = _reportCell.textView.text;
    
    if (isReport == YES) {
        self.addThirdManager.isVisit = @"1";
        self.addThirdManager.visitDate = _reportTimeCell.reportTimeButton.titleLabel.text;
    }
    [self.addThirdManager loadData];
    [self showLoadingView];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag - 100000 == 0) {
        addressStr = textField.text;
    }    
    return YES;
}

-(void)uploadToServer:(NSData *)imgdata ReportId:(NSString *)reportId Islast:(BOOL)isLast
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    
    APIBaseService *service = [[APIServiceFactory sharedInstance] serviceWithIdentifier:kAPIServiceWanJiKa];
        NSString * url = [NSString stringWithFormat:@"%@report/image/mobile",service.apiBaseUrl];
    
    [manager            POST: url
                  parameters:@{@"id":reportId}
   constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
       
       [formData appendPartWithFileData :imgdata name:@"file" fileName:@"1.png" mimeType:@"image/jpeg"];
       
   }
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                         NSLog(@"请求成功");
                         if (responseObject) {
                             id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                          options:NSJSONReadingAllowFragments
                                                                            error:nil];
                             if (isLast) {
                                 NSLog(@"obj:%@",jsonObj);
                                 ALERT(@"添加成功");
                                 [self hiddenLoadingView];
                                 [self.navigationController popViewControllerAnimated:YES];
                             }
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"请求失败:%@",error);
                     }];
}

#pragma mark - Setter && Getter

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = ISSColorViewBg;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

- (APIDictionaryListManager *)dictionaryListManager
{
    if (nil == _dictionaryListManager) {
        _dictionaryListManager = [[APIDictionaryListManager alloc] init];
        _dictionaryListManager.delegate = self;
    }
    return _dictionaryListManager;
}

- (APIAddThirdManager *)addThirdManager
{
    if (nil == _addThirdManager) {
        _addThirdManager = [[APIAddThirdManager alloc] init];
        _addThirdManager.delegate = self;
    }
    return _addThirdManager;
}

- (APIThirdImageUploadManager *)thirdImageUploadManager
{
    if (nil == _thirdImageUploadManager) {
        _thirdImageUploadManager = [[APIThirdImageUploadManager alloc] init];
        _thirdImageUploadManager.delegate = self;
    }
    return _thirdImageUploadManager;
}

- (APIUserIMageUploadManager *)userIMageUploadManager
{
    if (nil == _userIMageUploadManager) {
        _userIMageUploadManager = [[APIUserIMageUploadManager alloc] init];
        _userIMageUploadManager.delegate = self;
    }
    return _userIMageUploadManager;
}

- (XTPickView *)pickerView
{
    if (!_pickerView) {
        
        _pickerView = [[XTPickView alloc] initWithTitle:@"选择时间" delegate:self pickViewDataType:PickViewDataTypeTime];
    }
    return _pickerView;
}


- (NSMutableArray *)imagesArray
{
    if (_imagesArray == nil) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

- (ISSThirdAddTableViewCell *)addressCell
{
    if (_addressCell == nil) {
        _addressCell = [[ISSThirdAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAdd"];
        _addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _addressCell;
}

- (ISSThirdAddTableViewCell *)companyCell
{
    if (_companyCell == nil) {
        _companyCell = [[ISSThirdAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAdd"];
        _companyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _companyCell;
}

- (ISSThirdAddTableViewCell *)peopleCell
{
    if (_peopleCell == nil) {
        _peopleCell = [[ISSThirdAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAdd"];
        _peopleCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _peopleCell;
}

- (ISSThirdAddTableViewCell *)stateCell
{
    if (_stateCell == nil) {
        _stateCell = [[ISSThirdAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdAdd"];
        _stateCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _stateCell;
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

//#pragma mark UIImagePickerControllerDelegate

//- (void)camera
//{
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    picker.delegate = self;
//    [self presentViewController:picker animated:NO completion:nil];
//}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
//    //当选择的类型是图片
//    if ([type isEqualToString:@"public.image"])
//    {
//        //照片原图
//        UIImage* orImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//
//        if (orImage) {
////            self.selectIV.image = orImage;
////            self.selectIV.hidden = NO;
////            isImageFormLibrary = YES;
//
//            NSString *dataStr = nil;
//            NSData *data = UIImageJPEGRepresentation(orImage, 0.5);
//            dataStr = [data base64EncodedStringWithOptions:0];
////            self.userIMageUploadManager.imageStr = dataStr;
////            [self.userIMageUploadManager loadData];
////            [self uploadToServer:data];
//            [picker dismissViewControllerAnimated:YES completion:nil];
//        }else {
//            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"图片无效"];
//        }
//
//    }
//
//}


@end
