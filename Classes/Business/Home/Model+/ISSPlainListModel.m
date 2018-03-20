//
//  ISSPlainListModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainListModel.h"

@implementation ISSPlainListModel

- (void)setStatus:(NSInteger)status {
    _status = status;
    
    _statusDescription = [NSString stringWithFormat:@"%@", @(status)];
    switch (status) {
        case 1:
            _statusDescription = @"待提交";
            break;
            
        case 2:
            _statusDescription = @"待审批";
            break;
            
        case 3:
            _statusDescription = @"已通过";
            break;
            
        case 4:
            _statusDescription = @"已打回";
            break;
            
        default:
            break;
    }
}

- (UIColor *)getStatusColor {
    UIColor *color;
    switch (_status) {
        case 1:
            color = [UIColor whiteColor];
            break;
            
        case 2:
            color = [UIColor colorWithRed:0.44 green:0.58 blue:0.89 alpha:1.00];
            break;
            
        case 3:
            color = [UIColor colorWithRed:0.56 green:0.84 blue:0.48 alpha:1.00];
            break;
            
        case 4:
            color = [UIColor colorWithRed:0.99 green:0.53 blue:0.55 alpha:1.00];
            break;
            
        default:
            break;
    }
    return color;
}

@end
