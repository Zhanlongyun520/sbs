//
//  ISSTrackPopupCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTrackPopupCell.h"

@interface ISSTrackPopupCell ()
{
    UILabel *_label;
}
@end

@implementation ISSTrackPopupCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"track-list-icon"]];
        [self.contentView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@16);
            make.height.equalTo(@13);
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(@15);
        }];
        
        UIImageView *accessory = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"litarrow"]];
        [self.contentView addSubview:accessory];
        [accessory mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@5.5);
            make.height.equalTo(@9);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(@-15);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(10);
            make.right.equalTo(accessory.mas_left);
            make.top.bottom.equalTo(@0);
            make.height.equalTo(@55);
        }];
        _label = label;
    }
    return self;
}

- (void)setModel:(ISSTaskListModel *)model {
    _model = model;
    
    _label.text = model.taskName;
}

@end
