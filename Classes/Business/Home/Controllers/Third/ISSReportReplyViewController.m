//
//  ISSReportReplyViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportReplyViewController.h"
#import "ISSReportRUserCell.h"
#import "ISSReportRInputCell.h"
#import "ISSReportRSubmitCell.h"
#import "TZImagePickerController.h"

@interface ISSReportReplyViewController () <TZImagePickerControllerDelegate>
{
    NSMutableArray *_assetArray;
    NSMutableArray *_photoArray;
    
    NSString *_content;
    
    NSMutableArray *_uploadResultList;
}
@end

@implementation ISSReportReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"巡查报告回复";
    
    _photoArray = @[].mutableCopy;
    _assetArray = @[].mutableCopy;
    
    [_tableView registerClass:[ISSReportRUserCell class] forCellReuseIdentifier:@"ISSReportRUserCell"];
    [_tableView registerClass:[ISSReportRInputCell class] forCellReuseIdentifier:@"ISSReportRInputCell"];
    [_tableView registerClass:[ISSReportRSubmitCell class] forCellReuseIdentifier:@"ISSReportRSubmitCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewTextChanged:(NSNotification *)notification {
    UITextView *textView = notification.object;
    NSString *text = textView.text;
    if (textView.tag == 80) {
        _content = text;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = CGFLOAT_MIN;
    if (section < 2) {
        height = [super tableView:tableView heightForHeaderInSection:section];
    } else if (section == 2) {
        height = 10;
    }
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (section < 2) {
        count = [super tableView:tableView numberOfRowsInSection:section];
    } else if (section == 2) {
        count = 3;
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
            cell.typeLabel.text = @"报告人员";
            theCell = cell;
        } else if (indexPath.row == 1) {
            ISSReportRInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportRInputCell" forIndexPath:indexPath];
            cell.addPhotoBlock = ^{
                [weakSelf showAddPhoto];
            };
            cell.removePhotoBlock = ^(NSInteger index) {
                [weakSelf removePhoto:index];
            };
            cell.textView.text = _content;
            cell.photoArray = _photoArray;
            theCell = cell;
        } else if (indexPath.row == 2) {
            ISSReportRSubmitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSReportRSubmitCell" forIndexPath:indexPath];
            cell.submitBlock = ^{
                [weakSelf doSubmit];
            };
            theCell = cell;
        }
    }
    return theCell;
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
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
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

- (void)doSubmit {
    [self.view endEditing:YES];
    
    NSString *tips = nil;
    if (_content.length == 0) {
        tips = @"请输入内容";
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
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            [weakSelf.view makeToast:@"提交成功"];
            
            [weakSelf performSelector:@selector(submitSuccess) withObject:nil afterDelay:1.0];
        }
    }];
    [request submitReportReply:_detailModel.id content:_content category:2 files:_uploadResultList];
}

- (void)submitSuccess {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
