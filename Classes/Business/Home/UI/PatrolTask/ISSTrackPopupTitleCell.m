//
//  ISSTrackPopupTitleCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTrackPopupTitleCell.h"
#import "NSString+Size.h"

@interface ISSTrackPopupTitleCell ()
{
    UILabel *_titleLabel;
    UILabel *_statusLabel;
    UILabel *_companyLabel;
    UIImageView *_companyIcon;
}
@end

@implementation ISSTrackPopupTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.5];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(@0);
            make.height.equalTo(@44);
            make.width.equalTo(@50);
        }];
        
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont systemFontOfSize:11];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.layer.cornerRadius = 5;
        _statusLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:_statusLabel];
        
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.font = [UIFont systemFontOfSize:14];
        _companyLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_companyLabel];
        [_companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(_titleLabel);
            make.width.equalTo(@200);
            make.right.equalTo(@-15);
        }];
        
        _companyIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plan-pending-company"]];
        [self.contentView addSubview:_companyIcon];
    }
    return self;
}

- (void)setModel:(ISSMonitorListModel *)model {
    _model = model;
    
    CGFloat nameWidth = [model.user.name getWidthOfFont:_titleLabel.font height:20];
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(nameWidth));
    }];
    _titleLabel.text = model.user.name;
    
    _statusLabel.text = model.patrolTask.taskStatusName;
    _statusLabel.backgroundColor = [model.patrolTask taskStatusColor];
    [_statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right).offset(5);
        make.centerY.equalTo(_titleLabel);
        make.height.equalTo(@18);
        make.width.equalTo(@40);
    }];
    
    NSString *company = model.user.companyName;
    CGFloat companyWidth = [company getWidthOfFont:_companyLabel.font height:20];
    [_companyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(companyWidth));
    }];
    _companyLabel.text = company;
    
    [_companyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_companyLabel.mas_left).offset(-5);
        make.centerY.equalTo(_companyLabel);
        make.width.equalTo(@10);
        make.height.equalTo(@12);
    }];
}

@end
