//
//  ISSStatTotalTaskModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/13.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"

@interface ISSStatTotalTaskModel : ISSBaseModel

@property (nonatomic, assign) NSInteger unCount;
@property (nonatomic, assign) NSInteger off;
@property (nonatomic, strong) NSDecimalNumber *offDecimalNumber;
@property (nonatomic, copy) NSString *departmentId;
@property (nonatomic, copy) NSString *companyName;

@end
