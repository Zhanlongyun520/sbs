//
//  ISSStatMonthTaskModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/12.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"

@protocol ISSStatMonthTaskModel

@end

@interface ISSStatMonthTaskModel : ISSBaseModel

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *departmentId;
@property (nonatomic, copy) NSString *companyName;

@end
