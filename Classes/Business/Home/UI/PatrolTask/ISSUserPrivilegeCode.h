//
//  ISSUserPrivilegeCode.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/14.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"

@interface ISSUserPrivilegeCode : ISSBaseModel

@property(nonatomic, assign) BOOL VS; // 视频监控

@property(nonatomic, assign) BOOL ENVIRMENT_VIEW; // 环境监测

@property(nonatomic, assign) BOOL M_PATROL; // 三方协同
@property(nonatomic, assign) BOOL M_PATROL_REPORT; // 三方协同 巡查报告
@property(nonatomic, assign) BOOL M_PATROL_ACCEPT; // 三方协同 报告验收

@property(nonatomic, assign) BOOL MUCKCAR_MONITOR; // 渣土车监控

@property(nonatomic, assign) BOOL M_CPINFO; // 巡查概况

@property(nonatomic, assign) BOOL M_CPP; // 巡查计划（）
@property(nonatomic, assign) BOOL M_CPPA; // 巡查计划审批

@property(nonatomic, assign) BOOL M_CPT; // 巡查任务

@property(nonatomic, assign) BOOL M_CPM; // 巡查监控

@end
