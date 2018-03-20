//
//  ISSReportAddViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportAddViewController.h"
#import "ISSReportAddOptionCell.h"
#import "ISSReportAddDepCell.h"
#import "ISSReportRUserCell.h"
#import "ISSPlainAddDateCell.h"
#import "ISSReportRInputCell.h"
#import "ISSReportVisitTimeCell.h"
#import "ISSReportVisitWhetherCell.h"
#import "ISSReportRSubmitCell.h"
#import "ISSReportAddModel.h"
#import "ISSLoginUserModel.h"
#import "PGDatePicker.h"
#import "TZImagePickerController.h"
#import "ActionSheetStringPicker.h"

@interface ISSReportAddViewController () <TZImagePickerControllerDelegate, PGDatePickerDelegate>
{
    NSMutableArray *_assetArray;
    NSMutableArray *_photoArray;
    
    NSMutableArray *_uploadResultList;
    
    ISSReportAddModel *_addModel;
}
@end

@implementation ISSReportAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新增巡查报告";
    
    _photoArray = @[].mutableCopy;
    _assetArray = @[].mutableCopy;
    
    _addModel = [[ISSReportAddModel alloc] init];
    _addModel.needVisit = YES;
    
//    [self getAddressList];
    
    [_tableView registerClass:[ISSReportAddOptionCell class] forCellReuseIdentifier:@"ISSReportAddOptionCell"];
    [_tableView registerClass:[ISSReportAddDepCell class] forCellReuseIdentifier:@"ISSReportAddDepCell"];
    [_tableView registerClass:[ISSReportRUserCell class] forCellReuseIdentifier:@"ISSReportRUserCell"];
    [_tableView registerClass:[ISSPlainAddDateCell class] forCellReuseIdentifier:@"ISSPlainAddDateCell"];
    [_tableView registerClass:[ISSReportRInputCell class] forCellReuseIdentifier:@"ISSReportRInputCell"];
    [_tableView registerClass:[ISSReportVisitTimeCell class] forCellReuseIdentifier:@"ISSReportVisitTimeCell"];
    [_tableView registerClass:[ISSReportVisitWhetherCell class] forCellReuseIdentifier:@"ISSReportVisitWhetherCell"];
    [_tableView registerClass:[ISSReportRSubmitCell class] forCellReuseIdentifier:@"ISSReportRSubmitCell"];
    [_tableView registerClass:[ISSReportVisitLineCell class] forCellReuseIdentifier:@"ISSReportVisitLineCell"];
    [_tableView registerClass:[ISSPlainAddNameCell class] forCellReuseIdentifier:@"ISSPlainAddNameCell"];
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
    if (textField.tag == _addModel.addressTag) {
        _addModel.address = text;
    } else if (textField.tag == _addModel.usersTag) {
        _addModel.users = text;
    } else if (textField.tag == _addModel.titleTag) {
        _addModel.title = text;
    } else if (textField.tag == _addModel.constructionTag) {
        _addModel.construction = text;
    } else if (textField.tag == _addModel.implementTag) {
        _addModel.implement = text;
    } else if (textField.tag == _addModel.superviseTag) {
        _addModel.supervise = text;
    }
}

- (void)textViewTextChanged:(NSNotification *)notification {
    UITextView *textView = notification.object;
    NSString *text = textView.text;
    if (textView.tag == _addModel.contentTag) {
        _addModel.content = text;
    }
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = 10;
    if (section == 5 || section == 6) {
        height = CGFLOAT_MIN;
    }
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    switch (section) {
        case 0:
            count = 3;
            break;
            
        case 1:
            count = 3;
            break;
            
        case 2:
            count = 1;
            break;
            
        case 3:
            count = 2;
            break;
            
        case 4:
            count = 3;
            break;
            
        case 5:
            if (_addModel.needVisit) {
                count = 2;
            } else {
                count = 1;
            }
            break;
            
        case 6:
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
//            ISSReportAddOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportAddOptionCell" forIndexPath:indexPath];
//            cell.keyLabel.text = @"巡查地点";
//            cell.textField.placeholder = @"请选择";
//            cell.textField.text = _addModel.address;
//            cell.textField.userInteractionEnabled = NO;
//            theCell = cell;
            
            ISSReportAddDepCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportAddDepCell" forIndexPath:indexPath];
            cell.textField.placeholder = @"请输入巡查地点";
            cell.textField.userInteractionEnabled = YES;
            cell.keyLabel.text = @"巡查地点";
            cell.textField.text = _addModel.address;
            cell.textField.tag = _addModel.addressTag;
            theCell = cell;
        } else if (indexPath.row == 1) {
            ISSReportAddDepCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportAddDepCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"巡查单位";
            cell.textField.placeholder = nil;
            cell.textField.text = _addModel.dep;
            cell.textField.userInteractionEnabled = NO;
            theCell = cell;
        } else if (indexPath.row == 2) {
            ISSReportAddOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportAddOptionCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"巡查类型";
            cell.textField.placeholder = @"请选择";
            cell.textField.text = _addModel.category;
            cell.textField.userInteractionEnabled = NO;
            theCell = cell;
        }
    } else if (indexPath.section == 1) {
        ISSReportAddDepCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportAddDepCell" forIndexPath:indexPath];
        cell.textField.placeholder = nil;
        cell.textField.userInteractionEnabled = YES;
        if (indexPath.row == 0) {
            cell.keyLabel.text = @"建设单位";
            cell.textField.text = _addModel.construction;
            cell.textField.tag = _addModel.constructionTag;
        } else if (indexPath.row == 1) {
            cell.keyLabel.text = @"施工单位";
            cell.textField.text = _addModel.implement;
            cell.textField.tag = _addModel.implementTag;
        } else if (indexPath.row == 2) {
            cell.keyLabel.text = @"监理单位";
            cell.textField.text = _addModel.supervise;
            cell.textField.tag = _addModel.superviseTag;
        }
        theCell = cell;
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            ISSReportRUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportRUserCell" forIndexPath:indexPath];
            [cell.headerImageView setImageWithPath:[ISSLoginUserModel shareInstance].loginUser.imageData placeholder:@"people"];
            cell.nameLabel.text = [ISSLoginUserModel shareInstance].loginUser.name;
            cell.typeLabel.text = @"报告人员";
            theCell = cell;
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            ISSReportVisitLineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportVisitLineCell" forIndexPath:indexPath];
            cell.line.hidden = YES;
            cell.keyLabel.text = @"巡查人员";
            cell.textField.placeholder = @"请输入巡查人员名称";
            cell.textField.text = _addModel.users;
            cell.textField.tag = _addModel.usersTag;
            cell.textField.userInteractionEnabled = YES;
            theCell = cell;
        } else if (indexPath.row == 1) {
            ISSPlainAddDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSPlainAddDateCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"巡查时间";
            cell.showPickerBlock = ^(NSInteger tag) {
                [weakSelf showTimePicker:tag];
            };
            cell.startLabel.text = _addModel.startTimeDes ? : @"开始时间";
            cell.endLabel.text = _addModel.endTimeDes ? : @"结束时间";
            theCell = cell;
        }
    } else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            ISSReportVisitLineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportVisitLineCell" forIndexPath:indexPath];
            cell.line.hidden = YES;
            cell.keyLabel.text = @"报告名称";
            cell.textField.placeholder = @"请输入报告名称";
            cell.textField.text = _addModel.title;
            cell.textField.tag = _addModel.titleTag;
            cell.textField.userInteractionEnabled = YES;
            theCell = cell;
        } else if (indexPath.row == 1) {
            ISSPlainAddNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSPlainAddNameCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"报告内容";
            cell.textField.placeholder = nil;
            cell.textField.userInteractionEnabled = NO;
            theCell = cell;
        } else if (indexPath.row == 2) {
            ISSReportRInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportRInputCell" forIndexPath:indexPath];
            cell.addPhotoBlock = ^{
                [weakSelf showAddPhoto];
            };
            cell.removePhotoBlock = ^(NSInteger index) {
                [weakSelf removePhoto:index];
            };
            cell.textView.text = _addModel.content;
            cell.textView.tag = _addModel.contentTag;
            cell.photoArray = _photoArray;
            theCell = cell;
        }
    } else if (indexPath.section == 5) {
        if (indexPath.row == 0) {
            ISSReportVisitWhetherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportVisitWhetherCell" forIndexPath:indexPath];
            cell.visitBlock = ^(BOOL visit) {
                [weakSelf setVisit:visit];
            };
            cell.needVisit = _addModel.needVisit;
            theCell = cell;
        } else if (indexPath.row == 1) {
            ISSReportVisitTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportVisitTimeCell" forIndexPath:indexPath];
            cell.textField.text = _addModel.timeDes;
            theCell = cell;
        }
    } else if (indexPath.section == 6) {
        if (indexPath.row == 0) {
            ISSReportRSubmitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportRSubmitCell" forIndexPath:indexPath];
            cell.submitBlock = ^{
                [weakSelf doSubmit];
            };
            theCell = cell;
        }
    }
    return theCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
//            [self showAddressList];
        } else if (indexPath.row == 2) {
            [self showCategoryList];
        }
    } else if (indexPath.section == 5) {
        if (indexPath.row == 1) {
            [self showVisitTimePicker];
        }
    }
}

#pragma mark 地点和类型

//- (void)getAddressList {
//    NetworkRequest *request = [[NetworkRequest alloc] init];
//    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
//        if (success) {
//            _addModel.addressList = (NSArray *)result;
//        }
//    }];
//    [request getReportAddressList];
//}
//
//- (void)showAddressList {
//    if (_addModel.addressList.count == 0) {
//        return;
//    }
//
//    __weak typeof(self) weakSelf = self;
//    ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"巡查地点"
//                                                                                rows:_addModel.addressList
//                                                                    initialSelection:_addModel.addressIndex > 0 ? _addModel.addressIndex : 0
//                                                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
//                                                                               [weakSelf addressListSelected:selectedIndex];
//                                                                           } cancelBlock:nil
//                                                                              origin:self.view];
//    [picker showActionSheetPicker];
//}
//
//- (void)addressListSelected:(NSInteger)index {
//    if (index == _addModel.addressIndex) {
//        return;
//    }
//
//    if (index >= 0 && index < _addModel.addressList.count) {
//        _addModel.addressIndex = index;
//        _addModel.address = [_addModel.addressList objectAtIndex:_addModel.addressIndex];
//
//        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//    }
//}

- (void)showCategoryList {
    if (_addModel.categoryList.count == 0) {
        return;
    }
    
    NSMutableArray *rows = @[].mutableCopy;
    for (ISSReportCategoryModel *model in _addModel.categoryList) {
        [rows addObject:model.content];
    }
    __weak typeof(self) weakSelf = self;
    ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"报告类型"
                                                                                rows:rows
                                                                    initialSelection:_addModel.categoryIndex > 0 ? _addModel.categoryIndex : 0
                                                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                               [weakSelf categoryListSelected:selectedIndex];
                                                                           } cancelBlock:nil
                                                                              origin:self.view];
    [picker showActionSheetPicker];
}

- (void)categoryListSelected:(NSInteger)index {
    if (index == _addModel.categoryIndex) {
        return;
    }
    
    if (index >= 0 && index < _addModel.categoryList.count) {
        _addModel.categoryIndex = index;
        
        ISSReportCategoryModel *model = [_addModel.categoryList objectAtIndex:_addModel.categoryIndex];
        _addModel.category = model.content;
        
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
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

- (void)showVisitTimePicker {
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.delegate = self;
    [datePicker showWithShadeBackgroud];
    datePicker.datePickerType = PGPickerViewType2;
    datePicker.datePickerMode = PGDatePickerModeDateHourMinute;
    datePicker.titleLabel.text = @"请选择时间";
    datePicker.tag = 103;
    [datePicker setDate:_addModel.time animated:YES];
}

#pragma PGDatePickerDelegate

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:dateComponents];
    
    if (datePicker.tag == 103) {
        _addModel.time = date;
        
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:5]] withRowAnimation:UITableViewRowAnimationNone];
    } else {
        if (datePicker.tag == 101) {
            _addModel.startTime = date;
        } else if (datePicker.tag == 102) {
            _addModel.endTime = date;
        }
        
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)showAddPhoto {
    TZImagePickerController *imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:20 delegate:self];
    imagePickerController.allowPickingVideo = NO;
    imagePickerController.allowPickingOriginalPhoto = NO;
    imagePickerController.selectedAssets = _assetArray;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    [self viewWillAppear:YES];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    [self viewWillAppear:YES];
    
    [_assetArray setArray:assets];
    [_photoArray setArray:photos];
    
    [self reloadPhotos];
}

- (void)reloadPhotos {
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:4]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)removePhoto:(NSInteger)index {
    __weak typeof(self) weakSelf = self;
    TZImagePickerController *imagePickerController = [[TZImagePickerController alloc] initWithSelectedAssets:_assetArray selectedPhotos:_photoArray index:index];
    imagePickerController.maxImagesCount = 20;
    imagePickerController.allowPickingVideo = NO;
    imagePickerController.allowPickingOriginalPhoto = NO;
    imagePickerController.selectedAssets = _assetArray;
    [imagePickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [_assetArray setArray:assets];
        [_photoArray setArray:photos];
        
        [weakSelf reloadPhotos];
    }];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)setVisit:(BOOL)visit {
    _addModel.needVisit = visit;
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)doSubmit {
    [self.view endEditing:YES];
    
    NSString *tips = nil;
    if (_addModel.address.length == 0) {
        tips = @"请输入巡查地点称";
    } else if (_addModel.category.length == 0) {
        tips = @"请选择巡查类型";
    } else if (_addModel.users.length == 0) {
        tips = @"请输入巡查人员名称";
    } else if (_addModel.startTimeDes.length == 0) {
        tips = @"请选择开始时间";
    } else if (_addModel.endTimeDes.length == 0) {
        tips = @"请选择结束时间";
    } else if (_addModel.title.length == 0) {
        tips = @"请输入报告名称";
    } else if (_addModel.content.length == 0) {
        tips = @"请输入报告内容";
    } else if (_addModel.needVisit) {
        if (_addModel.timeDes.length == 0) {
            tips = @"请选择回访时间";
        }
    }
    if (tips) {
        [self.view makeToast:tips];
        return;
    }
    
    if (_photoArray.count > 0) {
        [self submitPhoto];
    } else {
        [self submitContent];
    }
}

- (void)submitPhoto {
    _uploadResultList = @[].mutableCopy;
    
    for (UIImage *image in _photoArray) {
        __weak typeof(self) weakSelf = self;
        NetworkRequest *request = [[NetworkRequest alloc] init];
        [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
            if (success) {
                NSString *name = [result objectForKey:@"name"];
                [_uploadResultList addObject:name];
                if (_uploadResultList.count == _photoArray.count) {
                    [weakSelf submitContent];
                }
            }
        }];
        [request uploadReportReplyFile:image];
    }
}

- (void)submitContent {
    NSString *cat = nil;
    if (_addModel.categoryIndex >= 0 && _addModel.categoryIndex < _addModel.categoryList.count) {
        ISSReportCategoryModel *model = [_addModel.categoryList objectAtIndex:_addModel.categoryIndex];
        cat = model.value;
    }
    
    NSMutableDictionary *param = @{@"address": _addModel.address,
                                   @"company": _addModel.dep ? : @"",
                                   @"developmentCompany": _addModel.implement ? : @"",
                                   @"constructionCompany": _addModel.construction ? : @"",
                                   @"supervisionCompany": _addModel.supervise ? : @"",
                                   @"category": cat ? : @"",
                                   @"visit": @(_addModel.needVisit),
                                   @"visitDate": _addModel.timeDes ? [NSString stringWithFormat:@"%@:00", _addModel.timeDes] : @""
                                   }.mutableCopy;
    
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            [weakSelf submitReport:result];
        }
    }];
    [request submitReportAdd:param];
}

- (void)submitReport:(NSDictionary *)patrolDic {
    NSMutableDictionary *param = @{@"category": @(1),
                                   @"content": _addModel.content,
                                   @"creator": @{@"id": [[patrolDic objectForKey:@"creator"] objectForKey:@"id"]},
                                   @"date": [patrolDic objectForKey:@"date"] ? : @"",
                                   @"id": @(0),
                                   @"name": _addModel.title,
                                   @"needVisit": @(_addModel.needVisit),
                                   @"patrol": @{@"id": [patrolDic objectForKey:@"id"]},
                                   @"patrolDateEnd": [NSString stringWithFormat:@"%@:00", _addModel.endTimeDes],
                                   @"patrolDateStart": [NSString stringWithFormat:@"%@:00", _addModel.startTimeDes],
                                   @"patrolUser": _addModel.users,
                                   @"status": @(2),
                                   @"visitDate": _addModel.timeDes ? [NSString stringWithFormat:@"%@:00", _addModel.timeDes] : @""
                                   }.mutableCopy;
    
    if (_uploadResultList && _uploadResultList.count > 0) {
        NSString *jsonString = nil;
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_uploadResultList
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        if (!jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [param setObject:jsonString forKey:@"files"];
        }
    }
    
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            [weakSelf.view makeToast:@"提交成功"];
            
            [weakSelf performSelector:@selector(submitSuccess) withObject:nil afterDelay:1.0];
        }
    }];
    [request submitReportVisit:param];
}

- (void)submitSuccess {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
