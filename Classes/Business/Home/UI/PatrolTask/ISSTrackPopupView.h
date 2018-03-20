//
//  ISSTrackPopupView.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSMonitorListModel.h"

@interface ISSTrackPopupView : UIView

@property (nonatomic, strong) ISSMonitorListModel *model;

@property (nonatomic, copy) void (^dissmissBlock) (void);
@property (nonatomic, copy) void (^showDetailBlock) (ISSTaskListModel *model);

@end
