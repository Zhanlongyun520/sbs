//
//  ISSReportReplyRightCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/23.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportReplyRightCell.h"

@implementation ISSReportReplyRightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-20);
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
        }];
        
        _bubbleImageView.image = [[UIImage imageNamed:@"report-chat-right"] stretchableImageWithLeftCapWidth:60 topCapHeight:40];
        [_bubbleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_headerImageView.mas_left).offset(-5);
            make.left.equalTo(@15);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
