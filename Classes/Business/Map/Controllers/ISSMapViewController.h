//
//  ISSMapViewController.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMapBaseViewController.h"

@interface ISSMapViewController : ISSMapBaseViewController

// 0：tabbar 全部； 1：视频 2；环境
//涉及到三个类的修改，1、ISSVideoListViewController；2、ISSEnvironmentListViewController；3、ISSEnvironmentRealTimeViewController
@property (nonatomic, assign) NSInteger showType;
@property (nonatomic, strong) NSString *selectedDeviceId;

// 假如要显示单个视频或者单个环境，需要判断id去添加，纯粹为了拓展，已实现
@property (nonatomic) bool showSinger;

@end
