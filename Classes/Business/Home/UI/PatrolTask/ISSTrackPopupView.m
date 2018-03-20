//
//  ISSTrackPopupView.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTrackPopupView.h"
#import "Masonry.h"
#import "NSString+Size.h"
#import "ISSTaskListModel.h"
#import "ISSTrackPopupCell.h"
#import "ISSTrackPopupTouchView.h"

@interface ISSTrackPopupView () <UITableViewDataSource, UITableViewDelegate>
{
    UILabel *_titleLabel;
    UILabel *_statusLabel;
    UILabel *_companyLabel;
    UIImageView *_companyIcon;
    
    UITableView *_tableView;
}
@end

@implementation ISSTrackPopupView

- (instancetype)init {
    if (self = [super init]) {
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowOpacity = 0.8;
        self.layer.shadowRadius = 3;
        
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.bottom.equalTo(@-25);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setBackgroundImage:[UIImage imageNamed:@"closeIcon"] forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentView);
            make.height.equalTo(@32);
            make.width.equalTo(@54);
            make.bottom.equalTo(contentView.mas_top).offset(1);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.5];
        [contentView addSubview:_titleLabel];
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
        [contentView addSubview:_statusLabel];
        
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.font = [UIFont systemFontOfSize:14];
        _companyLabel.textColor = [UIColor darkGrayColor];
        [contentView addSubview:_companyLabel];
        [_companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(_titleLabel);
            make.width.equalTo(@200);
            make.right.equalTo(@-15);
        }];
        
        _companyIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plan-pending-company"]];
        [contentView addSubview:_companyIcon];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
        _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = UITableViewAutomaticDimension;
        _tableView.estimatedSectionFooterHeight = 0;
        [_tableView registerClass:[ISSTrackPopupCell class] forCellReuseIdentifier:@"ISSTrackPopupCell"];
        [contentView addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.top.equalTo(_titleLabel.mas_bottom);
            make.height.equalTo(@110);
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.patrolTaskArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ISSTrackPopupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ISSTrackPopupCell" forIndexPath:indexPath];
    cell.model = [_model.patrolTaskArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self showDetail:[_model.patrolTaskArray objectAtIndex:indexPath.row]];
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
    
    _tableView.scrollEnabled = _model.patrolTaskArray.count > 2;
    [_tableView reloadData];
}

- (void)dissmiss {
    if (self.dissmissBlock) {
        self.dissmissBlock();
    }
}

- (void)showDetail:(ISSTaskListModel *)model {
    if (self.showDetailBlock) {
        self.showDetailBlock(model);
    }
}

@end
