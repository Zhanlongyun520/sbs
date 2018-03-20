//
//  ISSMapPMPopupView.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/28.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMapPMPopupView.h"
#import "Masonry.h"
#import "NSString+Size.h"
#import "ISSTrackPopupTouchView.h"

@interface ISSMapPMPopupView ()
{
    UIButton *_realTimeButton;
    UILabel *_titleLabel;
    UILabel *_statusLabel;
    UILabel *_dateLabel;
    UILabel *_device;
    UILabel *_pm10Label;
    UILabel *_pm25Label;
    UILabel *_so2Label;
}
@end

@implementation ISSMapPMPopupView

- (instancetype)init:(BOOL)hasTabBar {
    if (self = [super init]) {
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowOpacity = 0.8;
        self.layer.shadowRadius = 3;
        
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.bottom.equalTo(@(-10 - 40 - (hasTabBar ? 49 : 0)));
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
        
        UILabel *tLabel = [[UILabel alloc] init];
        tLabel.font = [UIFont systemFontOfSize:11];
        tLabel.textColor = [UIColor grayColor];
        tLabel.text = @"设备编号:";
        [contentView addSubview:tLabel];
        [tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.top.equalTo(@0);
            make.height.equalTo(@40);
            make.width.equalTo(@52);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.5];
        [contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tLabel.mas_right);
            make.top.bottom.equalTo(tLabel);
            make.width.equalTo(@50);
        }];
        
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont systemFontOfSize:11];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.layer.cornerRadius = 5;
        _statusLabel.layer.masksToBounds = YES;
        [contentView addSubview:_statusLabel];
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = tLabel.font;
        _dateLabel.textColor = tLabel.textColor;
        _dateLabel.textAlignment = NSTextAlignmentRight;
        [contentView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.top.bottom.equalTo(tLabel);
        }];
        
        UIView *cView = [[UIView alloc] init];
        cView.backgroundColor = [UIColor whiteColor];
        [contentView addSubview:cView];
        [cView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.top.equalTo(_titleLabel.mas_bottom);
        }];
        
        _device = [[UILabel alloc] init];
        _device.font = [UIFont systemFontOfSize:14];
        _device.textColor = [UIColor darkGrayColor];
        [contentView addSubview:_device];
        [_device mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom);
            make.right.equalTo(@0);
            make.left.equalTo(@40);
            make.height.equalTo(@40);
        }];
        
        UIImageView *addressIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"site"]];
        [cView addSubview:addressIcon];
        [addressIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_device);
            make.width.equalTo(@10);
            make.height.equalTo(@12);
            make.left.equalTo(@15);
        }];
        
        _pm10Label = [[UILabel alloc] init];
        _pm10Label.font = [UIFont systemFontOfSize:12];
        _pm10Label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:_pm10Label];
        [_pm10Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_device.mas_bottom);
            make.left.equalTo(@0);
            make.height.equalTo(@40);
        }];
        
        _pm25Label = [[UILabel alloc] init];
        _pm25Label.font = _pm10Label.font;
        _pm25Label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:_pm25Label];
        [_pm25Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.with.equalTo(_pm10Label);
            make.left.equalTo(_pm10Label.mas_right);
        }];
        
        _so2Label = [[UILabel alloc] init];
        _so2Label.font = _pm10Label.font;
        _so2Label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:_so2Label];
        [_so2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.with.equalTo(_pm25Label);
            make.left.equalTo(_pm25Label.mas_right);
            make.right.equalTo(@0);
        }];
        
        [_pm10Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(_so2Label);
        }];
        
        UIImageView *line = [[UIImageView alloc]initForAutoLayout];
        line.backgroundColor = ISSColorSeparatorLine;
        [cView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.top.equalTo(_pm10Label.mas_bottom);
            make.height.equalTo(@1);
        }];
        
        UIButton *realTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _realTimeButton = realTimeButton;
        realTimeButton.translatesAutoresizingMaskIntoConstraints = NO;
        realTimeButton.titleLabel.font = ISSFont12;
        realTimeButton.tag = 1;
        [realTimeButton addTarget:self action:@selector(toolsClick:) forControlEvents:UIControlEventTouchUpInside];
        [realTimeButton setTitle:@"实时监控" forState:UIControlStateNormal];
        [realTimeButton setTitleColor:ISSColorNavigationBar forState:UIControlStateNormal];
        [realTimeButton setImage:[UIImage imageNamed:@"time"]  forState:UIControlStateNormal];
        [realTimeButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [cView addSubview:realTimeButton];
        [realTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(@0);
            make.top.equalTo(line.mas_bottom);
            make.height.equalTo(@40);
        }];
        
        UIButton *historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        historyButton.translatesAutoresizingMaskIntoConstraints = NO;
        historyButton.titleLabel.font = ISSFont12;
        historyButton.tag = 2;
        [historyButton addTarget:self action:@selector(toolsClick:) forControlEvents:UIControlEventTouchUpInside];
        [historyButton setTitle:@"历史监控" forState:UIControlStateNormal];
        [historyButton setTitleColor:ISSColorNavigationBar forState:UIControlStateNormal];
        [historyButton setImage:[UIImage imageNamed:@"history"]  forState:UIControlStateNormal];
        [historyButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [cView addSubview:historyButton];
        [historyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(realTimeButton);
            make.left.equalTo(realTimeButton.mas_right);
            make.right.equalTo(@0);
        }];
        
        [realTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(historyButton);
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

- (void)setModel:(ISSVideoModel *)model {
    _model = model;
    
    UIImage *img = [[UIImage imageNamed:@"time"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_realTimeButton setImage:img forState:UIControlStateNormal];
    if ([model.deviceStatus integerValue] == 0) {
        _realTimeButton.enabled = YES;
        _realTimeButton.imageView.tintColor = [UIColor colorWithRed:0.24 green:0.39 blue:0.87 alpha:1.00];
    } else {
        _realTimeButton.enabled = NO;
        _realTimeButton.imageView.tintColor = [UIColor lightGrayColor];
    }
    [_realTimeButton setTitleColor:_realTimeButton.imageView.tintColor forState:UIControlStateNormal];
    
    _titleLabel.text = model.deviceCoding;
    CGFloat nameWidth = [_titleLabel.text getWidthOfFont:_titleLabel.font height:20];
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(nameWidth));
    }];
    
    _statusLabel.text = [model getStatusDes];
    _statusLabel.backgroundColor = [model getStatusColor];
    [_statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right).offset(5);
        make.centerY.equalTo(_titleLabel);
        make.height.equalTo(@18);
        make.width.equalTo(@30);
    }];
    
    NSString *device = model.deviceName;
    CGFloat deviceWidth = [device getWidthOfFont:_device.font height:20];
    [_device mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(deviceWidth));
    }];
    _device.text = device;
    
    _dateLabel.text = [model.installTime containsString:@" "] ? [[model.installTime componentsSeparatedByString:@" "] firstObject] : @"";
    
    NSString *pm10 = _model.eqiModel.pm10.length > 0 ? _model.eqiModel.pm10 : @"0";
    NSString *pm10Text = [NSString stringWithFormat:@"PM10：%@", pm10];
    NSMutableAttributedString *pm10AttributedString = [[NSMutableAttributedString alloc] initWithString:pm10Text];
    NSRange pm10Range = NSMakeRange(pm10Text.length - pm10.length, pm10.length);
    [pm10AttributedString setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.33 green:0.78 blue:0.54 alpha:1.00]} range:pm10Range];
    _pm10Label.attributedText = pm10AttributedString;

    NSString *pm25 = _model.eqiModel.pm25.length > 0 ? _model.eqiModel.pm25 : @"0";
    NSString *pm25Text = [NSString stringWithFormat:@"PM2.5：%@", pm25];
    NSMutableAttributedString *pm25AttributedString = [[NSMutableAttributedString alloc] initWithString:pm25Text];
    NSRange pm25Range = NSMakeRange(pm25Text.length - pm25.length, pm25.length);
    [pm25AttributedString setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.24 green:0.45 blue:0.94 alpha:1.00]} range:pm25Range];
    _pm25Label.attributedText = pm25AttributedString;
    
    NSString *co2 = _model.eqiModel.co2.length > 0 ? _model.eqiModel.co2 : @"0";
    NSString *co2Text = [NSString stringWithFormat:@"CO2：%@", co2];
    NSMutableAttributedString *co2AttributedString = [[NSMutableAttributedString alloc] initWithString:co2Text];
    NSRange co2Range = NSMakeRange(co2Text.length - co2.length, co2.length);
    [co2AttributedString setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.24 green:0.45 blue:0.94 alpha:1.00]} range:co2Range];
    _so2Label.attributedText = co2AttributedString;
}

- (void)toolsClick:(UIButton *)button {
    [self showDetail:button.tag];
}

- (void)dissmiss {
    if (self.dissmissBlock) {
        self.dissmissBlock();
    }
}

- (void)showDetail:(NSInteger)tag {
    if (self.showDetailBlock) {
        self.showDetailBlock(_model.eqiModel, tag);
    }
}

@end
