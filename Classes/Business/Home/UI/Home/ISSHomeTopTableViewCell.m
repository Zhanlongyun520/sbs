//
//  ISSHomeTopTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/13.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSHomeTopTableViewCell.h"
#import "ISSLoginUserModel.h"

@interface ISSHomeTopTableViewCell()
{
    UIImageView     * topBG;
    UIImageView     * locationIV;
    UILabel         * locationLabel;
    UILabel         * titleLabel;
    
    UILabel         * temperatureLabel;
    UIView          * line;
    UIImageView     * windIV;
    UILabel         * windLabel;
    UIImageView     * dampIV;
    UILabel         * dampLabel;

    UIView          * AQIBGIV;
    UIView          * AQIColorIV;
    UILabel         * AQITitleLabel;
    UILabel         * AQILabel;
    UIImageView     * AQIIV;

}


@end
@implementation ISSHomeTopTableViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //顶部
        
        topBG = [[UIImageView alloc]initForAutoLayout];
        topBG.image = [UIImage imageNamed:@"home-bg"];
        [self addSubview:topBG];
        [self addConstraints:[topBG constraintsSize:CGSizeMake(kScreenWidth, 250)]];
        
        locationIV = [[UIImageView alloc]initForAutoLayout];
        locationIV.image = [UIImage imageNamed:@"home-address"];
        [self addSubview:locationIV];
        [self addConstraints:[locationIV constraintsTopInContainer:32]];
        [self addConstraints:[locationIV constraintsLeftInContainer:12]];
        
        locationLabel = [[UILabel alloc]initForAutoLayout];
        locationLabel.font = ISSFont12;
        locationLabel.textColor = ISSColorWhite;
        locationLabel.text = @"武汉市";
        [self addSubview:locationLabel];
        [self addConstraints:[locationLabel constraintsTopInContainer:32]];
        [self addConstraints:[locationLabel constraintsLeft:2 FromView:locationIV]];
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = ISSFont17;
        titleLabel.textColor = ISSColorWhite;
        titleLabel.text = @"光谷中心城绿色智慧工地";
        [self addSubview:titleLabel];
        [self addConstraints:[titleLabel constraintsTopInContainer:29]];
        [self addConstraint:[titleLabel constraintCenterXInContainer]];
        
        //中部
        
        temperatureLabel = [[UILabel alloc]initForAutoLayout];
        temperatureLabel.font = [UIFont fontWithName:@"PingFangHK-Thin" size:60];
        temperatureLabel.textColor = ISSColorWhite;
        temperatureLabel.text = @"26°";
        [self addSubview:temperatureLabel];
        [self addConstraints:[temperatureLabel constraintsLeftInContainer:32]];
        [self addConstraints:[temperatureLabel constraintsTop:30 FromView:titleLabel]];
        
        line = [[UIView alloc]initForAutoLayout];
        line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
        [self addSubview:line];
        [self addConstraints:[line constraintsSize:CGSizeMake(0.5, 40)]];
        [self addConstraints:[line constraintsTop:52 FromView:titleLabel]];
        [self addConstraints:[line constraintsLeft:8 FromView:temperatureLabel]];
        
        windIV = [[UIImageView alloc]initForAutoLayout];
        windIV.image = [UIImage imageNamed:@"home-wind"];
        [self addSubview:windIV];
        [self addConstraint:[windIV constraintTopEqualToView:line]];
        [self addConstraints:[windIV constraintsLeft:12 FromView:line]];
        
        windLabel = [[UILabel alloc]initForAutoLayout];
        windLabel.font = ISSFont12;
        windLabel.textColor = ISSColorWhite;
        windLabel.text = @"西南风2级";
        [self addSubview:windLabel];
        [self addConstraint:[windLabel constraintTopEqualToView:windIV]];
        [self addConstraints:[windLabel constraintsLeft:10 FromView:windIV]];
        
        
        dampIV = [[UIImageView alloc]initForAutoLayout];
        dampIV.image = [UIImage imageNamed:@"home-damp"];
        [self addSubview:dampIV];
        [self addConstraint:[dampIV constraintBottomEqualToView:line]];
        [self addConstraints:[dampIV constraintsLeft:12 FromView:line]];

        dampLabel = [[UILabel alloc]initForAutoLayout];
        dampLabel.font = ISSFont12;
        dampLabel.textColor = ISSColorWhite;
        dampLabel.text = @"51%";
        [self addSubview:dampLabel];
        [self addConstraint:[dampLabel constraintBottomEqualToView:line]];
        [self addConstraints:[dampLabel constraintsLeft:10 FromView:dampIV]];
        
        AQIBGIV = [[UIView alloc]initForAutoLayout];
        AQIBGIV.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        AQIBGIV.layer.masksToBounds = YES;
        AQIBGIV.layer.cornerRadius = 8;
        [AQIBGIV sizeToFit];
        [self addSubview:AQIBGIV];
        [self addConstraints:[AQIBGIV constraintsSize:CGSizeMake(64, 64)]];
        [self addConstraints:[AQIBGIV constraintsTop:38 FromView:titleLabel]];
        [self addConstraints:[AQIBGIV constraintsRightInContainer:22]];
        
        AQIColorIV = [[UIImageView alloc]initForAutoLayout];
//        AQIColorIV.backgroundColor = [UIColor orangeColor];
        AQIColorIV.layer.masksToBounds = YES;
        AQIColorIV.layer.cornerRadius = 2.5;
        [AQIColorIV sizeToFit];
        [AQIBGIV addSubview:AQIColorIV];
        [AQIBGIV addConstraints:[AQIColorIV constraintsSize:CGSizeMake(48, 4)]];
        [AQIBGIV addConstraints:[AQIColorIV constraintsTopInContainer:8]];
        [AQIBGIV addConstraint:[AQIColorIV constraintCenterXInContainer]];

        AQILabel = [[UILabel alloc]initForAutoLayout];
        AQILabel.font = ISSFont14;
        AQILabel.textColor = ISSColorWhite;
        AQILabel.text = @"168";
        [AQIBGIV addSubview:AQILabel];
        [AQIBGIV addConstraints:[AQILabel constraintsBottomInContainer:8]];
        [AQIBGIV addConstraints:[AQILabel constraintsLeftInContainer:8]];
        
        AQIIV = [[UIImageView alloc]initForAutoLayout];
        AQIIV.image = [UIImage imageNamed:@"home-AQI"];
        [AQIBGIV addSubview:AQIIV];
        [AQIBGIV addConstraints:[AQIIV constraintsBottomInContainer:8]];
        [AQIBGIV addConstraints:[AQIIV constraintsRightInContainer:8]];
        
        AQITitleLabel = [[UILabel alloc]initForAutoLayout];
        AQITitleLabel.font = ISSFont12;
        AQITitleLabel.textColor = ISSColorWhite;
        [AQIBGIV addSubview:AQITitleLabel];
        [AQIBGIV addConstraint:[AQITitleLabel constraintCenterXInContainer]];
        [AQIBGIV addConstraints:[AQITitleLabel constraintsBottom:8 FromView:AQIIV]];
        
        //下按钮

        _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_messageButton setImage:[UIImage imageNamed:@"top-message"] forState:UIControlStateNormal];
        [_messageButton setTitle:@"待处理任务" forState:UIControlStateNormal];
        _messageButton.titleLabel.font = ISSFont12;
        [_messageButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.8] forState:UIControlStateNormal];
        [_messageButton setTitleEdgeInsets:UIEdgeInsetsMake(50, -68, 0, 0)];
        [_messageButton setImageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        [self addSubview:_messageButton];
        [self addConstraints:[_messageButton constraintsLeftInContainer:kScreenWidth/8-24]];
        [self addConstraints:[_messageButton constraintsBottomInContainer:32]];
        
        if (![ISSLoginUserModel shareInstance].privilegeCode.M_PATROL) {
            _messageButton.userInteractionEnabled = NO;
            _messageButton.hidden = YES;
        }
        
        _messageBadge = [[UILabel alloc]initForAutoLayout];
        _messageBadge.textColor = [UIColor whiteColor];
        _messageBadge.font = ISSFont9;
        _messageBadge.text = @"11";
        _messageBadge.textAlignment = NSTextAlignmentCenter;
        _messageBadge.backgroundColor = [UIColor redColor];
        _messageBadge.layer.cornerRadius = 15/2;
        _messageBadge.layer.masksToBounds = YES;
        _messageBadge.hidden = YES;
        [self addSubview:_messageBadge];
        [self addConstraints:[_messageBadge constraintsSize:CGSizeMake(15, 15)]];
        [self addConstraints:[_messageBadge constraintsTop:-32 FromView:_messageButton]];
        [self addConstraints:[_messageBadge constraintsLeft:-59 FromView:_messageButton]];

        
        _pendingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _pendingButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_pendingButton setImage:[UIImage imageNamed:@"top-report"] forState:UIControlStateNormal];
        [_pendingButton setTitle:@"待处理报告" forState:UIControlStateNormal];
        _pendingButton.titleLabel.font = ISSFont12;
        [_pendingButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.8] forState:UIControlStateNormal];
        [_pendingButton setTitleEdgeInsets:UIEdgeInsetsMake(50, -68, 0, 0)];
        [_pendingButton setImageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        [self addSubview:_pendingButton];
        [self addConstraints:[_pendingButton constraintsLeftInContainer:(kScreenWidth/8)-24 +kScreenWidth/4]];
        [self addConstraints:[_pendingButton constraintsBottomInContainer:32]];
        
        if (![ISSLoginUserModel shareInstance].privilegeCode.M_PATROL) {
            _pendingButton.userInteractionEnabled = NO;
            _pendingButton.hidden = YES;
        }

        _pendingBadge = [[UILabel alloc]initForAutoLayout];
        _pendingBadge.textColor = [UIColor whiteColor];
        _pendingBadge.font = ISSFont9;
        _pendingBadge.text = @"7";
        _pendingBadge.textAlignment = NSTextAlignmentCenter;
        _pendingBadge.backgroundColor = [UIColor redColor];
        _pendingBadge.layer.cornerRadius = 15/2;
        _pendingBadge.layer.masksToBounds = YES;
        _pendingBadge.hidden = YES;
        [self addSubview:_pendingBadge];
        [self addConstraints:[_pendingBadge constraintsSize:CGSizeMake(15, 15)]];
        [self addConstraints:[_pendingBadge constraintsTop:-32 FromView:_pendingButton]];
        [self addConstraints:[_pendingBadge constraintsLeft:-59 FromView:_pendingButton]];
        
        _videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _videoButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_videoButton setImage:[UIImage imageNamed:@"top-video"] forState:UIControlStateNormal];
        [_videoButton setTitle:@"视频监控设备" forState:UIControlStateNormal];
        _videoButton.titleLabel.font = ISSFont12;
        [_videoButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.8] forState:UIControlStateNormal];
        [_videoButton setTitleEdgeInsets:UIEdgeInsetsMake(50, -80, 0, 0)];
        [_videoButton setImageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        [self addSubview:_videoButton];
        [self addConstraints:[_videoButton constraintsLeftInContainer:(kScreenWidth/8)-24 +kScreenWidth/2]];
        [self addConstraints:[_videoButton constraintsBottomInContainer:32]];
        
        if (![ISSLoginUserModel shareInstance].privilegeCode.VS) {
            _videoButton.userInteractionEnabled = NO;
            _videoButton.hidden = YES;
        }
        
        _videoBadge = [[UILabel alloc]initForAutoLayout];
        _videoBadge.textColor = [UIColor whiteColor];
        _videoBadge.font = ISSFont9;
        _videoBadge.text = @"7";
        _videoBadge.textAlignment = NSTextAlignmentCenter;
        _videoBadge.backgroundColor = [UIColor redColor];
        _videoBadge.layer.cornerRadius = 15/2;
        _videoBadge.layer.masksToBounds = YES;
        _videoBadge.hidden = YES;
        [self addSubview:_videoBadge];
        [self addConstraints:[_videoBadge constraintsSize:CGSizeMake(15, 15)]];
        [self addConstraints:[_videoBadge constraintsTop:-32 FromView:_videoButton]];
        [self addConstraints:[_videoBadge constraintsLeft:-70 FromView:_videoButton]];
        
        _environmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _environmentButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_environmentButton setImage:[UIImage imageNamed:@"top-environment"] forState:UIControlStateNormal];
        [_environmentButton setTitle:@"环境监控设备" forState:UIControlStateNormal];
        _environmentButton.titleLabel.font = ISSFont12;
        [_environmentButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.8] forState:UIControlStateNormal];
        [_environmentButton setTitleEdgeInsets:UIEdgeInsetsMake(50, -80, 0, 0)];
        [_environmentButton setImageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        [self addSubview:_environmentButton];
        [self addConstraints:[_environmentButton constraintsLeftInContainer:(kScreenWidth/8)-24 + (kScreenWidth/4)*3]];
        [self addConstraints:[_environmentButton constraintsBottomInContainer:32]];
        
        if (![ISSLoginUserModel shareInstance].privilegeCode.ENVIRMENT_VIEW) {
            _environmentButton.userInteractionEnabled = NO;
            _environmentButton.hidden = YES;
        }
        
        _environmentBadge = [[UILabel alloc]initForAutoLayout];
        _environmentBadge.textColor = [UIColor whiteColor];
        _environmentBadge.font = ISSFont9;
        _environmentBadge.text = @"7";
        _environmentBadge.textAlignment = NSTextAlignmentCenter;
        _environmentBadge.backgroundColor = [UIColor redColor];
        _environmentBadge.layer.cornerRadius = 15/2;
        _environmentBadge.layer.masksToBounds = YES;
        _environmentBadge.hidden = YES;
        [self addSubview:_environmentBadge];
        [self addConstraints:[_environmentBadge constraintsSize:CGSizeMake(15, 15)]];
        [self addConstraints:[_environmentBadge constraintsTop:-32 FromView:_environmentButton]];
        [self addConstraints:[_environmentBadge constraintsLeft:-70 FromView:_environmentButton]];
    }
    return self;
}

- (void)conFigDataHomeModel:(ISSHomeModel *)homeModel
{
    temperatureLabel.text = [NSString stringWithFormat:@"%@°", homeModel.airTemperature ? @([homeModel.airTemperature integerValue]) : @"0"];
    NSString * windStr;
    if (homeModel.windDirection != nil) {
        windStr = [NSString stringWithFormat:@"%@风",homeModel.windDirection];
    }
    if (homeModel.windSpeed != nil) {
        [windStr stringByAppendingString:[NSString stringWithFormat:@"%@级",homeModel.windSpeed]];
    }
    windLabel.text = windStr;
    AQILabel.text = [NSString stringWithFormat:@"%@",homeModel.AQI?:@"0"];
    dampLabel.text = [NSString stringWithFormat:@"%@%%",homeModel.airHumidity?@([homeModel.airHumidity integerValue]):@"0"];
    AQIColorIV.backgroundColor = [self AQIColor:[homeModel.AQI intValue]];
    [self badgeLabel:_messageBadge badgeCount:[homeModel.unHandleTask integerValue]];
    [self badgeLabel:_pendingBadge badgeCount:[homeModel.untreatedPatrols integerValue]];
    [self badgeLabel:_videoBadge badgeCount:[homeModel.allVses integerValue]];
    [self badgeLabel:_environmentBadge badgeCount:[homeModel.allEmes integerValue]];
    
    if (![ISSLoginUserModel shareInstance].privilegeCode.M_PATROL) {
        _messageBadge.hidden = YES;
    }
    
    if (![ISSLoginUserModel shareInstance].privilegeCode.M_PATROL) {
        _pendingBadge.hidden = YES;
    }
    
    if (![ISSLoginUserModel shareInstance].privilegeCode.VS) {
        _videoBadge.hidden = YES;
    }
    
    if (![ISSLoginUserModel shareInstance].privilegeCode.ENVIRMENT_VIEW) {
        _environmentBadge.hidden = YES;
    }
}

- (UIColor *)AQIColor:(int )aqiInt
{
    if (aqiInt <= 50) {
        AQITitleLabel.text = @"优";
        return [ISSUtilityMethod colorWithHexColorString:@"#51b26b"];
    }else if (aqiInt <= 100){
        AQITitleLabel.text = @"良";
        return [ISSUtilityMethod colorWithHexColorString:@"#fad749"];
    }else if (aqiInt <= 150){
        AQITitleLabel.text = @"轻度污染";
        return [ISSUtilityMethod colorWithHexColorString:@"#ef8733"];
    }else if (aqiInt <= 200){
        AQITitleLabel.text = @"中度污染";
        return [ISSUtilityMethod colorWithHexColorString:@"#ea3223"];
    }else if (aqiInt <= 300){
        AQITitleLabel.text = @"重度污染";
        return [ISSUtilityMethod colorWithHexColorString:@"#891c4a"];
    }else{
        AQITitleLabel.text = @"严重污染";
        return [ISSUtilityMethod colorWithHexColorString:@"#540d1c"];
    }
}

- (void)badgeLabel:(UILabel *)label badgeCount:(NSInteger)count
{
    if (count > 0) {
        label.hidden = NO;
        if (count < 10) {
            label.size = CGSizeMake(15, 15);
        }else{
            label.size = CGSizeMake(22, 15);
        }
        label.text = [NSString stringWithFormat:@"%ld",(long)count];
    }else{
        label.hidden = YES;
    }
}


@end
