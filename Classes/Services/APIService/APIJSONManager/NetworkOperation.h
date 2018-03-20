//
//  NetworkOperation.h
//
//
//  Created by WuLeilei.
//  Copyright (c) 2016年 WuLeilei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kHttpReturnSuccCode @[@1]

typedef NS_ENUM(NSUInteger, NetworkFlag) {
    NetworkFlagPostXWwwFormUrlencoded = 101,
    NetworkFlagPostRow = 102,
    NetworkFlagUploadFiles = 103,
    NetworkFlagJSONResponse = 104
};

typedef NS_ENUM(NSUInteger, HttpMethod) {
    HttpMethodPost = 1,
    HttpMethodGet = 2,
    HttpMethodPatch = 3
};

FOUNDATION_EXPORT NSString *const kHttpReturnCodeKey;
FOUNDATION_EXPORT NSString *const kHttpReturnMsgKey;
FOUNDATION_EXPORT NSUInteger const kHttpRetryCount;

@interface NetworkOperation : NSObject

@property (nonatomic, strong) NSString *baseURL;//公用地址
@property (nonatomic, strong) NSString *path;//单个api自己的地址
@property (nonatomic, strong) NSDictionary *params;//参数
@property (nonatomic, strong) NSArray *files;//图片
@property (nonatomic, strong) UIView *loadingSuperView;//loading加载的superview
@property (nonatomic, assign) BOOL validateResult;//是否根据固定结构验证返回数据，不验证则直接回调原始数据
@property (nonatomic, assign) BOOL showLoading;//是否显示加载
@property (nonatomic, assign) BOOL showError;//是否弹出错误
@property (nonatomic, assign) BOOL lastRequest;//重复请求时调用
@property (nonatomic, assign) NetworkFlag flag;//请求标记
@property (nonatomic, strong) void (^completion) (id result, BOOL success, BOOL networkError, BOOL retry);

- (void)getData;
- (void)postData;
- (void)patchData;

@end
