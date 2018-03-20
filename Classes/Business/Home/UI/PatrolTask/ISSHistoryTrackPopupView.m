//
//  ISSHistoryTrackPopupView.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSHistoryTrackPopupView.h"
#import "Masonry.h"
#import "ISSTrackPopupTouchView.h"

@interface ISSHistoryTrackPopupView ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *addrLabel;

@end

@implementation ISSHistoryTrackPopupView

- (instancetype)init {
    if (self = [super init]) {
        
        UIImageView *contentView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map-bg"]];
        contentView.userInteractionEnabled = YES;
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.bottom.right.equalTo(@-10);
            make.height.equalTo(@145);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentView);
            make.height.equalTo(@36);
            make.width.equalTo(@54);
            make.top.equalTo(contentView);
        }];

        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"设备编号：";
        titleLabel.textColor = [UIColor darkGrayColor];
        titleLabel.font = [UIFont systemFontOfSize:13.0];
        [contentView addSubview:titleLabel];

        _nameLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor darkTextColor];
            label.font = [UIFont systemFontOfSize:14.0];
            [contentView addSubview:label]; label;
        });
        
        _dateLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor darkGrayColor];
            label.textAlignment = NSTextAlignmentRight;
            label.font = [UIFont systemFontOfSize:13.0];
            [contentView addSubview:label]; label;
        });
        
        UIImageView *addrImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"track_loaction_gray"]];
        [contentView addSubview:addrImv];

        _addrLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor darkTextColor];
            label.font = [UIFont systemFontOfSize:14.0];
            [contentView addSubview:label]; label;
        });
  
        
        UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [detailBtn addTarget:self action:@selector(showDetail) forControlEvents:UIControlEventTouchUpInside];
        [detailBtn setTitleColor:ISSColorWhite forState:UIControlStateNormal];
        [detailBtn.titleLabel setFont:ISSFont14];
        [detailBtn setTitle:@"查看图片" forState:UIControlStateNormal];
        [detailBtn setBackgroundImage:[ISSUtilityMethod createImageWithColor:ISSColorNavigationBar] forState:UIControlStateNormal];
        detailBtn.layer.masksToBounds = YES;
        detailBtn.layer.cornerRadius = 4;
        [contentView addSubview:detailBtn];
        
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@12);
            make.top.equalTo(button.mas_bottom);
            make.height.equalTo(@44);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right);
            make.top.equalTo(titleLabel);
            make.height.equalTo(titleLabel);
        }];
        
        [addrImv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel).offset(5);
            make.centerY.equalTo(self.addrLabel);
            make.height.equalTo(@13);
            make.width.equalTo(@10);
        }];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.top.equalTo(titleLabel);
            make.height.equalTo(@44);
        }];
        
        [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.addrLabel);
            make.height.equalTo(@30);
            make.width.equalTo(@80);
            make.right.equalTo(@(-18));
        }];
        
        [self.addrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(addrImv.mas_right).offset(5);
            make.right.equalTo(detailBtn.mas_left).offset(-5);
            make.bottom.equalTo(@(-26));
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

- (void)setModel:(ISSCarTrackModel *)model {
    _model = model;
    
    self.nameLabel.text = model.deviceName;
    NSString *dateTime = model.dateTime.length > 10 ? [model.dateTime substringToIndex:10] : model.dateTime;
    self.dateLabel.text = [NSString stringWithFormat:@"拍摄时间: %@",dateTime];
    self.addrLabel.text = (model.addr.length > 0) ? model.addr :@"未知地点";
}

- (void)dissmiss {
    if (self.dissmissBlock) {
        self.dissmissBlock();
    }
}

- (void)showDetail {
    if (self.showDetailBlock) {
        self.showDetailBlock(self.model);
    }
}

@end
