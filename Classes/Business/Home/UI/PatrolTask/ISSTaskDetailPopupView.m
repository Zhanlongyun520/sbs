//
//  ISSTaskDetailPopupView.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/11.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTaskDetailPopupView.h"
#import "Masonry.h"
#import "ISSTrackPopupTouchView.h"
#import "NSString+Size.h"

@interface ISSTaskDetailPopupView ()
{
    UILabel *_titleLabel;
    UILabel *_statusLabel;
    UILabel *_dateLabel;
    UILabel *_nameLabel;
    UILabel *_companyLabel;
    
    UIView *_userView;
    
    UIView *_buttonView;
}
@end

@implementation ISSTaskDetailPopupView

- (instancetype)init {
    if (self = [super init]) {
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowOpacity = 0.8;
        self.layer.shadowRadius = 3;
        
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.bottom.equalTo(@-25);
        }];
        
        UIButton *cButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [cButton setBackgroundImage:[UIImage imageNamed:@"closeIcon"] forState:UIControlStateNormal];
        cButton.userInteractionEnabled = NO;
        [self addSubview:cButton];
        [cButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentView);
            make.height.equalTo(@32);
            make.width.equalTo(@54);
            make.bottom.equalTo(contentView.mas_top).offset(1);
        }];
        
        UIView *tView = [[UIView alloc] init];
        tView.layer.cornerRadius = 3;
        tView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
        [contentView addSubview:tView];
        [tView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(@0);
            make.height.equalTo(@44);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.5];
        [tView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.bottom.equalTo(@0);
            make.width.equalTo(@50);
        }];
        
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont systemFontOfSize:11];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.layer.cornerRadius = 5;
        _statusLabel.layer.masksToBounds = YES;
        [tView addSubview:_statusLabel];
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textColor = [UIColor grayColor];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        [tView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_titleLabel);
            make.right.equalTo(@-15);
            make.width.equalTo(@100);
        }];
        
        _userView = [[UIView alloc] init];
        [contentView addSubview:_userView];
        [_userView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(@60);
            make.top.equalTo(tView.mas_bottom);
        }];
        
        UIImageView *nameIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plan-pending-user"]];
        [_userView addSubview:nameIcon];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor darkGrayColor];
        [_userView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            make.left.equalTo(nameIcon.mas_right).offset(10);
            make.width.equalTo(@60);
        }];
        
        [nameIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.centerY.equalTo(_nameLabel);
            make.width.equalTo(@11);
            make.height.equalTo(@13);
        }];
        
        UIImageView *companyIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plan-pending-company"]];
        [_userView addSubview:companyIcon];
        [companyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel.mas_right);
            make.centerY.equalTo(_nameLabel);
            make.width.equalTo(@10);
            make.height.equalTo(@12);
        }];
        
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.font = [UIFont systemFontOfSize:14];
        _companyLabel.textColor = [UIColor darkGrayColor];
        [_userView addSubview:_companyLabel];
        [_companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(_nameLabel);
            make.left.equalTo(companyIcon.mas_right).offset(10);
            make.right.equalTo(@-10);
        }];
        
        _buttonView = [[UIView alloc] init];
        _buttonView.backgroundColor = [UIColor whiteColor];
        [contentView addSubview:_buttonView];
        [_buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_userView);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"task-list-status-3"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
        [_buttonView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_buttonView);
        }];
        
        __weak typeof(self) weakSelf = self;
        ISSTrackPopupTouchView *touchView = [[ISSTrackPopupTouchView alloc] init];
        touchView.touchBlock = ^{
            [weakSelf dissmiss];
        };
        [self addSubview:touchView];
        [touchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@0);
            make.bottom.equalTo(contentView.mas_top);
        }];
    }
    return self;
}

- (void)setModel:(ISSTaskPositionModel *)model {
    _model = model;
    
    _titleLabel.text = model.position;
    CGFloat nameWidth = [_titleLabel.text getWidthOfFont:_titleLabel.font height:20];
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(nameWidth));
    }];
    
    _statusLabel.text = [model getStatusName];
    _statusLabel.backgroundColor = [model getStatusColor];
    [_statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right).offset(5);
        make.centerY.equalTo(_titleLabel);
        make.height.equalTo(@18);
        make.width.equalTo(@40);
    }];
    
    _dateLabel.text = model.executionTime;
    
    if (model.status == ISSTaskPositionStatusNew) {
        _buttonView.hidden = _readonly;
        _userView.hidden = YES;
    } else if (model.status == ISSTaskPositionStatusFinished) {
        _buttonView.hidden = YES;
        _userView.hidden = NO;
        
        _nameLabel.text = model.user.name;
        
        NSString *company = model.user.companyName ? : @"未知";
        CGFloat companyWidth = [company getWidthOfFont:_companyLabel.font height:20];
        [_companyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(companyWidth));
        }];
        _companyLabel.text = company;
    }
}

- (void)dissmiss {
    if (self.dissmissBlock) {
        self.dissmissBlock();
    }
}

- (void)finish {
    if (self.finishBlock) {
        self.finishBlock(_model);
    }
}

@end
