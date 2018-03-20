//
//  ISSReportRUserCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportRUserCell.h"

@implementation ISSReportRUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.layer.cornerRadius = 16;
        _headerImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_headerImageView];
        [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@32);
            make.left.equalTo(@15);
            make.top.equalTo(@14);
            make.bottom.equalTo(@-14);
        }];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headerImageView.mas_right).offset(10);
            make.top.equalTo(_headerImageView);
            make.height.equalTo(@20);
            make.right.equalTo(@-15);
        }];
        
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont systemFontOfSize:12];
        _typeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_typeLabel];
        [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_nameLabel);
            make.top.equalTo(_nameLabel.mas_bottom);
            make.bottom.equalTo(_headerImageView);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
