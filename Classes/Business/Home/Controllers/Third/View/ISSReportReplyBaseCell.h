//
//  ISSReportReplyBaseCell.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseTableViewCell.h"
#import "ISSReportReplyModel.h"

@interface ISSReportReplyBaseCell : ISSBaseTableViewCell
{
    UILabel *_dateLabel;
    UIImageView *_headerImageView;
    UILabel *_nameLabel;
    UILabel *_statusLabel;
    UIImageView *_bubbleImageView;
    UILabel *_userKeyLabel;
    UILabel *_userValueLabel;
    UILabel *_timeKeyLabel;
    UILabel *_timeValueLabel;
    UIImageView *_lineImageView;
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    UIView *_photoView;
}

@property (nonatomic, strong) ISSReportReplyModel *model;

@property (nonatomic, copy) void (^showPhotoBlock) (ISSReportReplyModel *model, NSInteger index);

@end
