//
//  ISSPlainTaskListCell.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainTaskListCell.h"
#import "NSString+Size.h"
#import "ISSLoginUserModel.h"

@interface ISSPlainTaskListCell ()
{
    UIButton *_copyButton;
}
@end

@implementation ISSPlainTaskListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [_button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_line.mas_bottom);
            make.height.equalTo(@44);
            make.left.bottom.equalTo(@0);
            make.width.equalTo(@0);
        }];
        
        _copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_copyButton setImage:[UIImage imageNamed:@"task-copy"] forState:UIControlStateNormal];
        [_copyButton addTarget:self action:@selector(showCopy) forControlEvents:UIControlEventTouchUpInside];
        [_button.superview addSubview:_copyButton];
        [_copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_button);
            make.right.equalTo(@0);
            make.left.equalTo(_button.mas_right);
        }];
    }
    return self;
}

- (void)setTaskModel:(ISSTaskListModel *)taskModel {
    _taskModel = taskModel;
    
    _titleLabel.text = taskModel.taskName;
    _dateLabel.text = taskModel.taskTimeStart;
    _nameLabel.text = taskModel.creator.name;
    _companyLabel.text = taskModel.creator.companyName ? : @"";
    
    CGFloat titleWidth = [taskModel.taskName getWidthOfFont:_titleLabel.font height:20];
    
    _statusLabel.text = taskModel.taskStatusName;
    _statusLabel.backgroundColor = [taskModel taskStatusColor];
    [_statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left).offset(titleWidth + 3);
        make.centerY.equalTo(_titleLabel);
        make.height.equalTo(@18);
        make.width.equalTo(@40);
    }];
    
    [_button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"task-list-status-%@", @(taskModel.taskStatus)]] forState:UIControlStateNormal];
    
    [_button mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat fullWidth = kScreenWidth - 15.0 * 2;
        if ([taskModel.creator.id isEqualToString:[ISSLoginUserModel shareInstance].loginUser.id]) {
            make.width.equalTo(@(fullWidth / 2.0));
        } else {
            make.width.equalTo(@(fullWidth));
        }
        make.width.equalTo(@(fullWidth));
    }];
}

- (void)showDetail {
    if (self.taskDetailBlock) {
        self.taskDetailBlock(_taskModel);
    }
}

- (void)showCopy {
    if (self.taskCopyBlock) {
        self.taskCopyBlock(_taskModel);
    }
}

@end
