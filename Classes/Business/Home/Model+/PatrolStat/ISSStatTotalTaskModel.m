//
//  ISSStatTotalTaskModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/13.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSStatTotalTaskModel.h"
#import "ISSTaskDepartmentModel.h"

@implementation ISSStatTotalTaskModel

- (void)setDepartmentId:(NSString *)departmentId {
    _departmentId = departmentId;
    
    _companyName = [ISSTaskDepartmentModel getCompanyName:departmentId];
}

- (void)setOff:(NSInteger)off {
    _off = off;
    
    _offDecimalNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", @(off)]];
}

@end
