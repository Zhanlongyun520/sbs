//
//  ISSUserCenterGreyTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/27.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSUserCenterGreyTableViewCell.h"

@interface ISSUserCenterGreyTableViewCell()
{
    UIImageView  * titleIV;
    UILabel      * titleLabel;
    UILabel      * subTitleLabel;
    UIImageView  * line;

}
@end

@implementation ISSUserCenterGreyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        titleIV = [[UIImageView alloc]initForAutoLayout];
        titleIV.image = [UIImage imageNamed:@"noedit"];
        [self.contentView addSubview:titleIV];
        [self.contentView addConstraints:[titleIV constraintsSize:CGSizeMake(22, 22)]];
        [self.contentView addConstraint:[titleIV constraintCenterYInContainer]];
        [self.contentView addConstraints:[titleIV constraintsLeftInContainer:16]];
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = ISSFont14;
        titleLabel.textColor = ISSColorDardGrayC;
        titleLabel.text = @"角色";
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraint:[titleLabel constraintCenterYInContainer]];
        [self.contentView addConstraints:[titleLabel constraintsLeft:12 FromView:titleIV]];
        
        subTitleLabel = [[UILabel alloc]initForAutoLayout];
        subTitleLabel.font = ISSFont14;
        subTitleLabel.textColor = ISSColorDardGray9;
        subTitleLabel.text = @"监控人员";
        [self.contentView addSubview:subTitleLabel];
        [self.contentView addConstraint:[subTitleLabel constraintCenterYInContainer]];
        [self.contentView addConstraints:[subTitleLabel constraintsRightInContainer:16]];
        
        line = [[UIImageView alloc]initForAutoLayout];
        line.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:line];
        [self.contentView addConstraints:[line constraintsSize:CGSizeMake(kScreenWidth - 16, 0.5)]];
        [self.contentView addConstraints:[line constraintsBottomInContainer:0]];
        [self.contentView addConstraints:[line constraintsLeftInContainer:16]];
        
    }
    return self;
}

- (void)conFigDataTitle:(NSString *)titleStr SubTitle:(NSString *)subTitleStr
{
    titleLabel.text = titleStr;
    subTitleLabel.text = subTitleStr;
}


@end
