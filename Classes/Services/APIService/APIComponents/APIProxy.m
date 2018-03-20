//
//  APIProxy.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/19.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIProxy.h"
#import "AFNetworking.h"
#import "APIRequestGenerator.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "APIHttpsManager.h"

#import "APIBaseService.h"
#import "APICommonParamsGenerator.h"
#import "APIServiceFactory.h"
#import "APISignCreateManager.h"



static NSString * const kAXApiProxyDispatchItemKeyCallbackSuccess = @"kAXApiProxyDispatchItemCallbackSuccess";
static NSString * const kAXApiProxyDispatchItemKeyCallbackFail = @"kAXApiProxyDispatchItemCallbackFail";

@interface APIProxy ()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestId;

//AFNetworking stuff
@property (nonatomic, strong) AFHTTPSessionManager *operationManager;

@end

@implementation APIProxy

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static APIProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[APIProxy alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (void)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(APICallBack)success fail:(APICallBack)fail
{
    NSURLRequest *request = [[APIRequestGenerator sharedInstance] generateGETRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    [self callApiWithRequest:request success:success fail:fail];
}

- (void)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(APICallBack)success fail:(APICallBack)fail
{
    NSURLRequest *request = [[APIRequestGenerator sharedInstance] generatePOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    [self callApiWithRequest:request success:success fail:fail];
}

- (void)callPATCHWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(APICallBack)success fail:(APICallBack)fail
{
    NSURLRequest *request = [[APIRequestGenerator sharedInstance] generatePATCHRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    [self callApiWithRequest:request success:success fail:fail];
}
- (void)callPUTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(APICallBack)success fail:(APICallBack)fail
{
    NSURLRequest *request = [[APIRequestGenerator sharedInstance] generatePUTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    [self callApiWithRequest:request success:success fail:fail];
}

- (void)callDELETEWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(APICallBack)success fail:(APICallBack)fail
{
    NSURLRequest *request = [[APIRequestGenerator sharedInstance] generateDELETERequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    [self callApiWithRequest:request success:success fail:fail];
}



#pragma mark - private methods
/** 这个函数存在的意义在于，如果将来要把AFNetworking换掉，只要修改这个函数的实现即可。 */
- (void)callApiWithRequest:(NSURLRequest *)request success:(APICallBack)success fail:(APICallBack)fail
{
    [[self.operationManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        //response:响应头
//        NSLog(@"%@",response);
        if (error) {
            NSLog(@"--->HTTP请求错误：%@",error);
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
            }
            if(error.code == -999)
            {
                return ;
            }
            APIURLResponse *urlResponse = [[APIURLResponse alloc] initWithResponseData:responseObject error:error];
            if (fail) {
                fail(urlResponse);
            }
        } else {
            APIURLResponse *urlResponse = [[APIURLResponse alloc] initWithResponseData:responseObject status:APIURLResponseStatusSuccess];
            NSLog(@"--->HTTP请求成功");
            if (success) {
                success(urlResponse);
            }
        }
    }] resume];
}

#pragma mark - getters and setters
- (NSMutableDictionary *)dispatchTable
{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)operationManager
{
    if (_operationManager == nil) {
        _operationManager = [AFHTTPSessionManager manager];
        _operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _operationManager.responseSerializer.acceptableContentTypes = [_operationManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        //         [_operationManager setSecurityPolicy:[WJHttpsManager customSecurityPolicy]];
    }
    return _operationManager;
}


@end
