//
//  ISSPlainPendingListCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainPendingListCell.h"
#import "NSString+Size.h"

@interface ISSPlainPendingListCell () {

}
@end

@implementation ISSPlainPendingListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
        
        UIView *bgView = [[UIView alloc] init];
        bgView.layer.cornerRadius = 3;
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(@10);
            make.right.equalTo(@-15);
            make.bottom.equalTo(@0);
        }];
        
        UIView *tView = [[UIView alloc] init];
        tView.layer.cornerRadius = 3;
        tView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
        [bgView addSubview:tView];
        [tView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(@0);
            make.height.equalTo(@44);
        }];
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor lightGrayColor];
        _dateLabel.font = [UIFont systemFontOfSize:13];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        [tView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.right.equalTo(@-15);
            make.width.equalTo(@130);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.5];
        [tView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.bottom.equalTo(@0);
            make.right.equalTo(@0);
        }];
        
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont systemFontOfSize:11];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.layer.cornerRadius = 5;
        _statusLabel.layer.masksToBounds = YES;
        [tView addSubview:_statusLabel];
        
        UIImageView *nameIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plan-pending-user"]];
        [bgView addSubview:nameIcon];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor darkGrayColor];
        [bgView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tView.mas_bottom);
            make.height.equalTo(@44);
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
        [bgView addSubview:companyIcon];
        [companyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel.mas_right);
            make.centerY.equalTo(_nameLabel);
            make.width.equalTo(@10);
            make.height.equalTo(@12);
        }];
        
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.font = [UIFont systemFontOfSize:14];
        _companyLabel.textColor = [UIColor darkGrayColor];
        [bgView addSubview:_companyLabel];
        [_companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(_nameLabel);
            make.left.equalTo(companyIcon.mas_right).offset(10);
            make.right.equalTo(@-10);
        }];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
        [bgView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.right.equalTo(@-20);
            make.top.equalTo(_nameLabel.mas_bottom);
            make.height.equalTo(@1);
        }];
        _line = line;
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setImage:[UIImage imageNamed:@"plan-pending-button"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(showDetail) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom);
            make.height.equalTo(@44);
            make.left.right.bottom.equalTo(@0);
        }];
    }
    return self;
}

- (void)setModel:(ISSPlainListModel *)model {
    _model = model;
    
    _titleLabel.text = model.title;
    _dateLabel.text = [[model.date componentsSeparatedByString:@" "] firstObject];
    _nameLabel.text = model.creator.name;
    _companyLabel.text = model.creator.companyName ? : @"";
    
    CGFloat titleWidth = [model.title getWidthOfFont:_titleLabel.font height:20];
    
    _statusLabel.text = model.statusDescription;
    _statusLabel.backgroundColor = [model getStatusColor];
    [_statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left).offset(titleWidth + 3);
        make.centerY.equalTo(_titleLabel);
        make.height.equalTo(@18);
        make.width.equalTo(@40);
    }];
}

- (void)showDetail {
    if (self.detailBlock) {
        self.detailBlock(_model);
    }
}

@end
