//
//  ISSEnvironmentListTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/20.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSEnvironmentListTableViewCell.h"
#import "Masonry.h"

@interface ISSEnvironmentListTableViewCell()
{
    UIView          * cellBG;
    UIView          * cellBG1;
    UIImageView     * logoIV;
    UILabel         * nameLabel;
    UILabel         * numLabel;
    
    UILabel         * PM10Label;
    UILabel         * PM10NumLabel;
    UILabel         * PM25Label;
    UILabel         * PM25NumLabel;
    
    UILabel         * CO2Label;
    UILabel         * CO2NumLabel;
    
    UIImageView     * onlineIV;
    UILabel         * timeLabel;
    UILabel         * addressLabel;
    UIImageView     * litarrowIV;
    UIImageView     * bottomLine;
    UIImageView     * spaceLine;
}

@end

@implementation ISSEnvironmentListTableViewCell

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
        [self.contentView addConstraints:[cellBG constraintsSize:CGSizeMake(kScreenWidth - 32, 98 + 44)]];
        [self.contentView addConstraints:[cellBG constraintsTop:0 FromView:cellBG1]];
        [self.contentView addConstraints:[cellBG constraintsLeftInContainer:16]];
        
        nameLabel = [[UILabel alloc]initForAutoLayout];
        nameLabel.font = ISSFont12;
        nameLabel.textColor = ISSColorDardGray9;
        nameLabel.text = @"设备编号:";
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
        
        _mapButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_mapButton];

        [_mapButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cellBG);
            make.height.equalTo(@40);
            make.left.equalTo(@16);
            make.right.equalTo(@-16);
        }];
        
        PM10Label = [[UILabel alloc]initForAutoLayout];
        PM10Label.font = ISSFont12;
        PM10Label.textColor = ISSColorDardGray2;
        PM10Label.text = @"PM10:";
        [self.contentView addSubview:PM10Label];
        [self.contentView addConstraints:[PM10Label constraintsTop:25 FromView:addressLabel]];
        [self.contentView addConstraints:[PM10Label constraintsLeftInContainer:38]];
        
        PM10NumLabel = [[UILabel alloc]initForAutoLayout];
        PM10NumLabel.font = ISSFont12;
        PM10NumLabel.textColor = ISSColorNavigationBar;
        PM10NumLabel.text = @"32";
        [self.contentView addSubview:PM10NumLabel];
        [self.contentView addConstraints:[PM10NumLabel constraintsTop:25 FromView:addressLabel]];
        [self.contentView addConstraints:[PM10NumLabel constraintsLeft:5 FromView:PM10Label]];
     
        
        UIImageView * line = [[UIImageView alloc]initForAutoLayout];
        line.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:line];
        [self.contentView addConstraints:[line constraintsSize:CGSizeMake(0.5, 10)]];
        [self.contentView addConstraints:[line constraintsTop:27.5 FromView:addressLabel]];
        [self.contentView addConstraints:[line constraintsLeft:12 FromView:PM10NumLabel]];
        
        PM25Label = [[UILabel alloc]initForAutoLayout];
        PM25Label.font = ISSFont12;
        PM25Label.textColor = ISSColorDardGray2;
        PM25Label.text = @"PM2.5:";
        [self.contentView addSubview:PM25Label];
        [self.contentView addConstraints:[PM25Label constraintsTop:25 FromView:addressLabel]];
        [self.contentView addConstraints:[PM25Label constraintsLeft:12 FromView:line]];
        
        PM25NumLabel = [[UILabel alloc]initForAutoLayout];
        PM25NumLabel.font = ISSFont12;
        PM25NumLabel.textColor = ISSColorNavigationBar;
        PM25NumLabel.text = @"32";
        [self.contentView addSubview:PM25NumLabel];
        [self.contentView addConstraints:[PM25NumLabel constraintsTop:25 FromView:addressLabel]];
        [self.contentView addConstraints:[PM25NumLabel constraintsLeft:5 FromView:PM25Label]];
        
        UIImageView * line1 = [[UIImageView alloc]initForAutoLayout];
        line1.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:line1];
        [self.contentView addConstraints:[line1 constraintsSize:CGSizeMake(0.5, 10)]];
        [self.contentView addConstraints:[line1 constraintsTop:27.5 FromView:addressLabel]];
        [self.contentView addConstraints:[line1 constraintsLeft:12 FromView:PM25NumLabel]];
        
        CO2Label = [[UILabel alloc]initForAutoLayout];
        CO2Label.font = ISSFont12;
        CO2Label.textColor = ISSColorDardGray2;
        CO2Label.text = @"CO2:";
        [self.contentView addSubview:CO2Label];
        [self.contentView addConstraints:[CO2Label constraintsTop:25 FromView:addressLabel]];
        [self.contentView addConstraints:[CO2Label constraintsLeft:5 FromView:line1]];
        
        CO2NumLabel = [[UILabel alloc]initForAutoLayout];
        CO2NumLabel.font = ISSFont12;
        CO2NumLabel.textColor = ISSColorNavigationBar;
        CO2NumLabel.text = @"32";
        [self.contentView addSubview:CO2NumLabel];
        [self.contentView addConstraints:[CO2NumLabel constraintsTop:25 FromView:addressLabel]];
        [self.contentView addConstraints:[CO2NumLabel constraintsLeft:5 FromView:CO2Label]];
        
        spaceLine = [[UIImageView alloc]initForAutoLayout];
        spaceLine.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:spaceLine];
        [self.contentView addConstraints:[spaceLine constraintsSize:CGSizeMake(0.5, 14)]];
        [self.contentView addConstraint:[spaceLine constraintCenterXInContainer]];
        [self.contentView addConstraints:[spaceLine constraintsBottomInContainer:15]];
        
        //下部
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
        
        _historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _historyButton.translatesAutoresizingMaskIntoConstraints = NO;
        _historyButton.titleLabel.font = ISSFont12;
        [_historyButton setTitle:@"历史数据" forState:UIControlStateNormal];
        [_historyButton setTitleColor:ISSColorNavigationBar forState:UIControlStateNormal];
        [_historyButton setImage:[UIImage imageNamed:@"history"]  forState:UIControlStateNormal];
        [_historyButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self.contentView addSubview:_historyButton];
        [self.contentView addConstraints:[_historyButton constraintsRightInContainer:(kScreenWidth-32)/4]];
        [self.contentView addConstraints:[_historyButton constraintsTop:14 FromView:bottomLine]];
        
        _realTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _realTimeButton.translatesAutoresizingMaskIntoConstraints = NO;
        _realTimeButton.titleLabel.font = ISSFont12;
        [_realTimeButton setTitle:@"实时数据" forState:UIControlStateNormal];
        [_realTimeButton setTitleColor:ISSColorNavigationBar forState:UIControlStateNormal];
        [_realTimeButton setImage:[UIImage imageNamed:@"time"]  forState:UIControlStateNormal];
        [_realTimeButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self.contentView addSubview:_realTimeButton];
        [self.contentView addConstraints:[_realTimeButton constraintsLeftInContainer:(kScreenWidth-32)/4]];
        [self.contentView addConstraints:[_realTimeButton constraintsTop:14 FromView:bottomLine]];
        
    }
    return self;
}

- (void)conFigDataEnvironmentListModel:(ISSEnvironmentListModel *)environmentListModel
{
    numLabel.text = environmentListModel.deviceCoding;
    [self tipIV:environmentListModel.deviceStatus];
    NSString * time = [environmentListModel.installTime substringWithRange:NSMakeRange(0, 10)];
    timeLabel.text = [NSString stringWithFormat:@"安装日期：%@",time];
    addressLabel.text = environmentListModel.deviceName;
    
    PM10NumLabel.text = [NSString stringWithFormat:@"%.1f", environmentListModel.pm10.floatValue];
    PM25NumLabel.text = [NSString stringWithFormat:@"%.1f", environmentListModel.pm25.floatValue];
    CO2NumLabel.text = [NSString stringWithFormat:@"%.1f", environmentListModel.co2.floatValue];
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
