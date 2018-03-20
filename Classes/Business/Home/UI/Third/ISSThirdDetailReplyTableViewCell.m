
//
//  ISSThirdDetailReplyTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdDetailReplyTableViewCell.h"

@interface ISSThirdDetailReplyTableViewCell()
{
    UILabel         * timeLabel;
    UIImageView     * chatBG;
    UIImageView     * headIV;
    UILabel         * nameLabel;
    UIImageView     * stateIV;
    
    UILabel         * detailLabel;
    UIImageView     * image1;
    
}
@end

@implementation ISSThirdDetailReplyTableViewCell

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
        [self.contentView addConstraints:[headIV constraintsRightInContainer:16]];
        
        nameLabel = [[UILabel alloc]initForAutoLayout];
        nameLabel.font = ISSFont12;
        nameLabel.textColor = ISSColorDardGray9;
        nameLabel.text = @"朱小明";
        nameLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:nameLabel];
        [self.contentView addConstraints:[nameLabel constraintsTop:6 FromView:headIV]];
        [self.contentView addConstraints:[nameLabel constraintsRightInContainer:16]];
        
        stateIV = [[UIImageView alloc]initForAutoLayout];
        stateIV.image = [UIImage imageNamed:@"waitvisiting"];
        [self.contentView addSubview:stateIV];
        [self.contentView addConstraints:[stateIV constraintsTop:6 FromView:nameLabel]];
        [self.contentView addConstraints:[stateIV constraintsRightInContainer:16]];
        
        
        chatBG = [[UIImageView alloc]initForAutoLayout];
        chatBG.image = [ISSUtilityMethod createImageWithColor:ISSColorViewBg];
        [self.contentView addSubview:chatBG];
        
        detailLabel = [[UILabel alloc]initForAutoLayout];
        detailLabel.font = ISSFont14;
        detailLabel.textColor = ISSColorDardGray2;
        detailLabel.text = @"光谷中心城违章报告光谷中心城违章报告光谷中心城违章报告光谷中心城违";
        detailLabel.numberOfLines = 0;
        detailLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:detailLabel];
        [self.contentView addConstraints:[detailLabel constraintsTop:40 FromView:timeLabel]];
        [self.contentView addConstraints:[detailLabel constraintsRight:20 FromView:headIV]];
        [self.contentView addConstraints:[detailLabel constraintsLeftInContainer:32]];
        
        image1 = [[UIImageView alloc]initForAutoLayout];
        image1.image = [ISSUtilityMethod createImageWithColor:ISSRandomColor];
        [self.contentView addSubview:image1];
        [self.contentView addConstraints:[image1 constraintsSize:CGSizeMake(40, 40)]];
        [self.contentView addConstraints:[image1 constraintsRight:20 FromView:headIV]];
        [self.contentView addConstraints:[image1 constraintsTop:16 FromView:detailLabel]];
        
        [self.contentView addConstraints:[chatBG constraintsSize:CGSizeMake(kScreenWidth - 72 , 120)]];
        [self.contentView addConstraints:[chatBG constraintsTop:20 FromView:timeLabel]];
        [self.contentView addConstraints:[chatBG constraintsRight:0 FromView:headIV]];
        
    }
    return self;
}

@end
