//
//  ISSThirdListTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/31.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdListTableViewCell.h"

@interface ISSThirdListTableViewCell()
{
    UIView          * cellBG;
    UIView          * cellBG1;
    UILabel         * titleLabel;
    UIImageView     * onlineIV;
    UILabel         * timeLabel;
    UIImageView     * nameIV;
    UILabel         * nameLabel;
    UIImageView     * companyIV;
    UILabel         * companyLabel;
    UIImageView     * bottomLine;
    UIImageView     * spaceLine;
    UIImageView     * space1Line;

        
}

@end

@implementation ISSThirdListTableViewCell

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
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        titleLabel.textColor = ISSColorDardGray2;
        titleLabel.text = @"东湖高新巡查报告";
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraints:[titleLabel constraintsTopInContainer:26]];
        [self.contentView addConstraints:[titleLabel constraintsLeftInContainer:32]];
        
        onlineIV = [[UIImageView alloc]initForAutoLayout];
        onlineIV.image = [UIImage imageNamed:@"pending"];
        [self.contentView addSubview:onlineIV];
        [self.contentView addConstraints:[onlineIV constraintsTopInContainer:27.5]];
        [self.contentView addConstraints:[onlineIV constraintsLeft:8 FromView:titleLabel]];
        
        timeLabel = [[UILabel alloc]initForAutoLayout];
        timeLabel.font = ISSFont12;
        timeLabel.textColor = ISSColorDardGray9;
        timeLabel.text = @"2017-08-09";
        [self.contentView addSubview:timeLabel];
        [self.contentView addConstraints:[timeLabel constraintsTopInContainer:26]];
        [self.contentView addConstraints:[timeLabel constraintsRightInContainer:32]];
        
        nameIV = [[UIImageView alloc]initForAutoLayout];
        nameIV.image = [UIImage imageNamed:@"people"];
        [self.contentView addSubview:nameIV];
        [self.contentView addConstraints:[nameIV constraintsTop:32 FromView:timeLabel]];
        [self.contentView addConstraints:[nameIV constraintsLeftInContainer:32]];
        
        nameLabel = [[UILabel alloc]initForAutoLayout];
        nameLabel.font = ISSFont14;
        nameLabel.textColor = ISSColorDardGray2;
        nameLabel.text = @"朱小明";
        [self.contentView addSubview:nameLabel];
        [self.contentView addConstraints:[nameLabel constraintsTop:31 FromView:titleLabel]];
        [self.contentView addConstraints:[nameLabel constraintsLeft:4 FromView:nameIV]];
        
        companyIV = [[UIImageView alloc]initForAutoLayout];
        companyIV.image = [UIImage imageNamed:@"company"];
        [self.contentView addSubview:companyIV];
        [self.contentView addConstraints:[companyIV constraintsTop:32 FromView:timeLabel]];
        [self.contentView addConstraints:[companyIV constraintsLeft:25 FromView:nameLabel]];

        companyLabel = [[UILabel alloc]initForAutoLayout];
        companyLabel.font = ISSFont14;
        companyLabel.textColor = ISSColorDardGray2;
        companyLabel.text = @"武汉智慧园有限公司";
        [self.contentView addSubview:companyLabel];
        [self.contentView addConstraints:[companyLabel constraintsTop:32 FromView:timeLabel]];
        [self.contentView addConstraints:[companyLabel constraintsLeft:4 FromView:companyIV]];
        
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
        [self.contentView addConstraints:[spaceLine constraintsLeftInContainer:(kScreenWidth - 32)/3 + 16]];
        [self.contentView addConstraints:[spaceLine constraintsBottomInContainer:15]];
        
        space1Line = [[UIImageView alloc]initForAutoLayout];
        space1Line.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:space1Line];
        [self.contentView addConstraints:[space1Line constraintsSize:CGSizeMake(0.5, 14)]];
        [self.contentView addConstraints:[space1Line constraintsRightInContainer:(kScreenWidth - 32)/3 + 16]];
        [self.contentView addConstraints:[space1Line constraintsBottomInContainer:15]];

        _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailButton.translatesAutoresizingMaskIntoConstraints = NO;
        _detailButton.titleLabel.font = ISSFont12;
        [_detailButton setTitle:@"查看" forState:UIControlStateNormal];
        [_detailButton setTitleColor:ISSColorNavigationBar forState:UIControlStateNormal];
        [_detailButton setImage:[UIImage imageNamed:@"viewdetail"]  forState:UIControlStateNormal];
        [_detailButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self.contentView addSubview:_detailButton];
        [self.contentView addConstraints:[_detailButton constraintsLeftInContainer:(kScreenWidth-32)/6]];
        [self.contentView addConstraints:[_detailButton constraintsTop:14 FromView:bottomLine]];
        
        _replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _replyButton.translatesAutoresizingMaskIntoConstraints = NO;
        _replyButton.titleLabel.font = ISSFont12;
        [_replyButton setTitle:@"回复" forState:UIControlStateNormal];
        [_replyButton setTitleColor:ISSColorNavigationBar forState:UIControlStateNormal];
        [_replyButton setImage:[UIImage imageNamed:@"respond"]  forState:UIControlStateNormal];
        [_replyButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self.contentView addSubview:_replyButton];
        [self.contentView addConstraint:[_replyButton constraintCenterXInContainer]];
        [self.contentView addConstraints:[_replyButton constraintsTop:14 FromView:bottomLine]];
        
        _visitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _visitButton.translatesAutoresizingMaskIntoConstraints = NO;
        _visitButton.titleLabel.font = ISSFont12;
        [_visitButton setTitle:@"回访" forState:UIControlStateNormal];
        [_visitButton setTitleColor:ISSColorNavigationBar forState:UIControlStateNormal];
        [_visitButton setImage:[UIImage imageNamed:@"revisite"]  forState:UIControlStateNormal];
        [_visitButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self.contentView addSubview:_visitButton];
        [self.contentView addConstraints:[_visitButton constraintsRightInContainer:(kScreenWidth-32)/6]];
        [self.contentView addConstraints:[_visitButton constraintsTop:14 FromView:bottomLine]];
        
        
    }
    return self;
}

- (void)conFigDataThirdListModel:(ISSThirdListModel *)thirdListModel
{
    titleLabel.text = thirdListModel.address;
    [self tipIV:thirdListModel.category];
    NSString * time = [thirdListModel.datetime substringWithRange:NSMakeRange(0, 10)];
    timeLabel.text = [NSString stringWithFormat:@"%@",time];
    nameLabel.text = thirdListModel.account;
    companyLabel.text = thirdListModel.company;
}

- (void)tipIV:(NSString *)infoTypeId
{
    if ([infoTypeId isEqualToString:@"1"]) {
        onlineIV.image = [UIImage imageNamed:@"pending"];
    }else if ([infoTypeId isEqualToString:@"2"]){
        onlineIV.image = [UIImage imageNamed:@"pending"];
    }else if ([infoTypeId isEqualToString:@"3"]){
        onlineIV.image = [UIImage imageNamed:@"waitvisiting"];
    }else if ([infoTypeId isEqualToString:@"4"]){
        onlineIV.image = [UIImage imageNamed:@"sendback"];
    }else if ([infoTypeId isEqualToString:@"5"]){
        onlineIV.image = [UIImage imageNamed:@"pass"];
    }
}



@end
