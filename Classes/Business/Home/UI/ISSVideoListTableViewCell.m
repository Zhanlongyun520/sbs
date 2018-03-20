//
//  ISSVideoListTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/20.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSVideoListTableViewCell.h"

@interface ISSVideoListTableViewCell()
{
    UIView          * cellBG;
    UIView          * cellBG1;
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

@implementation ISSVideoListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorViewBg;
        
        cellBG1 = [[UIView alloc]initForAutoLayout];
        cellBG1.backgroundColor = ISSColorViewBg1;
        [self.contentView addSubview:cellBG1];
        [self.contentView addConstraints:[cellBG1 constraintsSize:CGSizeMake(kScreenWidth - 32, 44)]];
        [self.contentView addConstraints:[cellBG1 constraintsTopInContainer:10]];
        [self.contentView addConstraints:[cellBG1 constraintsLeftInContainer:16]];
        
        cellBG = [[UIView alloc]initForAutoLayout];
        cellBG.backgroundColor = ISSColorWhite;
        [self.contentView addSubview:cellBG];
        [self.contentView addConstraints:[cellBG constraintsSize:CGSizeMake(kScreenWidth - 32, 98)]];
        [self.contentView addConstraints:[cellBG constraintsTop:0 FromView:cellBG1]];
        [self.contentView addConstraints:[cellBG constraintsLeftInContainer:16]];
        
        nameLabel = [[UILabel alloc]initForAutoLayout];
        nameLabel.font = ISSFont12;
        nameLabel.textColor = ISSColorDardGray9;
        nameLabel.text = @"设备名称:";
        [self.contentView addSubview:nameLabel];
        [self.contentView addConstraints:[nameLabel constraintsTopInContainer:26]];
        [self.contentView addConstraints:[nameLabel constraintsLeftInContainer:32]];
        
        numLabel = [[UILabel alloc]initForAutoLayout];
        numLabel.font = ISSFont14;
        numLabel.textColor = ISSColorDardGray2;
        numLabel.text = @"1330965";
        [self.contentView addSubview:numLabel];
        [self.contentView addConstraints:[numLabel constraintsTopInContainer:24]];
        [self.contentView addConstraints:[numLabel constraintsLeft:1 FromView:nameLabel]];
        
        onlineIV = [[UIImageView alloc]initForAutoLayout];
        onlineIV.image = [UIImage imageNamed:@"online"];
        [self.contentView addSubview:onlineIV];
        [self.contentView addConstraints:[onlineIV constraintsSize:CGSizeMake(28, 14)]];
        [self.contentView addConstraints:[onlineIV constraintsTopInContainer:25]];
        [self.contentView addConstraints:[onlineIV constraintsLeft:5 FromView:numLabel]];

        timeLabel = [[UILabel alloc]initForAutoLayout];
        timeLabel.font = ISSFont12;
        timeLabel.textColor = ISSColorDardGray9;
        timeLabel.text = @"安装日期：2017-08-09";
        [self.contentView addSubview:timeLabel];
        [self.contentView addConstraints:[timeLabel constraintsTopInContainer:26]];
        [self.contentView addConstraints:[timeLabel constraintsRightInContainer:32]];
        
        logoIV = [[UIImageView alloc]initForAutoLayout];
        logoIV.image = [UIImage imageNamed:@"site"];
        [self.contentView addSubview:logoIV];
        [self.contentView addConstraints:[logoIV constraintsTop:33 FromView:nameLabel]];
        [self.contentView addConstraints:[logoIV constraintsLeftInContainer:32]];

        addressLabel = [[UILabel alloc]initForAutoLayout];
        addressLabel.font = ISSFont14;
        addressLabel.textColor = ISSColorDardGray2;
        addressLabel.text = @"东湖高新区光谷六路";
        [self.contentView addSubview:addressLabel];
        [self.contentView addConstraints:[addressLabel constraintsTop:31 FromView:nameLabel]];
        [self.contentView addConstraints:[addressLabel constraintsLeft:4 FromView:logoIV]];

        litarrowIV = [[UIImageView alloc]initForAutoLayout];
        litarrowIV.image = [UIImage imageNamed:@"litarrow"];
        [self.contentView addSubview:litarrowIV];
        [self.contentView addConstraints:[litarrowIV constraintsTop:34 FromView:nameLabel]];
        [self.contentView addConstraints:[litarrowIV constraintsRightInContainer:32]];
        
        bottomLine = [[UIImageView alloc]initForAutoLayout];
        bottomLine.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:bottomLine];
        [self.contentView addConstraints:[bottomLine constraintsSize:CGSizeMake(kScreenWidth - 64, 0.5)]];
        [self.contentView addConstraints:[bottomLine constraintsBottomInContainer:44]];
        [self.contentView addConstraints:[bottomLine constraintsLeftInContainer:32]];
        
        spaceLine = [[UIImageView alloc]initForAutoLayout];
        spaceLine.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:spaceLine];
        [self.contentView addConstraints:[spaceLine constraintsSize:CGSizeMake(0.5, 14)]];
        [self.contentView addConstraint:[spaceLine constraintCenterXInContainer]];
        [self.contentView addConstraints:[spaceLine constraintsBottomInContainer:15]];
        
        _mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _mapButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_mapButton];
        [self.contentView addConstraints:[_mapButton constraintsSize:CGSizeMake(kScreenWidth - 32, 44)]];
        [self.contentView addConstraints:[_mapButton constraintsRightInContainer:16]];
        [self.contentView addConstraints:[_mapButton constraintsTopInContainer:64]];
        
        _historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _historyButton.translatesAutoresizingMaskIntoConstraints = NO;
        _historyButton.titleLabel.font = ISSFont12;
        [_historyButton setTitle:@"历史监控" forState:UIControlStateNormal];
        [_historyButton setTitleColor:ISSColorNavigationBar forState:UIControlStateNormal];
        [_historyButton setImage:[UIImage imageNamed:@"history"]  forState:UIControlStateNormal];
        [_historyButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self.contentView addSubview:_historyButton];
        [self.contentView addConstraints:[_historyButton constraintsLeftInContainer:(kScreenWidth-82)/6]];
        [self.contentView addConstraints:[_historyButton constraintsTop:14 FromView:bottomLine]];

        _realTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _realTimeButton.translatesAutoresizingMaskIntoConstraints = NO;
        _realTimeButton.titleLabel.font = ISSFont12;
        [_realTimeButton setTitle:@"实时监控" forState:UIControlStateNormal];
        [_realTimeButton setTitleColor:ISSColorNavigationBar forState:UIControlStateNormal];
        [_realTimeButton setImage:[UIImage imageNamed:@"time"]  forState:UIControlStateNormal];
        [_realTimeButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self.contentView addSubview:_realTimeButton];
        [self.contentView addConstraint:[_realTimeButton constraintCenterXInContainer]];
        [self.contentView addConstraints:[_realTimeButton constraintsTop:14 FromView:bottomLine]];
        
        _ssButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _ssButton.translatesAutoresizingMaskIntoConstraints = NO;
        _ssButton.titleLabel.font = ISSFont12;
        [_ssButton setTitle:@"视频抓拍" forState:UIControlStateNormal];
        [_ssButton setTitleColor:ISSColorNavigationBar forState:UIControlStateNormal];
        [_ssButton setImage:[UIImage imageNamed:@"capture"]  forState:UIControlStateNormal];
        [_ssButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self.contentView addSubview:_ssButton];
        [self.contentView addConstraints:[_ssButton constraintsRightInContainer:(kScreenWidth-82)/6]];
        [self.contentView addConstraints:[_ssButton constraintsTop:14 FromView:bottomLine]];
    }
    return self;
}

- (void)conFigDataVideoModel:(ISSVideoModel *)videoModel
{
    numLabel.text = [NSString stringWithFormat:@"%@",videoModel.deviceCoding];
    [self tipIV:videoModel.deviceStatus];
    NSString * time = [videoModel.installTime substringWithRange:NSMakeRange(0, 10)];
    timeLabel.text = [NSString stringWithFormat:@"安装日期：%@",time];
    addressLabel.text = [NSString stringWithFormat:@"%@",videoModel.deviceName];

}

- (void)tipIV:(NSString *)infoTypeId
{
    if ([infoTypeId isEqualToString:@"0"]) {
        onlineIV.image = [UIImage imageNamed:@"online"];
    }else if ([infoTypeId isEqualToString:@"1"]){
        onlineIV.image = [UIImage imageNamed:@"offline"];
    }else if ([infoTypeId isEqualToString:@"2"]){
        onlineIV.image = [UIImage imageNamed:@"breakdown"];
    }
}

@end
