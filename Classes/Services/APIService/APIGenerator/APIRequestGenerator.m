//
//  APIRequestGenerator.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIRequestGenerator.h"
#import "AFNetworking.h"
#import "APINetworkingConfiguration.h"
#import "APIBaseService.h"
#import "APIServiceFactory.h"
#import "APICommonParamsGenerator.h"
#import "SecurityService.h"
#import "APISignCreateManager.h"
//#import "NSString+CoculationSize.h"

#define kAppkey         @"7r0Ed2ErDIxh9OOmzxlN"

@interface APIRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer  * httpRequestSerializer;
@property (nonatomic, strong) AFHTTPRequestSerializer  * httpRequestJsonSerializer;
@property (nonatomic, strong) AFHTTPRequestSerializer  * httpRequestMultipartSerializer;

@end

@implementation APIRequestGenerator

#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kAPINetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}

- (AFHTTPRequestSerializer *)httpRequestMultipartSerializer
{
    if (_httpRequestMultipartSerializer == nil) {
        _httpRequestMultipartSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestMultipartSerializer.timeoutInterval = kAPINetworkingTimeoutSeconds;
        _httpRequestMultipartSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
        [_httpRequestMultipartSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    }
    return _httpRequestSerializer;
}

- (AFHTTPRequestSerializer *)httpRequestJsonSerializer
{
    if (_httpRequestJsonSerializer == nil) {
        _httpRequestJsonSerializer = [AFJSONRequestSerializer serializer];
        _httpRequestJsonSerializer.timeoutInterval = kAPINetworkingTimeoutSeconds;
        _httpRequestJsonSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestJsonSerializer;
}

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static APIRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[APIRequestGenerator alloc] init];
    });
    return sharedInstance;
}


- (NSMutableURLRequest *)recordRequestHistoryWithUrl:(NSString *)url params:(id)params method:(NSString *)httpMethod{
    NSMutableURLRequest * request;
    
    if ([ISSGlobalVariable sharedInstance].isJsonRequest == YES) {
        request = [self.httpRequestJsonSerializer requestWithMethod:httpMethod URLString:url parameters:params error:NULL];
        [ISSGlobalVariable sharedInstance].isJsonRequest = NO;
    }else{
        if ([ISSGlobalVariable sharedInstance].isMultipartContent == YES) {
            request = [self.httpRequestMultipartSerializer requestWithMethod:httpMethod URLString:url parameters:params error:NULL];
            [ISSGlobalVariable sharedInstance].isMultipartContent = NO;
        }else{
            request = [self.httpRequestSerializer requestWithMethod:httpMethod URLString:url parameters:params error:NULL];
        }
    }
    
    @try {
        //存最近十次的请求数据
        NSString *filePath = [ISSGlobalVariable recordRequestUrlFilePath];
        if (filePath) {
            
            NSMutableDictionary *rootDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
            NSMutableArray * dataArr = rootDic[@"requestList"]?:[[NSMutableArray alloc] init];
            
            NSDictionary *dic = @{@"method":httpMethod,
                                  @"params":params,
                                  @"requestUrl":url,
                                  @"requestTime":[[NSDate date] description]};
            
            
            @synchronized(dataArr) {
                [dataArr addObject:dic];
                
                while (dataArr.count > 10) {
                    [dataArr removeObjectAtIndex:0];
                }
                
            }
            
            NSDictionary *fileDic = @{@"requestList":dataArr};
            
            [fileDic writeToFile:filePath atomically:YES];
        }
        
    }
    @catch (NSException *exception) {}
    
    return request;
    
}

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    APIBaseService *service = [[APIServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    [allParams addEntriesFromDictionary:requestParams];
    NSString *url = [[NSString stringWithFormat:@"%@",service.apiBaseUrl] stringByAppendingString:methodName];
    NSLog(@"url: %@\nallParams : %@", url, allParams);
    NSMutableURLRequest *request = [self recordRequestHistoryWithUrl:url params:allParams method:@"GET"];
    request.timeoutInterval = kAPINetworkingTimeoutSeconds;
    return request;
}

- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    APIBaseService *service = [[APIServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    NSMutableDictionary *requestParamsDic = [NSMutableDictionary dictionaryWithDictionary:requestParams];
//    for (NSString *key in requestParamsDic.allKeys) {
//        if ([[requestParamsDic objectForKey:key] isEqualToString:@""]) {
//            [requestParamsDic removeObjectForKey:key];
//        }
//    }
    [allParams addEntriesFromDictionary:requestParamsDic];
    //service.apiBaseUrl，如需要修改路径
    [allParams addEntriesFromDictionary:@{@"service":methodName}];
    NSString *url = [[NSString stringWithFormat:@"%@",service.apiBaseUrl] stringByAppendingString:methodName];
    NSLog(@"url: %@\nallParams : %@", url, allParams);
    NSMutableURLRequest *request = [self recordRequestHistoryWithUrl:url params:allParams method:@"POST"];
    request.timeoutInterval = kAPINetworkingTimeoutSeconds;
    return request;
}

- (NSURLRequest *)generatePATCHRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    APIBaseService *service = [[APIServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    NSString *url = [[NSString stringWithFormat:@"%@",service.apiBaseUrl] stringByAppendingString:methodName];
    NSLog(@"url: %@\nallParams : %@", url, allParams);
    NSMutableURLRequest *request = [self recordRequestHistoryWithUrl:url params:allParams method:@"PATCH"];
    request.timeoutInterval = kAPINetworkingTimeoutSeconds;
    return request;
}


@end
