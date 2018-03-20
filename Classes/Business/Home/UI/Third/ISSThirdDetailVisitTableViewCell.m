//
//  ISSThirdDetailVisitTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdDetailVisitTableViewCell.h"

@interface ISSThirdDetailVisitTableViewCell()
{
    UILabel         * timeLabel;
    UIImageView     * chatBG;
    UIImageView     * headIV;
    UILabel         * nameLabel;
    
    UILabel         * peopleNameLabel;
    UILabel         * peopleLabel;
    
    UILabel         * timeNameLabel;
    UILabel         * starTimeLabel;
    UILabel         * endTimeLabel;

    UIImageView     * line;

    UILabel         * titleLabel;
    UILabel         * detailLabel;
    
    UIImageView     * image1;
    
}

@end

@implementation ISSThirdDetailVisitTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorWhite;
        
        timeLabel = [[UILabel alloc]initForAutoLayout];
        timeLabel.font = ISSFont12;
        timeLabel.textColor = ISSColorDardGrayC;
        timeLabel.text = @"2017-09-29";
        [self.contentView addSubview:timeLabel];
        [self.contentView addConstraints:[timeLabel constraintsTopInContainer:32]];
        [self.contentView addConstraint:[timeLabel constraintCenterXInContainer]];
        
        headIV = [[UIImageView alloc]initForAutoLayout];
        headIV.image = [UIImage imageNamed:@"default-head"];
        [self.contentView addSubview:headIV];
        [self.contentView addConstraints:[headIV constraintsSize:CGSizeMake(40 , 40)]];
        [self.contentView addConstraints:[headIV constraintsTop:20 FromView:timeLabel]];
        [self.contentView addConstraints:[headIV constraintsLeftInContainer:16]];
        
        nameLabel = [[UILabel alloc]initForAutoLayout];
        nameLabel.font = ISSFont12;
        nameLabel.textColor = ISSColorDardGray9;
        nameLabel.text = @"朱小明";
        [self.contentView addSubview:nameLabel];
        [self.contentView addConstraints:[nameLabel constraintsTop:6 FromView:headIV]];
        [self.contentView addConstraints:[nameLabel constraintsLeftInContainer:16]];
        
        chatBG = [[UIImageView alloc]initForAutoLayout];
        chatBG.image = [ISSUtilityMethod createImageWithColor:ISSColorViewBg];
        [self.contentView addSubview:chatBG];
        
        peopleNameLabel = [[UILabel alloc]initForAutoLayout];
        peopleNameLabel.font = ISSFont12;
        peopleNameLabel.textColor = ISSColorDardGray6;
        peopleNameLabel.text = @"巡查人员：";
        [self.contentView addSubview:peopleNameLabel];
        [self.contentView addConstraints:[peopleNameLabel constraintsTop:40 FromView:timeLabel]];
        [self.contentView addConstraints:[peopleNameLabel constraintsLeft:20 FromView:headIV]];
        
        peopleLabel = [[UILabel alloc]initForAutoLayout];
        peopleLabel.font = ISSFont12;
        peopleLabel.textColor = ISSColorDardGray2;
        peopleLabel.text = @"张三、李四、王五";
        [self.contentView addSubview:peopleLabel];
        [self.contentView addConstraints:[peopleLabel constraintsTop:40 FromView:timeLabel]];
        [self.contentView addConstraints:[peopleLabel constraintsLeft:0 FromView:peopleNameLabel]];
        
        starTimeLabel = [[UILabel alloc]initForAutoLayout];
        starTimeLabel.font = ISSFont12;
        starTimeLabel.textColor = ISSColorDardGray2;
        starTimeLabel.text = @"2017-09-29 17:00";
        [self.contentView addSubview:starTimeLabel];
        [self.contentView addConstraints:[starTimeLabel constraintsTop:13 FromView:peopleLabel]];
        [self.contentView addConstraints:[starTimeLabel constraintsLeft:0 FromView:peopleNameLabel]];
        
        timeNameLabel = [[UILabel alloc]initForAutoLayout];
        timeNameLabel.font = ISSFont12;
        timeNameLabel.textColor = ISSColorDardGray6;
        timeNameLabel.text = @"巡查时间：";
        [self.contentView addSubview:timeNameLabel];
        [self.contentView addConstraints:[timeNameLabel constraintsTop:-5 FromView:starTimeLabel]];
        [self.contentView addConstraints:[timeNameLabel constraintsLeft:20 FromView:headIV]];
        
        endTimeLabel = [[UILabel alloc]initForAutoLayout];
        endTimeLabel.font = ISSFont12;
        endTimeLabel.textColor = ISSColorDardGray2;
        endTimeLabel.text = @"2017-09-30 09:00";
        [self.contentView addSubview:endTimeLabel];
        [self.contentView addConstraints:[endTimeLabel constraintsTop:8 FromView:starTimeLabel]];
        [self.contentView addConstraints:[endTimeLabel constraintsLeft:0 FromView:peopleNameLabel]];
        
        line = [[UIImageView alloc]initForAutoLayout];
        line.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:line];
        [self.contentView addConstraint:[line constraintHeight:0.5]];
        [self.contentView addConstraints:[line constraintsTop:16 FromView:endTimeLabel]];
        [self.contentView addConstraints:[line constraintsRightInContainer:32]];
        [self.contentView addConstraints:[line constraintsLeft:20 FromView:headIV]];

        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        titleLabel.textColor = ISSColorDardGray2;
        titleLabel.text = @"光谷中心城违章报告";
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraints:[titleLabel constraintsTop:16 FromView:line]];
        [self.contentView addConstraints:[titleLabel constraintsLeft:20 FromView:headIV]];
        
        detailLabel = [[UILabel alloc]initForAutoLayout];
        detailLabel.font = ISSFont14;
        detailLabel.textColor = ISSColorDardGray2;
        detailLabel.text = @"光谷中心城违章报告光谷中心城违章报告光谷中心城违章报告光谷中心城违章报告光谷中心城违章报告";
        detailLabel.numberOfLines = 0;
        [self.contentView addSubview:detailLabel];
        [self.contentView addConstraints:[detailLabel constraintsTop:16 FromView:titleLabel]];
        [self.contentView addConstraints:[detailLabel constraintsLeft:20 FromView:headIV]];
        [self.contentView addConstraints:[detailLabel constraintsRightInContainer:32]];
        
        image1 = [[UIImageView alloc]initForAutoLayout];
        image1.image = [ISSUtilityMethod createImageWithColor:ISSRandomColor];
        [self.contentView addSubview:image1];
        [self.contentView addConstraints:[image1 constraintsSize:CGSizeMake(40, 40)]];
        [self.contentView addConstraints:[image1 constraintsLeft:20 FromView:headIV]];
        [self.contentView addConstraints:[image1 constraintsTop:16 FromView:detailLabel]];

        [self.contentView addConstraints:[chatBG constraintsSize:CGSizeMake(kScreenWidth - 72 , 280)]];
        [self.contentView addConstraints:[chatBG constraintsTop:20 FromView:timeLabel]];
        [self.contentView addConstraints:[chatBG constraintsLeft:0 FromView:headIV]];
        
    }
    return self;
}

- (void)conFigDataReportModel:(ISSReportModel *)reportModel
{
    NSString * time = [reportModel.date substringWithRange:NSMakeRange(0, 10)];
    timeLabel.text = time;
    headIV.image = [UIImage imageNamed:reportModel.imageData];
    nameLabel.text = reportModel.name;
    peopleLabel.text = reportModel.patrolUser;
    
}


@end
