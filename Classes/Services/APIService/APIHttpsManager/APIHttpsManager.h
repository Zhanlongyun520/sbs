//
//  APIHttpsManager.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface APIHttpsManager : NSObject

+ (AFSecurityPolicy*)customSecurityPolicy;

@end
