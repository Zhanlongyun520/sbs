//
//  ISSUploadPhotosViewController.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSUploadPhotosViewController.h"
#import "NetworkRequest.h"
#import "TKAlertCenter.h"
#import "ISSLoginUserModel.h"

#import <AFNetworking/AFNetworking.h>
#import "APIService.h"
#import "TZLocationManager.h"

@interface ISSUploadPhotosViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@property (nonatomic, strong) NSString *addressStr;

@end

@implementation ISSUploadPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"上传照片";
    self.isHiddenTabBar = YES;
    
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 10, 100, 100);
    [btn setBackgroundImage:[UIImage imageNamed:@"upload_btn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(uploadBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.addressStr = @"未知地点";
    
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(CLLocation *location, CLLocation *oldLocation) {

    } failureBlock:^(NSError *error) {
        
    } geocoderBlock:^(NSArray *geocoderArray) {
        if (geocoderArray.count <=10){            // 编码成功（找到了具体的位置信息）
            // 输出查询到的所有地标信息
            for (CLPlacemark *placemark in geocoderArray) {
                self.addressStr = placemark.name;
            }
        } else {
            CLPlacemark *firstPlaceMark = geocoderArray.firstObject;
            self.addressStr = firstPlaceMark.name;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)uploadBtnAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择媒体类型"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍摄"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                
                                                [self presentImagePickerVC:UIImagePickerControllerSourceTypeCamera];
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                
                                                [self presentImagePickerVC:UIImagePickerControllerSourceTypePhotoLibrary];
                                            }]];
    
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    [root presentViewController:alert animated:YES completion:nil];
}


- (void)presentImagePickerVC:(NSInteger)type {
    
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        if (type == UIImagePickerControllerSourceTypeCamera) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        if (type == UIImagePickerControllerSourceTypePhotoLibrary) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        self.imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    //    UIImage *originalImage = [editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"]; //原始图片
    //    UIImage *newImage = [Constants thumbnailWithImage:originalImage size:CGSizeMake(originalImage.size.width*0.7, originalImage.size.height*0.7)];
    
//    UIImage *newImage = [self thumbnailWithImage:image size:CGSizeMake(image.size.width*0.7, image.size.height*0.7)];
    UIImage *newImage = image;
    NSData *data = UIImageJPEGRepresentation(newImage, 0.8);
//    newImage = [UIImage imageWithData:data];
    
//    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath = [documentPath.firstObject stringByAppendingPathComponent:@"headImage.jpg"];
//
//    [data writeToFile:filePath atomically:YES];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *fileName = [formatter stringFromDate:date];
    fileName = [NSString stringWithFormat:@"%@.jpg",fileName];
    
    [self updatePersonInfo:data fileName:fileName];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updatePersonInfo:(NSData *)imageData fileName:(NSString *)fileName {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@track/uploadPhotos",kApiBaseURL];
    
    [manager POST:urlStr parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", @(uploadProgress.fractionCompleted));
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
       
        if (responseObject) {
            id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject
                                                         options:NSJSONReadingAllowFragments
                                                           error:nil];
            
            NSString *pathStr = jsonObj ?: @"";
            [self addPhotos:pathStr];
        }
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"请求失败:%@",error);
          }];
}

- (void)addPhotos:(NSString *)pathStr {
    NSString *userId = [ISSLoginUserModel shareInstance].loginUser.id;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    
    NetworkRequest *request = [[NetworkRequest alloc] init];
    [request completion:^(NSDictionary *result, BOOL success, BOOL networkError) {
        if (success) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"上传成功！"];
            [self.navigationController popViewControllerAnimated:YES];
            
            if (self.refreshAction) {
                self.refreshAction();
            }
        }
    }];
    [request addPhotos:pathStr
               licence:self.licence
         takePhotoTime:dateStr
                userId:userId
                  addr:self.addressStr];
}

//自动缩放到指定大小
- (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    
    if (nil == image) {
        newimage = nil;
    } else {
        UIGraphicsBeginImageContext(asize);
        [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

@end
