//
//  APISignCreateManager.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APISignCreateManager : NSObject

+ (NSDictionary *)postSignWithDic:(NSMutableDictionary *)dict methodName:(NSString *)methodName;

+ (NSDictionary *)getSignWithDic:(NSMutableDictionary *)dict methodName:(NSString *)methodName;

+ (NSString *)createSingByDictionary:(NSDictionary *)dict;

@end
