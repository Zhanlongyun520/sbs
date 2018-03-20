//
//  NetworkRequestBase.m
//
//
//  Created by WuLeilei.
//  Copyright (c) 2016年 WuLeilei. All rights reserved.
//

#import "NetworkRequestBase.h"
#import "AppDelegate.h"
#import "APIService.h"
#import "LoadingManager.h"

@interface NetworkRequestBase ()
{
    HttpMethod _method;
    NSUInteger _retryCount;
    CompletionBlock _completion;
}
@end

@implementation NetworkRequestBase

@synthesize showLoading = _showLoading;

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (id)init {
    self = [self initWithLoadingSuperview:((AppDelegate *)[UIApplication sharedApplication].delegate).window];
    return self;
}

- (id)initWithLoadingSuperview:(UIView *)view {
    self = [super init];
    if (self) {
        _retryCount = 0;
        _validateResult = YES;
        _showLoading = YES;
        _showError = YES;
        _loadingSuperView = view;
    }
    return self;
}

#pragma mark GET Method

- (void)getData {
    [self sendRequest:HttpMethodGet];
}

- (void)cachePhotos {
    if (_files && _files.count > 0) {
        NSMutableArray *fileArray = [NSMutableArray array];
        for (unsigned int i = 0; i < _files.count; i++) {
            NSDictionary *dic = [_files objectAtIndex:i];
            UIImage *originalImage = [dic objectForKey:@"image"];
            UIImage *image = originalImage;
            
            NSData *data;
            if (UIImagePNGRepresentation(image) == nil) {
                data = UIImageJPEGRepresentation(image, 1.0);
            } else {
                data = UIImagePNGRepresentation(image);
            }
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *cachePath = [paths objectAtIndex:0];
            NSString *uploadPath = [NSString stringWithFormat:@"%@/upload/", cachePath];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            BOOL existed = [fileManager fileExistsAtPath:uploadPath];
            if (!existed) {
                [fileManager createDirectoryAtPath:uploadPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            
            // 删除过期上传的文件
            NSError *error = nil;
            NSArray *fileList = [fileManager contentsOfDirectoryAtPath:uploadPath error:&error];
            for (NSString *path in fileList) {
                NSString *filePath = [NSString stringWithFormat:@"%@%@", uploadPath, path];
                NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:filePath error:&error];
                NSDate *modificationDate = [fileAttributes objectForKey:NSFileModificationDate];
                NSTimeInterval t = [[NSDate date] timeIntervalSinceDate:modificationDate];
                if (t >= 24 * 60 * 60) {
                    NSError *error;
                    [fileManager removeItemAtPath:filePath error:&error];
                    if (error) {
                        NSLog(@"%@", error);
                    }
                }
            }
            
            NSInteger radomFrom = 100000;
            NSInteger radomTo = 999999;
            NSInteger radom1 = radomFrom + (arc4random() % (radomTo - radomFrom + 1));
            NSInteger radom2 = radomFrom + (arc4random() % (radomTo - radomFrom + 1));
            
            NSString *fileName = [NSString stringWithFormat:@"upload-file-tmp-%@%@.jpg", @(radom1), @(radom2)];
            NSString *filePath = [NSString stringWithFormat:@"%@%@", uploadPath, fileName];
            
            [UIImageJPEGRepresentation(image, 0.6) writeToFile:filePath atomically:YES];
            
            NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            [newDic setObject:filePath forKey:@"path"];
            [fileArray addObject:newDic];
        }
        _files = fileArray;
    }
}

#pragma mark POST Method

- (void)postData {
    [[LoadingManager shareInstance] startLoading];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self cachePhotos];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self sendRequest:HttpMethodPost];
            [[LoadingManager shareInstance] stopLoading];
        });
    });
}

#pragma mark PATCH Method

- (void)patchData {
    [[LoadingManager shareInstance] startLoading];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self cachePhotos];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self sendRequest:HttpMethodPatch];
            [[LoadingManager shareInstance] stopLoading];
        });
    });
}

#pragma mark Request Method

- (void)sendRequest:(HttpMethod)type {
    _retryCount++;
    _method = type;
    
    NetworkOperation *networkOperation = [[NetworkOperation alloc] init];
    networkOperation.flag = _flag;
    networkOperation.baseURL = _baseURL ? : kApiBaseURL;
    networkOperation.path = _path;
    networkOperation.params = _params;
    networkOperation.files = _files;
    networkOperation.loadingSuperView = _loadingSuperView;
    networkOperation.validateResult = _validateResult;
    networkOperation.showLoading = _showLoading;
    networkOperation.showError = _showError;
    networkOperation.lastRequest = _retryCount == kHttpRetryCount;
    networkOperation.completion = ^(id result, BOOL success, BOOL networkError, BOOL retry) {
        [self privateRequestCompleted:result success:success networkError:networkError needRetry:retry];
    };
    
    if (type == HttpMethodGet) {
        [networkOperation getData];
    } else if (type == HttpMethodPost) {
        [networkOperation postData];
    } else if (type == HttpMethodPatch) {
        [networkOperation patchData];
    }
}

- (void)privateRequestCompleted:(id)result success:(BOOL)success networkError:(BOOL)networkError needRetry:(BOOL)retry {
    if (success) {
        if (_validateResult) {
            success = NO;
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dicResult = (NSDictionary *)result;
                NSArray *allKeys = [dicResult allKeys];
                if ([allKeys containsObject:kHttpReturnCodeKey]) {
                    NSInteger code = [[dicResult objectForKey:kHttpReturnCodeKey] integerValue];
                    if ([kHttpReturnSuccCode containsObject:@(code)]) {
                        success = YES;
                    }
                }
            }
        }
    }
    [self requestCompleted:result succ:success networkError:networkError needRetry:retry];
}

// 定义回调
- (void)completion:(CompletionBlock)completion {
    _completion = completion;
}

// 回调
- (void)requestCompleted:(id)result succ:(BOOL)succ networkError:(BOOL)networkError needRetry:(BOOL)retry {
    if (!succ && retry) {
        if (_retryCount < kHttpRetryCount) {
            [self sendRequest:_method];
            return;
        }
    }
    
    if (_completion) {
        _completion(result, succ, networkError);
    }
}

@end
