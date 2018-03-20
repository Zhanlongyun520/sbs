//
//  ISSStatMonthTaskModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/12.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSStatMonthTaskModel.h"
#import "ISSTaskDepartmentModel.h"

@implementation ISSStatMonthTaskModel

- (void)setDepartmentId:(NSString *)departmentId {
    _departmentId = departmentId;
    
    _companyName = [ISSTaskDepartmentModel getCompanyName:departmentId];
}

@end
