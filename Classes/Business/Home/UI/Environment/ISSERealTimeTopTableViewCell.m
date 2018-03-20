//
//  ISSERealTimeTopTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSERealTimeTopTableViewCell.h"

@interface ISSERealTimeTopTableViewCell()
{
    UIView          * cellBG;
    UIView          * cellBG1;
    UIImageView     * logoIV;
    UILabel         * nameLabel;
    UILabel         * numLabel;
    UIImageView     * onlineIV;
    UIImageView     * litarrowIV;
    UILabel         * timeLabel;
    UILabel         * addressLabel;
}

@end


@implementation ISSERealTimeTopTableViewCell

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
        [self.contentView addConstraints:[cellBG constraintsSize:CGSizeMake(kScreenWidth - 32, 54)]];
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
    }
    return self;
}

- (void)conFigDataEnvironmentModel:(ISSEnvironmentListModel *)environmentListModel isComeFromHistory:(BOOL)isFromHistory
{
    numLabel.text = environmentListModel.deviceCoding;
    [self tipIV:environmentListModel.deviceStatus];
    NSString * time = [environmentListModel.installTime substringWithRange:NSMakeRange(0, 10)];
    timeLabel.text = [NSString stringWithFormat:@"安装日期：%@",time];
    addressLabel.text = environmentListModel.deviceName;
    
    onlineIV.hidden = timeLabel.hidden = isFromHistory;
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
