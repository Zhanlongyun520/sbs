//
//  ISSSelectAnnotationView.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/29.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSSelectAnnotationView.h"

@interface ISSSelectAnnotationView()
{
    UIImageView         * bgView;
    UIImageView     * logoIV;
    UILabel         * nameLabel;
    UILabel         * numLabel;
    UIImageView     * onlineIV;
    UILabel         * timeLabel;
    UILabel         * addressLabel;
    UIImageView     * litarrowIV;
    UIImageView     * bottomLine;
    UIImageView     * spaceLine;
}

@end

@implementation ISSSelectAnnotationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        bgView = [[UIImageView alloc]initForAutoLayout];
        bgView.image = [UIImage imageNamed:@"map-bg"];
        [self addSubview:bgView];
        [self addConstraints:[bgView constraintsSize:CGSizeMake(kScreenWidth - 32, 180)]];
        [self addConstraints:[bgView constraintsBottomInContainer:0]];
        [self addConstraints:[bgView constraintsLeftInContainer:16]];

        nameLabel = [[UILabel alloc]initForAutoLayout];
        nameLabel.font = ISSFont12;
        nameLabel.textColor = ISSColorDardGray9;
        nameLabel.text = @"设备名称:";
        [self addSubview:nameLabel];
        [self addConstraints:[nameLabel constraintsTopInContainer:80]];
        [self addConstraints:[nameLabel constraintsLeftInContainer:32]];
        
        numLabel = [[UILabel alloc]initForAutoLayout];
        numLabel.font = ISSFont14;
        numLabel.textColor = ISSColorDardGray2;
        numLabel.text = @"1330965";
        [self addSubview:numLabel];
        [self addConstraints:[numLabel constraintsTopInContainer:80]];
        [self addConstraints:[numLabel constraintsLeft:1 FromView:nameLabel]];
        
        onlineIV = [[UIImageView alloc]initForAutoLayout];
        onlineIV.image = [UIImage imageNamed:@"online"];
        [self addSubview:onlineIV];
        [self addConstraints:[onlineIV constraintsSize:CGSizeMake(28, 14)]];
        [self addConstraints:[onlineIV constraintsTopInContainer:80]];
        [self addConstraints:[onlineIV constraintsLeft:5 FromView:numLabel]];
        
        timeLabel = [[UILabel alloc]initForAutoLayout];
        timeLabel.font = ISSFont12;
        timeLabel.textColor = ISSColorDardGray9;
        timeLabel.text = @"安装日期：2017-08-09";
        [self addSubview:timeLabel];
        [self addConstraints:[timeLabel constraintsTopInContainer:80]];
        [self addConstraints:[timeLabel constraintsRightInContainer:32]];
        
        logoIV = [[UIImageView alloc]initForAutoLayout];
        logoIV.image = [UIImage imageNamed:@"site"];
        [self addSubview:logoIV];
        [self addConstraints:[logoIV constraintsTop:33 FromView:nameLabel]];
        [self addConstraints:[logoIV constraintsLeftInContainer:32]];
        
        addressLabel = [[UILabel alloc]initForAutoLayout];
        addressLabel.font = ISSFont14;
        addressLabel.textColor = ISSColorDardGray2;
        addressLabel.text = @"东湖高新区光谷六路";
        [self addSubview:addressLabel];
        [self addConstraints:[addressLabel constraintsTop:31 FromView:nameLabel]];
        [self addConstraints:[addressLabel constraintsLeft:4 FromView:logoIV]];
        
        bottomLine = [[UIImageView alloc]initForAutoLayout];
        bottomLine.backgroundColor = ISSColorSeparatorLine;
        [self addSubview:bottomLine];
        [self addConstraints:[bottomLine constraintsSize:CGSizeMake(kScreenWidth - 64, 0.5)]];
        [self addConstraints:[bottomLine constraintsBottomInContainer:44]];
        [self addConstraints:[bottomLine constraintsLeftInContainer:32]];
        
        spaceLine = [[UIImageView alloc]initForAutoLayout];
        spaceLine.backgroundColor = ISSColorSeparatorLine;
        [self addSubview:spaceLine];
        [self addConstraints:[spaceLine constraintsSize:CGSizeMake(0.5, 14)]];
        [self addConstraint:[spaceLine constraintCenterXInContainer]];
        [self addConstraints:[spaceLine constraintsBottomInContainer:15]];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
//        _cancelButton.backgroundColor = ISSColorRed;
        [self addSubview:_cancelButton];
        [self addConstraints:[_cancelButton constraintsSize:CGSizeMake(50, 28)]];
        [self addConstraint:[_cancelButton constraintCenterXInContainer]];
        [self addConstraints:[_cancelButton constraintsTopInContainer:40]];
        
        _historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _historyButton.translatesAutoresizingMaskIntoConstraints = NO;
        _historyButton.titleLabel.font = ISSFont12;
        [_historyButton setTitle:@"历史监控" forState:UIControlStateNormal];
        [_historyButton setTitleColor:ISSColorNavigationBar forState:UIControlStateNormal];
        [_historyButton setImage:[UIImage imageNamed:@"history"]  forState:UIControlStateNormal];
        [_historyButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self addSubview:_historyButton];
        [self addConstraints:[_historyButton constraintsRightInContainer:(kScreenWidth-32)/4]];
        [self addConstraints:[_historyButton constraintsTop:14 FromView:bottomLine]];
        
        _realTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _realTimeButton.translatesAutoresizingMaskIntoConstraints = NO;
        _realTimeButton.titleLabel.font = ISSFont12;
        [_realTimeButton setTitle:@"实时监控" forState:UIControlStateNormal];
        [_realTimeButton setTitleColor:ISSColorNavigationBar forState:UIControlStateNormal];
        [_realTimeButton setImage:[UIImage imageNamed:@"time"]  forState:UIControlStateNormal];
        [_realTimeButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self addSubview:_realTimeButton];
        [self addConstraints:[_realTimeButton constraintsLeftInContainer:(kScreenWidth-32)/4]];
        [self addConstraints:[_realTimeButton constraintsTop:14 FromView:bottomLine]];
    }
    return self;
}

@end
