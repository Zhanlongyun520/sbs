//
//  ISSStatTaskCompareView.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSStatBaseView.h"

@interface ISSStatTaskCompareView : ISSStatBaseView

@property (nonatomic, strong) NSArray *departmentIndexArray;

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, copy) void (^showDepartmentArrayPickerBlock) (NSArray *departmentIndexArray, NSInteger tag);

@end
