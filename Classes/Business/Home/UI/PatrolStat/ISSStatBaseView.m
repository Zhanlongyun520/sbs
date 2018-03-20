//
//  ISSStatBaseView.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSStatBaseView.h"
#import "ISSLoginUserModel.h"
#import "ISSTaskDepartmentModel.h"

@implementation ISSStatBaseView

- (instancetype)init {
    if (self = [super init]) {
        UIImageView *tIcon = [[UIImageView alloc] init];
        tIcon.backgroundColor = kPatrolStatBlueColor;
        tIcon.layer.cornerRadius = 3;
        tIcon.layer.masksToBounds = YES;
        [self addSubview:tIcon];
        [tIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(@14);
            make.height.equalTo(@12);
            make.width.equalTo(@6);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor grayColor];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tIcon.mas_right).offset(8);
            make.top.equalTo(@0);
            make.height.equalTo(@40);
            make.right.equalTo(@0);
        }];
        
        UIView *cView = [[UIView alloc] init];
        cView.backgroundColor = [UIColor whiteColor];
        [self addSubview:cView];
        [cView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tIcon);
            make.right.equalTo(@-15);
            make.top.equalTo(_titleLabel.mas_bottom);
            make.bottom.equalTo(@0);
            make.height.equalTo(@310);
        }];
        
        _dateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _dateButton.tintColor = [UIColor darkTextColor];
        _dateButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_dateButton addTarget:self action:@selector(showDatePicker) forControlEvents:UIControlEventTouchUpInside];
        [cView addSubview:_dateButton];
        [_dateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@0);
            make.height.equalTo(@35);
            make.width.equalTo(@110);
        }];

        _depButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _depButton.tintColor = [UIColor darkTextColor];
        _depButton.titleLabel.font = _dateButton.titleLabel.font;
        [_depButton setTitle:@"选择单位 ▼" forState:UIControlStateNormal];
        [_depButton addTarget:self action:@selector(showDepartmentPicker) forControlEvents:UIControlEventTouchUpInside];
        [cView addSubview:_depButton];
        [_depButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.top.height.width.equalTo(_dateButton);
        }];
        [self setAttributedTextButton:_depButton];

        UIImageView *line = [[UIImageView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
        [cView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@1);
            make.top.equalTo(_depButton.mas_bottom);
        }];

        for (NSInteger i = 0; i < 2; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:11];
            label.textAlignment = NSTextAlignmentCenter;
            [cView addSubview:label];

            UIImageView *icon = [[UIImageView alloc] init];
            icon.layer.cornerRadius = 4;
            icon.layer.masksToBounds = YES;
            [cView addSubview:icon];

            switch (i) {
                case 0:
                    _data2Label = label;
                    _data2ImageView = icon;
                    break;

                case 1:
                    _data1Label = label;
                    _data1ImageView = icon;
                    break;

                default:
                    break;
            }
        }
        
        [_data2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@12);
            make.top.equalTo(line.mas_bottom).offset(13);
            make.right.equalTo(@-15);
        }];
        
        _data2ImageView.layer.cornerRadius = 4;
        _data2ImageView.layer.masksToBounds = YES;
        [_data2ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@8);
            make.height.equalTo(@8);
            make.centerY.equalTo(_data2Label);
            make.right.equalTo(_data2Label.mas_left).offset(-5);
        }];
        
        [_data1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(_data2Label);
            make.right.equalTo(_data2ImageView.mas_left).offset(-15);
        }];
        
        _data1ImageView.layer.cornerRadius = _data2ImageView.layer.cornerRadius;
        _data1ImageView.layer.masksToBounds = YES;
        [_data1ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.centerY.equalTo(_data2ImageView);
            make.right.equalTo(_data1Label.mas_left).offset(-5);
        }];
        
        _contentView = [[UIView alloc] init];
        _contentView.frame = CGRectMake(0, 35 + 40, kScreenWidth - 15 * 2, 310 - 35 - 40);
        [cView addSubview:_contentView];
        
        _date = [NSDate date];
        _departmentId = [ISSLoginUserModel shareInstance].loginUser.departmentId;
        
        _emptyLabel = [[UILabel alloc] init];
        _emptyLabel.textColor = [UIColor darkGrayColor];
        _emptyLabel.textAlignment = NSTextAlignmentCenter;
        _emptyLabel.font = [UIFont systemFontOfSize:12];
        _emptyLabel.text = @"暂无数据";
        [_contentView addSubview:_emptyLabel];
        [_emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_contentView);
        }];
    }
    return self;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月";
    NSString *dString = [formatter stringFromDate:date];
    NSString *title = [NSString stringWithFormat:@"%@ ▼", dString];
    [_dateButton setTitle:title forState:UIControlStateNormal];
    
    [self setAttributedTextButton:_dateButton];
}

- (void)setDepartmentId:(NSString *)departmentId {
    _departmentId = departmentId;
    
    NSString *company = @"未知";
    for (ISSTaskDepartmentModel *model in [ISSTaskDepartmentModel shareInstance].dataList) {
        if ([model.value isEqualToString:departmentId]) {
            company = model.content;
            break;
        }
    }
    NSString *title = [NSString stringWithFormat:@"%@ ▼", company];
    [_depButton setTitle:title forState:UIControlStateNormal];
    
    [self setAttributedTextButton:_depButton];
}

- (void)setAttributedTextButton:(UIButton *)button {
    NSString *title = [button titleForState:UIControlStateNormal];
    NSDictionary *attribs = @{NSFontAttributeName:[UIFont systemFontOfSize:10.0f]};
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedText setAttributes:attribs range:NSMakeRange(title.length - 2, 2)];
    [button setAttributedTitle:attributedText forState:UIControlStateNormal];
}

- (void)showDatePicker {
    if (self.showDatePickerBlock) {
        self.showDatePickerBlock(_date, self.tag);
    }
}

- (void)showDepartmentPicker {
    if (self.showDepartmentPickerBlock) {
        self.showDepartmentPickerBlock(_departmentId, self.tag);
    }
}

@end
