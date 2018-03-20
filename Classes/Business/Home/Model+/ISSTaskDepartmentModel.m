//
//  ISSTaskDepartmentModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTaskDepartmentModel.h"

@implementation ISSTaskDepartmentModel

+ (instancetype)shareInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

+ (NSString *)getCompanyName:(NSString *)pid {
    NSString *name = @"";
    if (pid.length > 0) {
        for (ISSTaskDepartmentModel *model in [ISSTaskDepartmentModel shareInstance].dataList) {
            if ([model.value isEqualToString:pid]) {
                name = model.content;
                break;
            }
        }
    }
    return name;
}

@end
