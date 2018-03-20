//
//  ISSMonitorListModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"
#import "ISSTaskListModel.h"
#import "ISSTaskPeopleModel.h"

@interface ISSMonitorListModel : ISSBaseModel

@property (nonatomic, copy) NSString *id;
@property(nonatomic, assign) double latitude;
@property(nonatomic, assign) double longitude;
@property (nonatomic, copy) NSString *taskId;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) ISSTaskListModel *patrolTask;
@property (nonatomic, copy) ISSTaskPeopleModel *user;

@property (nonatomic, strong) NSArray *patrolTaskArray;

@end
