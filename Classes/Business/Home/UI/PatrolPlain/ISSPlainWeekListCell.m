//
//  ISSPlainWeekListCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainWeekListCell.h"

@interface ISSPlainWeekListCell () {
    UILabel *_titleLabel;
    UILabel *_dateLabel;
}
@end

@implementation ISSPlainWeekListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _statusImageView = [[UIImageView alloc] init];
        _statusImageView.layer.cornerRadius = 3;
        [self.contentView addSubview:_statusImageView];
        [_statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-15);
            make.width.height.equalTo(@6);
            make.centerY.equalTo(self.contentView);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@17);
            make.top.right.equalTo(@0);
            make.height.equalTo(@40);
        }];
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor grayColor];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_titleLabel);
            make.top.equalTo(_titleLabel.mas_bottom);
            make.bottom.equalTo(@-10);
            make.height.equalTo(@13);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ISSTaskListModel *)model {
    _model = model;
    
    _titleLabel.text = model.taskName;
    _dateLabel.text = [NSString stringWithFormat:@"%@ | %@", model.taskTimeStart, model.taskTimeEnd];
//    _statusImageView.backgroundColor = [model taskStatusColor];
}

@end
