//
//  ISSTaskPositionModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTaskPositionModel.h"

@implementation ISSTaskPositionModel

- (NSString *)getStatusName {
    NSString *statusName = @"未知";
    switch (_status) {
        case ISSTaskPositionStatusNew:
            statusName = @"未完成";
            break;
            
        case ISSTaskPositionStatusFinished:
            statusName = @"已完成";
            break;
            
        default:
            break;
    }
    return statusName;
}

- (UIColor *)getStatusColor {
    UIColor *color = [UIColor whiteColor];
    switch (_status) {
        case ISSTaskPositionStatusNew:
            color = [UIColor colorWithRed:0.98 green:0.62 blue:0.62 alpha:1.00];
            break;
            
        case ISSTaskPositionStatusFinished:
            color = [UIColor colorWithRed:0.44 green:0.83 blue:0.76 alpha:1.00];
            break;
            
        default:
            break;
    }
    return color;
}

@end
