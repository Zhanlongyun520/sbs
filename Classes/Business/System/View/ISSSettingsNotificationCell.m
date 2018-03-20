//
//  ISSSettingsNotificationCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2018/1/14.
//  Copyright © 2018年 iSoftStone. All rights reserved.
//

#import "ISSSettingsNotificationCell.h"

@implementation ISSSettingsNotificationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _label = [[UILabel alloc] init];
        _label.font = ISSFont14;
        _label.textColor = ISSColorDardGray2;
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.bottom.equalTo(@0);
            make.width.equalTo(@100);
        }];
        
        _theSwitch = [[UISwitch alloc] init];
        _theSwitch.onTintColor = [UIColor colorWithRed:0.22 green:0.41 blue:0.85 alpha:1.00];
        [_theSwitch addTarget:self action:@selector(clickSwitch:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_theSwitch];
        [_theSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_label);
            make.right.equalTo(@-18);
        }];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.backgroundColor = ISSColorSeparatorLine;
        line.alpha = 0.5;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.right.bottom.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)clickSwitch:(UISwitch *)theSwitch {
    if (self.changeSwitch) {
        self.changeSwitch(theSwitch.isOn);
    }
}

@end
