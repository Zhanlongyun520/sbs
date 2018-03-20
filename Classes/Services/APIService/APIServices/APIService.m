//
//  APIService.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/19.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIService.h"
#import "ISSGlobalVariable.h"

@implementation APIService

#pragma mark - AIFServiceProtocal
- (BOOL)isOnline
{
    return YES;
}

- (NSString *)onlineApiBaseUrl
{
//    if ([ISSGlobalVariable serverBaseUrlIsTest])
//    {
//        return @"http://10.28.67.116/";
//    }
    //甘霖
//    return @"http://10.28.67.116:80/";
    //涂林丽
//    return @"http://10.28.68.103:8082/";
    //南烨
//    return @"http://10.28.68.104:8080/";
    //马金涛
//    return @"http://10.28.68.214:8080/ctess/";
    //文昊窘
//    return @"http://10.28.68.112:8085/";
    
    //软通内网
//    return @"http://10.177.129.42:19090/ctess/";
    //外网
    return kApiBaseURL;
    
}

- (NSString *)onlineApiVersion
{
    return @"";
}

- (NSString *)onlinePrivateKey
{
    return @"";
}

- (NSString *)onlinePublicKey
{
    return @"";
}

- (NSString *)offlineApiBaseUrl
{
    return self.onlineApiBaseUrl;
}

- (NSString *)offlineApiVersion
{
    return self.onlineApiVersion;
}

- (NSString *)offlinePrivateKey
{
    return self.onlinePrivateKey;
}

- (NSString *)offlinePublicKey
{
    return self.onlinePublicKey;
}

@end
