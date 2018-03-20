//
//  ISSReportVisitViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportVisitViewController.h"
#import "ISSReportRUserCell.h"
#import "ISSReportVisitLineCell.h"
#import "ISSPlainAddDateCell.h"
#import "ISSReportRInputCell.h"
#import "ISSReportVisitWhetherCell.h"
#import "ISSReportVisitTimeCell.h"
#import "ISSReportRSubmitCell.h"
#import "TZImagePickerController.h"
#import "ISSReportVisitModel.h"
#import "PGDatePicker.h"

@interface ISSReportVisitViewController () <TZImagePickerControllerDelegate, PGDatePickerDelegate>
{
    NSMutableArray *_assetArray;
    NSMutableArray *_photoArray;
    
    NSMutableArray *_uploadResultList;
    
    ISSReportVisitModel *_visitModel;
}
@end

@implementation ISSReportVisitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"巡查报告回访";
    
    _photoArray = @[].mutableCopy;
    _assetArray = @[].mutableCopy;
    
    _visitModel = [[ISSReportVisitModel alloc] init];
    _visitModel.needVisit = _detailModel.needVisit;
    
    [_tableView registerClass:[ISSReportRUserCell class] forCellReuseIdentifier:@"ISSReportRUserCell"];
    [_tableView registerClass:[ISSReportVisitLineCell class] forCellReuseIdentifier:@"ISSReportVisitLineCell"];
    [_tableView registerClass:[ISSPlainAddNameCell class] forCellReuseIdentifier:@"ISSPlainAddNameCell"];
    [_tableView registerClass:[ISSPlainAddDateCell class] forCellReuseIdentifier:@"ISSPlainAddDateCell"];
    [_tableView registerClass:[ISSReportRInputCell class] forCellReuseIdentifier:@"ISSReportRInputCell"];
    [_tableView registerClass:[ISSReportVisitWhetherCell class] forCellReuseIdentifier:@"ISSReportVisitWhetherCell"];
    [_tableView registerClass:[ISSReportVisitTimeCell class] forCellReuseIdentifier:@"ISSReportVisitTimeCell"];
    [_tableView registerClass:[ISSReportRSubmitCell class] forCellReuseIdentifier:@"ISSReportRSubmitCell"];
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
    if (textField.tag == _visitModel.userTag) {
        _visitModel.user = text;
    } else if (textField.tag == _visitModel.titleTag) {
        _visitModel.title = text;
    }
}

- (void)textViewTextChanged:(NSNotification *)notification {
    UITextView *textView = notification.object;
    NSString *text = textView.text;
    if (textView.tag == _visitModel.contentTag) {
        _visitModel.content = text;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = CGFLOAT_MIN;
    if (section < 2) {
        height = [super tableView:tableView heightForHeaderInSection:section];
    } else if (section == 2 || section == 3 || section == 4 || section == 5) {
        height = 10;
    }
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (section < 2) {
        count = [super tableView:tableView numberOfRowsInSection:section];
    } else if (section == 2) {
        count = 1;
    } else if (section == 3) {
        count = 2;
    } else if (section == 4) {
        count = 3;
    } else if (section == 5) {
        if (_visitModel.needVisit) {
            count = 2;
        } else {
            count = 1;
        }
    } else if (section == 6) {
        count = 1;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    UITableViewCell *theCell;
    if (indexPath.section < 2) {
        theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            ISSReportRUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportRUserCell" forIndexPath:indexPath];
            [cell.headerImageView setImageWithPath:_detailModel.creator.imageData placeholder:@"people"];
            cell.nameLabel.text = _detailModel.creator.name;
            cell.typeLabel.text = @"回访人员";
            theCell = cell;
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            ISSReportVisitLineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportVisitLineCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"巡查人员";
            cell.textField.placeholder = @"请输入巡查人员名称";
            cell.textField.text = _visitModel.user;
            cell.textField.tag = _visitModel.userTag;
            cell.textField.userInteractionEnabled = YES;
            theCell = cell;
        } else if (indexPath.row == 1) {
            ISSPlainAddDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSPlainAddDateCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"巡查时间";
            cell.showPickerBlock = ^(NSInteger tag) {
                [weakSelf showTimePicker:tag];
            };
            cell.startLabel.text = _visitModel.startTimeDes ? : @"开始时间";
            cell.endLabel.text = _visitModel.endTimeDes ? : @"结束时间";
            theCell = cell;
        }
    } else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            ISSReportVisitLineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportVisitLineCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"报告名称";
            cell.textField.placeholder = @"请输入报告名称";
            cell.textField.text = _visitModel.title;
            cell.textField.tag = _visitModel.titleTag;
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
            cell.textView.text = _visitModel.content;
            cell.textView.tag = _visitModel.contentTag;
            cell.photoArray = _photoArray;
            theCell = cell;
        }
    } else if (indexPath.section == 5) {
        if (indexPath.row == 0) {
            ISSReportVisitWhetherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportVisitWhetherCell" forIndexPath:indexPath];
            cell.visitBlock = ^(BOOL visit) {
                [weakSelf setVisit:visit];
            };
            cell.needVisit = _visitModel.needVisit;
            theCell = cell;
        } else if (indexPath.row == 1) {
            ISSReportVisitTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportVisitTimeCell" forIndexPath:indexPath];
            cell.textField.text = _visitModel.timeDes;
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
    
    if (indexPath.section == 5 && indexPath.row == 1) {
        [self showTimePicker:3];
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
    [datePicker setDate:tag == 0 ? _visitModel.startTime : _visitModel.endTime animated:YES];
}

#pragma PGDatePickerDelegate

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:dateComponents];
    
    if (datePicker.tag == 103) {
        _visitModel.time = date;
        
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:6] withRowAnimation:UITableViewRowAnimationNone];
    } else {
        if (datePicker.tag == 101) {
            _visitModel.startTime = date;
        } else if (datePicker.tag == 102) {
            _visitModel.endTime = date;
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
    _visitModel.needVisit = visit;
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)doSubmit {
    [self.view endEditing:YES];
    
    NSString *tips = nil;
    if (_visitModel.user.length == 0) {
        tips = @"请输入巡查人员名称";
    } else if (_visitModel.startTimeDes.length == 0) {
        tips = @"请选择开始时间";
    } else if (_visitModel.endTimeDes.length == 0) {
        tips = @"请选择结束时间";
    } else if (_visitModel.title.length == 0) {
        tips = @"请输入报告名称";
    } else if (_visitModel.content.length == 0) {
        tips = @"请输入报告内容";
    } else if (_visitModel.needVisit) {
        if (_visitModel.timeDes.length == 0) {
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
    NSMutableDictionary *param = @{@"patrol": @{@"id": _detailModel.id},
                                   @"category": @(1),
                                   @"content": _visitModel.content,
                                   @"name": _visitModel.title,
                                   @"patrolUser": _visitModel.user,
                                   @"patrolDateStart": _visitModel.startTimeDes,
                                   @"patrolDateEnd": _visitModel.endTimeDes,
                                   @"needVisit": @(_visitModel.needVisit),
                                   @"visitDate": _visitModel.timeDes ? : @""
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
