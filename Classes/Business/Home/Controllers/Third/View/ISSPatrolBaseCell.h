//
//  ISSPatrolBaseCell.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/25.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseTableViewCell.h"
#import "NSString+Size.h"
#import "ISSReportDetailModel.h"

@interface ISSPatrolBaseCell : ISSBaseTableViewCell
{
    UILabel *_titleLabel;
    UILabel *_statusLabel;
    UILabel *_dateLabel;
    UILabel *_nameLabel;
    UILabel *_companyLabel;
    UIView *_buttonView;
}

@property (nonatomic, strong) ISSReportDetailModel *model;

@property (nonatomic, copy) void (^showDetailBlock) (NSInteger index);

- (void)clickButton:(UIButton *)button;

@end
