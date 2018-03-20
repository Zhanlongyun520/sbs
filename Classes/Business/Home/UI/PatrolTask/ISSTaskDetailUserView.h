//
//  ISSTaskDetailUserView.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSTaskPeopleModel.h"

@interface ISSTaskDetailUserView : UIView

@property (nonatomic, strong) ISSTaskPeopleModel *model;
@property (nonatomic, assign) BOOL selected;

@end
