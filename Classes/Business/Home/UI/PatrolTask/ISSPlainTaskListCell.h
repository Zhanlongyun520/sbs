//
//  ISSPlainTaskListCell.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainPendingListCell.h"
#import "ISSTaskListModel.h"

@interface ISSPlainTaskListCell : ISSPlainPendingListCell

@property (nonatomic, strong) ISSTaskListModel *taskModel;

@property (nonatomic, copy) void (^taskDetailBlock) (ISSTaskListModel *model);
@property (nonatomic, copy) void (^taskCopyBlock) (ISSTaskListModel *model);

@end
