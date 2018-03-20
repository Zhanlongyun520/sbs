//
//  ISSPlainAddDateCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainAddDateCell.h"

@implementation ISSPlainAddDateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.keyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@109);
        }];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.90 alpha:1.00];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@120);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(@0);
            make.height.equalTo(@1);
        }];
        
        UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        startButton.tag = 1;
        [startButton setImage:[UIImage imageNamed:@"plan-add-date"] forState:UIControlStateNormal];
        [startButton addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:startButton];
        [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@54);
            make.width.equalTo(@44);
            make.top.right.equalTo(@0);
        }];
        
        _startLabel = [[UILabel alloc] init];
        _startLabel.font = self.keyLabel.font;
        _startLabel.textColor = self.keyLabel.textColor;
        _startLabel.textAlignment = NSTextAlignmentRight;
        _startLabel.text = @"开始时间";
        [self.contentView addSubview:_startLabel];
        [_startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(startButton);
            make.left.equalTo(self.keyLabel.mas_right).offset(-30);
            make.right.equalTo(startButton.mas_left);
        }];
        
        UIButton *endButton = [UIButton buttonWithType:UIButtonTypeCustom];
        endButton.tag = 2;
        [endButton setImage:[UIImage imageNamed:@"plan-add-date"] forState:UIControlStateNormal];
        [endButton addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:endButton];
        [endButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(startButton);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
            make.top.equalTo(startButton.mas_bottom);
        }];
        
        _endLabel = [[UILabel alloc] init];
        _endLabel.font = self.keyLabel.font;
        _endLabel.textColor = self.keyLabel.textColor;
        _endLabel.textAlignment = NSTextAlignmentRight;
        _endLabel.text = @"结束时间";
        [self.contentView addSubview:_endLabel];
        [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(endButton);
            make.left.right.equalTo(_startLabel);
        }];
    }
    return self;
}

- (void)showPicker:(UIButton *)button {
    if (self.showPickerBlock) {
        self.showPickerBlock(button.tag);
    }
}

@end
