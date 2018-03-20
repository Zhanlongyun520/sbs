//
//  ISSTaskDetailViewController.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMapBaseViewController.h"

@interface ISSTaskDetailViewController : ISSMapBaseViewController

@property (nonatomic, copy) NSString *taskId;
@property (nonatomic, copy) NSString *taskName;

@property (nonatomic, assign) BOOL readonly;

@end
