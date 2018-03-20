//
//  ISSStatMonthUserModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/12.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"
#import "ISSTaskPeopleModel.h"

@interface ISSStatMonthUserModel : ISSBaseModel

@property (nonatomic, assign) NSInteger unCount;
@property (nonatomic, assign) NSInteger offCount;
@property (nonatomic, strong) NSDecimalNumber *offCountDecimalNumber;
@property (nonatomic, strong) ISSTaskPeopleModel *user;

@end
