//
//  ISSPlainPendingListCell.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseTableViewCell.h"
#import "ISSPlainListModel.h"

@interface ISSPlainPendingListCell : ISSBaseTableViewCell
{
    UILabel *_titleLabel;
    UILabel *_statusLabel;
    UILabel *_dateLabel;
    UILabel *_nameLabel;
    UILabel *_companyLabel;
    UIButton *_button;
    UIImageView *_line;
}

@property (nonatomic, strong) ISSPlainListModel *model;

@property (nonatomic, copy) void (^detailBlock) (ISSPlainListModel *model);

@end
