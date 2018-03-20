//
//  ISSMapEqiModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/28.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMapEqiModel.h"

@implementation ISSMapEqiModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"pm25": @"pm2_5",
                                                                  @"pm1": @"pm1_0"
                                                                  }];
}

@end
