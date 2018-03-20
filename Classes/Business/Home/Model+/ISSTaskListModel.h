//
//  ISSTaskListModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"
#import "ISSTaskPositionModel.h"
#import "ISSPlainListCreatorModel.h"
#import "ISSTaskPeopleModel.h"
#import "ISSPlainListModel.h"

typedef NS_ENUM(NSInteger, ISSTaskStatus) {
    ISSTaskStatusNotStart = 0,
    ISSTaskStatusDoing = 1,
    ISSTaskStatusDone = 2,
    ISSTaskStatusDelay = 3
};

@interface ISSTaskListModel : ISSBaseModel

@property(nonatomic, strong) NSString *planId;
@property(nonatomic, assign) ISSPlainStatus planStatus;
@property(nonatomic, strong) NSString *taskContent;
@property(nonatomic, strong) NSString *taskId;
@property(nonatomic, strong) NSString *taskName;
@property(nonatomic, assign) NSInteger taskType;
@property(nonatomic, strong) NSString *taskStart;
@property(nonatomic, strong) NSString *taskTimeEnd;
@property(nonatomic, strong) NSString *taskTimeStart;
@property(nonatomic, strong) ISSPlainListCreatorModel *creator;
@property(nonatomic, strong) NSArray <ISSTaskPositionModel> *patrolPositions;
@property(nonatomic, strong) NSArray <ISSTaskPeopleModel> *users;

@property(nonatomic, assign) ISSTaskStatus taskStatus;
@property(nonatomic, copy) NSString *taskStatusName;

- (UIColor *)taskStatusColor;

@end
