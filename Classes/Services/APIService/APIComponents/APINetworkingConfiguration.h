//
//  APINetworkingConfiguration.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

typedef NS_ENUM(NSUInteger, APIURLResponseStatus)
{
    APIURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的RTApiBaseManager来决定。
    APIURLResponseStatusErrorTimeout,
    APIURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
};

static NSTimeInterval kAPINetworkingTimeoutSeconds = 20.0f;

extern NSString *const kAPIServiceWanJiKa;
