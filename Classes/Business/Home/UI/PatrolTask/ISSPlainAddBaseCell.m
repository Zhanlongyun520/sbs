//
//  ISSPlainAddBaseCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainAddBaseCell.h"

@implementation ISSPlainAddBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"plan-list-icon"];
        [self.contentView addSubview:icon];
        
        _keyLabel = [[UILabel alloc] init];
        _keyLabel.font = [UIFont systemFontOfSize:15];
        _keyLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_keyLabel];
        [_keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(icon.mas_right).offset(10);
            make.height.equalTo(@54);
            make.width.equalTo(@100);
        }];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@22);
            make.left.equalTo(@15);
            make.centerY.equalTo(_keyLabel);
        }];
    }
    return self;
}

@end
