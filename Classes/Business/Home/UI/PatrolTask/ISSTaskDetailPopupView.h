//
//  ISSTaskDetailPopupView.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSTaskPositionModel.h"

@interface ISSTaskDetailPopupView : UIView

@property (nonatomic, strong) ISSTaskPositionModel *model;

@property (nonatomic, assign) BOOL readonly;

@property (nonatomic, copy) void (^dissmissBlock) (void);
@property (nonatomic, copy) void (^finishBlock) (ISSTaskPositionModel *model);

@end

