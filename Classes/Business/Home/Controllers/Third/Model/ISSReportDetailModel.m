//
//  ISSReportDetailModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportDetailModel.h"
#import "ISSReportCategoryModel.h"

@implementation ISSReportDetailModel

- (void)setStatus:(NSString *)status {
    _status = status;
    
    NSInteger sta = [status integerValue];
    switch (sta) {
        case 1:
            _statusDes = @"已提交";
            break;
            
        case 2:
            _statusDes = @"待处理";
            break;
            
        case 3:
            _statusDes = @"待回访";
            break;
            
        case 4:
            _statusDes = @"已退回";
            break;
            
        case 5:
            _statusDes = @"已验收";
            break;
            
        default:
            break;
    }
}

- (void)setCategory:(NSString *)category {
    _category = category;
    _categoryDes = [ISSReportCategoryModel getCategoryName:category];
}

- (UIColor *)getStatusColor {
    UIColor *color;
    switch ([_status integerValue]) {
        case 1:
            color = [UIColor colorWithRed:0.52 green:0.64 blue:0.98 alpha:1.00];
            break;
            
        case 2:
            color = [UIColor colorWithRed:0.52 green:0.64 blue:0.98 alpha:1.00];
            break;
            
        case 3:
            color = [UIColor colorWithRed:0.92 green:0.60 blue:0.46 alpha:1.00];
            break;
            
        case 4:
            color = [UIColor colorWithRed:0.96 green:0.53 blue:0.54 alpha:1.00];
            break;
            
        case 5:
            color = [UIColor colorWithRed:0.55 green:0.84 blue:0.78 alpha:1.00];
            break;
            
        default:
            break;
    }
    return color;
}

@end
