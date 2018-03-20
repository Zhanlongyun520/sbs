//
//  ISSTaskListModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTaskListModel.h"

@implementation ISSTaskListModel

- (NSString *)taskStatusName {
    NSString *taskStatusName = @"未知";
    switch (_taskStatus) {
        case ISSTaskStatusNotStart:
            taskStatusName = @"待执行";
            break;
            
        case ISSTaskStatusDoing:
            taskStatusName = @"进行中";
            break;
            
        case ISSTaskStatusDone:
            taskStatusName = @"已完成";
            break;
            
        case ISSTaskStatusDelay:
            taskStatusName = @"已延期";
            break;
            
        default:
            break;
    }
    return taskStatusName;
}

- (UIColor *)taskStatusColor {
    UIColor *color = [UIColor lightGrayColor];
    switch (_taskStatus) {
        case ISSTaskStatusNotStart:
            color = [UIColor colorWithRed:0.99 green:0.49 blue:0.51 alpha:1.00];
            break;
            
        case ISSTaskStatusDoing:
            color = [UIColor colorWithRed:0.51 green:0.84 blue:0.78 alpha:1.00];
            break;
            
        case ISSTaskStatusDone:
            color = [UIColor colorWithRed:0.45 green:0.58 blue:0.89 alpha:1.00];
            break;
            
        case ISSTaskStatusDelay:
            color = [UIColor redColor];
            break;
            
        default:
            break;
    }
    return color;
}

@end
