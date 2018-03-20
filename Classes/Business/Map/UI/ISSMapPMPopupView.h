//
//  ISSMapPMPopupView.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/28.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSVideoModel.h"

@interface ISSMapPMPopupView : UIView

@property (nonatomic, strong) ISSVideoModel *model;

@property (nonatomic, copy) void (^dissmissBlock) (void);
@property (nonatomic, copy) void (^showDetailBlock) (ISSMapEqiModel *model, NSInteger index);

- (instancetype)init:(BOOL)hasTabBar;

@end
