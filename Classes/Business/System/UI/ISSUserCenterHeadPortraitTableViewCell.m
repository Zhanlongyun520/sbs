
//
//  ISSUserCenterHeadPortraitTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/27.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSUserCenterHeadPortraitTableViewCell.h"

@interface ISSUserCenterHeadPortraitTableViewCell()
{
    UIImageView     * titleIV;
    UILabel         * titleLabel;    
}

@end

@implementation ISSUserCenterHeadPortraitTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.contentView.backgroundColor = ISSColorNavigationBar;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        titleIV = [[UIImageView alloc]initForAutoLayout];
        titleIV.image = [UIImage imageNamed:@"editcolumn"];
        [self.contentView addSubview:titleIV];
        [self.contentView addConstraints:[titleIV constraintsSize:CGSizeMake(22, 22)]];
        [self.contentView addConstraint:[titleIV constraintCenterYInContainer]];
        [self.contentView addConstraints:[titleIV constraintsLeftInContainer:16]];
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = ISSFont14;
        titleLabel.textColor = ISSColorDardGray6;
        titleLabel.text = @"头像";
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraint:[titleLabel constraintCenterYInContainer]];
        [self.contentView addConstraints:[titleLabel constraintsLeft:12 FromView:titleIV]];
        
        self.headPortraitIV = [[UIImageView alloc]initForAutoLayout];
        _headPortraitIV.image = [UIImage imageNamed:@"default-head"];
        _headPortraitIV.layer.masksToBounds = YES;
        _headPortraitIV.layer.cornerRadius = 48/2;
        [self.contentView addSubview:_headPortraitIV];
        [self.contentView addConstraints:[_headPortraitIV constraintsSize:CGSizeMake(48, 48)]];
        [self.contentView addConstraint:[_headPortraitIV constraintCenterYInContainer]];
        [self.contentView addConstraints:[_headPortraitIV constraintsRightInContainer:16]];
    }
    return self;
}



@end
