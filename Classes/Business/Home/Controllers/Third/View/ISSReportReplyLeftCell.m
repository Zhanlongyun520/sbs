//
//  ISSReportReplyLeftCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/23.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportReplyLeftCell.h"

@implementation ISSReportReplyLeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
        }];
        
        _bubbleImageView.image = [[UIImage imageNamed:@"report-chat-left"] stretchableImageWithLeftCapWidth:60 topCapHeight:40];
        [_bubbleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headerImageView.mas_right).offset(5);
            make.right.equalTo(@-15);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
