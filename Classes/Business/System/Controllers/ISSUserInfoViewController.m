//
//  ISSUserInfoViewController.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/28.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSUserInfoViewController.h"
#import "ISSUserInfoEditCell.h"
#import "ISSUserInfoReadCell.h"
#import "ISSUserInfoHeadCell.h"
#import "ISSUserInfoSexCell.h"
#import "ISSLoginUserModel.h"
#import "UIImageView+WebImage.h"
#import "LoadingManager.h"

@interface ISSUserInfoViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    ISSTaskPeopleModel *_editModel;
}
@end

@implementation ISSUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    
    self.isHiddenTabBar = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(submit)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    NSDictionary *dic = [[ISSLoginUserModel shareInstance].loginUser toDictionary];
    _editModel = [[ISSTaskPeopleModel alloc] initWithDictionary:dic error:nil];
    
    [_tableView registerClass:[ISSUserInfoEditCell class] forCellReuseIdentifier:@"ISSUserInfoEditCell"];
    [_tableView registerClass:[ISSUserInfoReadCell class] forCellReuseIdentifier:@"ISSUserInfoReadCell"];
    [_tableView registerClass:[ISSUserInfoHeadCell class] forCellReuseIdentifier:@"ISSUserInfoHeadCell"];
    [_tableView registerClass:[ISSUserInfoSexCell class] forCellReuseIdentifier:@"ISSUserInfoSexCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldTextChanged:(NSNotification *)notification {
    UITextField *textField = notification.object;
    NSString *text = textField.text;
    if (textField.tag == 1) {
        _editModel.name = text;
    } else if (textField.tag == 2) {
        _editModel.telephone = text;
    } else if (textField.tag == 3) {
        _editModel.des = text;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    switch (section) {
        case 0:
            count = 1;
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
            count = 1;
            break;
            
        default:
            break;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *theCell;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ISSUserInfoHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSUserInfoHeadCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"头像";
            [cell.header setImageWithPath:_editModel.imageData placeholder:@"default-head"];
            theCell = cell;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ISSUserInfoEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSUserInfoEditCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"姓名";
            cell.textField.text = _editModel.name;
            cell.textField.tag = 1;
            theCell = cell;
        } else if (indexPath.row == 1) {
            ISSUserInfoReadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSUserInfoReadCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"角色";
            cell.textField.text = @"";
            theCell = cell;
        } else if (indexPath.row == 2) {
            ISSUserInfoSexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSUserInfoSexCell" forIndexPath:indexPath];
            cell.sexBlock = ^(NSInteger sex) {
                _editModel.sex = sex;
            };
            cell.keyLabel.text = @"性别";
            cell.sex = _editModel.sex;
            theCell = cell;
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            ISSUserInfoReadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSUserInfoReadCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"账户";
            cell.textField.text = _editModel.account;
            theCell = cell;
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            ISSUserInfoEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSUserInfoEditCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"电话";
            cell.textField.text = _editModel.telephone;
            cell.textField.tag = 2;
            theCell = cell;
        } else if (indexPath.row == 1) {
            ISSUserInfoReadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSUserInfoReadCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"公司";
            cell.textField.text = _editModel.companyName;
            theCell = cell;
        }
    } else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            ISSUserInfoEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSUserInfoEditCell" forIndexPath:indexPath];
            cell.keyLabel.text = @"签名";
            cell.textField.text = _editModel.des;
            cell.textField.tag = 3;
            theCell = cell;
        }
    }
    return theCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self showAlbum];
        }
    }
}

#pragma mark 头像

- (void)showAlbum {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shootButtonAction];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [self libraryButtonAction];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)shootButtonAction
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:picker animated:NO completion:nil];
}

- (void)libraryButtonAction
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:NO completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //照片原图
        UIImage *orImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        if (orImage) {
//            NSString *dataStr = nil;
//            NSData *data = UIImageJPEGRepresentation(orImage, 0.5);
//            dataStr = [data base64EncodedStringWithOptions:0];
            [self uploadHead:orImage];
            [picker dismissViewControllerAnimated:YES completion:nil];
        } else {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"图片无效"];
        }
    }
}

- (void)uploadHead:(UIImage *)data {
    __weak typeof(self) weakSelf = self;
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            NSString *imageURL = [result objectForKey:@"name"];
            [ISSLoginUserModel shareInstance].loginUser.imageData = imageURL;
            _editModel.imageData = imageURL;
            [weakSelf submit:[ISSLoginUserModel shareInstance].loginUser head:YES];
        }
    }];
    [request uploadReportReplyFile:data];
//    [request uploadUserHead:<#(NSString *)#>];
}

- (void)submitHead {
    
}

- (void)submit {
    [self submit:_editModel head:NO];
}

- (void)submit:(ISSTaskPeopleModel *)userModel head:(BOOL)head {
    NSMutableDictionary *dic = [userModel toDictionary].mutableCopy;
    [dic setObject:userModel.des ? : @"" forKey:@"description"];
    [dic setObject:[NSString stringWithFormat:@"%@", @(userModel.accountType)] forKey:@"accountType"];
    [dic setObject:[NSString stringWithFormat:@"%@", @(userModel.locked)] forKey:@"locked"];
    [dic setObject:[NSString stringWithFormat:@"%@", @(userModel.sex)] forKey:@"sex"];
    [dic removeObjectForKey:@"companyName"];
    [dic removeObjectForKey:@"selected"];
    
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            if (head) {
                [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            } else {
                [ISSLoginUserModel shareInstance].loginUser = userModel;
            }

            [self.view makeToast:@"修改成功"];
        }
    }];
    [request updateUserInfo:dic];
}

@end
