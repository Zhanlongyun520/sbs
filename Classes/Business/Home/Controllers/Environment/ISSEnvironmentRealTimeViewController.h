//
//  ISSEnvironmentRealTimeViewController.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSViewController.h"
#import "ISSEnvironmentListModel.h"

@interface ISSEnvironmentRealTimeViewController : ISSViewController

@property(nonatomic ,strong ) ISSEnvironmentListModel          * environmentListModel;

@property(nonatomic, assign) BOOL isComeFromHistory;

@end
