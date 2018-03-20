//
//  APIProxy.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/19.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIURLResponse.h"

typedef void(^APICallBack) (APIURLResponse *response);

@interface APIProxy : NSObject

+ (instancetype)sharedInstance;

- (void)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(APICallBack)success fail:(APICallBack)fail;

- (void)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(APICallBack)success fail:(APICallBack)fail;

- (void)callPATCHWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(APICallBack)success fail:(APICallBack)fail;

- (void)callPUTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(APICallBack)success fail:(APICallBack)fail;

- (void)callDELETEWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(APICallBack)success fail:(APICallBack)fail;

@end
