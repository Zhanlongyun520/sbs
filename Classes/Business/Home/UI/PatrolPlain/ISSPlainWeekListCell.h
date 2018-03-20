//
//  ISSPlainWeekListCell.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseTableViewCell.h"
#import "ISSTaskListModel.h"

@interface ISSPlainWeekListCell : ISSBaseTableViewCell

@property (nonatomic, strong) ISSTaskListModel *model;
@property (nonatomic, strong) UIImageView *statusImageView;

@end
