//
//  ISSUserInfoBaseCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/28.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSUserInfoBaseCell.h"

@implementation ISSUserInfoBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"editcolumn"];
        [self.contentView addSubview:_icon];
        
        _keyLabel = [[UILabel alloc] init];
        _keyLabel.font = [UIFont systemFontOfSize:15];
        _keyLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_keyLabel];
        [_keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.left.equalTo(_icon.mas_right).offset(10);
            make.height.greaterThanOrEqualTo(@44);
            make.width.equalTo(@60);
        }];
        
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@22);
            make.left.equalTo(@15);
            make.centerY.equalTo(_keyLabel);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
