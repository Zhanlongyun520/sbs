//
//  Networking.m
//
//
//  Created by WuLeilei.
//  Copyright (c) 2016年 WuLeilei. All rights reserved.
//

#import "NetworkOperation.h"
#import "AFNetworking.h"
#import "TKAlertCenter.h"
#import "ISSUtilityMethod.h"
#import "LoadingManager.h"

NSString *const kHttpReturnCodeKey = @"success";
NSString *const kHttpReturnMsgKey = @"msg";
NSUInteger const kHttpRetryCount = 2;

@interface NetworkOperation ()
{
    BOOL _showError;
}

@end

@implementation NetworkOperation

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

// GET
- (void)getData {
    [self startRequest:HttpMethodGet];
}

// POST
- (void)postData {
    [self startRequest:HttpMethodPost];
}

// PATCH
- (void)patchData {
    [self startRequest:HttpMethodPatch];
}

// send request
- (void)startRequest:(HttpMethod)method {
    // show loading
    if (self.showLoading) {
        [[LoadingManager shareInstance] startLoadingInView:self.loadingSuperView];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", _baseURL, _path ? : @""];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSLog(@"\n接口地址：%@\n提交数据：%@", urlString, _params);
    
    if (_flag == NetworkFlagJSONResponse) {
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:_params error:nil];
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        [responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil]];
        manager.responseSerializer= responseSerializer;
        
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            [self requestCompleted:response responseObject:responseObject error:error];
        }];
        [dataTask resume];
    } else {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFHTTPRequestSerializer *serializer;
        if (_flag == NetworkFlagPostXWwwFormUrlencoded || _flag == NetworkFlagPostRow) {
            serializer = [AFJSONRequestSerializer serializer];
        } else {
            serializer = [AFHTTPRequestSerializer serializer];
        }
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        manager.requestSerializer = serializer;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
        manager.requestSerializer.timeoutInterval = (_files && _files.count > 0) ? 600 : 60;
        
        if (_files) {
            if (_flag == NetworkFlagUploadFiles) {
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            }
        }
        
        if (method == HttpMethodGet) {
            NSURLSessionDataTask *dataTask;
            dataTask = [manager GET:urlString
                         parameters:_params
                           progress:nil
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                [self requestCompleted:task.response responseObject:responseObject error:nil];
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                [self requestCompleted:task.response responseObject:nil error:error];
                            }];
            [dataTask resume];
        } else if (method == HttpMethodPatch) {
            NSError *error;
            NSMutableURLRequest *request = [serializer requestWithMethod:@"PATCH"
                                                               URLString:urlString
                                                              parameters:_params error:&error];
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSURLSessionDataTask *dataTask;
                dataTask = [manager dataTaskWithRequest:request
                                         uploadProgress:nil
                                       downloadProgress:nil
                                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                          [self requestCompleted:response responseObject:responseObject error:error];
                                      }];
                [dataTask resume];
            }
        } else if (method == HttpMethodPost) {
            if (_flag == NetworkFlagPostRow) {
                NSError *error;
                NSMutableURLRequest *request = [serializer requestWithMethod:@"POST"
                                                                   URLString:urlString
                                                                  parameters:_params error:&error];
                if (error) {
                    NSLog(@"Error: %@", error);
                } else {
                    NSURLSessionDataTask *dataTask;
                    dataTask = [manager dataTaskWithRequest:request
                                             uploadProgress:nil
                                           downloadProgress:nil
                                          completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                              [self requestCompleted:response responseObject:responseObject error:error];
                                          }];
                    [dataTask resume];
                }
            } else {
                NSMutableURLRequest *request;
                request = [serializer multipartFormRequestWithMethod:@"POST"
                                                           URLString:urlString
                                                          parameters:_params
                                           constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                               // 上传文件
                                               if (_files && _files.count > 0) {
                                                   NSLog(@"上传文件：%@", _files);
                                                   for (NSDictionary *fileDic in _files) {
                                                       NSError *error;
                                                       NSString *filePath = [fileDic objectForKey:@"path"];
                                                       NSURL *fileURL = [NSURL fileURLWithPath:filePath];
                                                       BOOL flag = [formData appendPartWithFileURL:fileURL name:[fileDic objectForKey:@"name"] error:&error];
                                                       if (!flag) {
                                                           NSLog(@"%@", error);
                                                       }
                                                   }
                                               }
                                           } error:nil];
                
                NSURLSessionUploadTask *uploadTask;
                uploadTask = [manager uploadTaskWithStreamedRequest:request
                                                           progress:^(NSProgress * _Nonnull uploadProgress) {
                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                   NSLog(@"%@", @(uploadProgress.fractionCompleted));
                                                               });
                                                           }
                                                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                      [self requestCompleted:response responseObject:responseObject error:error];
                                                  }];
                [uploadTask resume];
            }
        }
    }
}

// call back
- (void)requestCompleted:(NSURLResponse *)response responseObject:(id)responseObject error:(NSError *)error {
    [[LoadingManager shareInstance] stopLoading];
    
    BOOL retry = YES;
    BOOL success = YES;
    id result = responseObject;
    
    if (error) {
        success = NO;
        NSLog(@"请求失败: %@", error);
    }
    NSLog(@"返回数据：%@", [ISSUtilityMethod objToJson:responseObject]);
    
    NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
    if (error.code == -1011) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"会话超时"
                                                                                 message:@"请重新登录"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              [kDefaultCenter postNotificationName:kLoginOut object:nil];
                                                          }]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        return;
    } else if (statusCode == 0) {
        success = NO;
        NSString *errorDescription = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        [self showMessage:errorDescription ? [errorDescription substringToIndex:errorDescription.length - 1] : @"网络异常" needRetry:retry];
    } else if (statusCode == 200) {
        retry = NO;
        if (result) {
            if (_validateResult) {
                NSInteger code = [[result objectForKey:kHttpReturnCodeKey] integerValue];
                if (![kHttpReturnSuccCode containsObject:@(code)]) {
                    NSString *msg = [result objectForKey:kHttpReturnMsgKey];
                    [self showMessage:msg.length > 0 ? msg : @"操作失败" needRetry:retry];
                }
            }
        } else {
            success = NO;
            [self showMessage:@"数据异常" needRetry:retry];
        }
    } else {
        success = NO;
        [self showMessage:[NSString stringWithFormat:@"出错了，错误码：%@", @(statusCode)] needRetry:retry];
    }
    
    if (self.completion) {
        self.completion(result, success, statusCode == 0, retry);
    }
}

// show message
- (void)showMessage:(NSString *)message needRetry:(BOOL)retry {
    if (self.showError && (!retry || (retry && self.lastRequest))) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
    }
}

@end
