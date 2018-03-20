//
//  ISSTaskPeopleModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTaskPeopleModel.h"
#import "ISSTaskDepartmentModel.h"

@implementation ISSTaskPeopleModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"des": @"description"
                                                                  }];
}

- (void)setDepartmentId:(NSString *)departmentId {
    _departmentId = departmentId;
}

- (NSString *)companyName {
    NSString *name = [ISSTaskDepartmentModel getCompanyName:_departmentId];
    return name;
}

@end
