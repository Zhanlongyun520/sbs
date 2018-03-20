//
//  APIService.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/19.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseService.h"

// 生产
#define kApiBaseURL @"http://111.47.21.51:19090/"
#define kImageBaseURL kApiBaseURL

// 测试
//#define kApiBaseURL @"http://61.160.82.83:19090/ctess/"
//#define kImageBaseURL kApiBaseURL

@interface APIService : APIBaseService<APIBaseServiceProtocol>

@end
