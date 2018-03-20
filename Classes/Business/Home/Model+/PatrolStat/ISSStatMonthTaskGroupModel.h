//
//  ISSStatMonthTaskGroupModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/12.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"
#import "ISSStatMonthTaskModel.h"

@interface ISSStatMonthTaskGroupModel : ISSBaseModel

@property (nonatomic, strong) NSArray <ISSStatMonthTaskModel> *all;
@property (nonatomic, strong) NSArray <ISSStatMonthTaskModel> *off;

@end
