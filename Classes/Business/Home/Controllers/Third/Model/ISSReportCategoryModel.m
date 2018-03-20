//
//  ISSReportCategoryModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportCategoryModel.h"

@implementation ISSReportCategoryModel

+ (instancetype)shareInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

+ (NSString *)getCategoryName:(NSString *)pid {
    NSString *name = @"";
    if (pid.length > 0) {
        for (ISSReportCategoryModel *model in [ISSReportCategoryModel shareInstance].dataList) {
            if ([model.value isEqualToString:pid]) {
                name = model.content;
                break;
            }
        }
    }
    return name;
}

@end
