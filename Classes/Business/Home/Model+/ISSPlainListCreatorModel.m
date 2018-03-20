//
//  ISSPlainListCreatorModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainListCreatorModel.h"
#import "ISSTaskDepartmentModel.h"

@implementation ISSPlainListCreatorModel

- (void)setDepartmentId:(NSString *)departmentId {
    _departmentId = departmentId;
    
    _companyName = [ISSTaskDepartmentModel getCompanyName:departmentId];
}

@end
