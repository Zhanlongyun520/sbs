//
//  ISSMonitorListModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMonitorListModel.h"

@implementation ISSMonitorListModel

- (void)setPatrolTask:(ISSTaskListModel *)patrolTask {
    _patrolTask = patrolTask;
    
    if (patrolTask) {
        _patrolTaskArray = @[patrolTask];
    }
}

@end
