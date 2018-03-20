//
//  NetworkRequestBase.h
//
//
//  Created by WuLeilei.
//  Copyright (c) 2016年 WuLeilei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkOperation.h"

typedef void (^CompletionBlock) (NSDictionary *result, BOOL success, BOOL networkError);

@interface NetworkRequestBase : NSObject
{
    NetworkFlag _flag;
    NSString *_baseURL;
    NSString *_path;
    NSDictionary *_params;
    NSArray *_files;
    UIView *_loadingSuperView;
    BOOL _validateResult;
    BOOL _showError;
    BOOL _showLoading;
}

@property (nonatomic, assign) BOOL showLoading;

- (id)initWithLoadingSuperview:(UIView *)view;
- (void)getData;
- (void)postData;
- (void)patchData;
- (void)requestCompleted:(id)result succ:(BOOL)succ networkError:(BOOL)networkError needRetry:(BOOL)retry;
- (void)completion:(CompletionBlock)completion;

@end
