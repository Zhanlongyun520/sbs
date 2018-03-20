//
//  ISSTaskDepartmentModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"

@interface ISSTaskDepartmentModel : ISSBaseModel

@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSMutableArray *dataList;

+ (instancetype)shareInstance;
+ (NSString *)getCompanyName:(NSString *)pid;

@end
