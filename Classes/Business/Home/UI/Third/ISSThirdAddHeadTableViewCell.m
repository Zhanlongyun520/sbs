//
//  ISSThirdAddHeadTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/3.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdAddHeadTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ISSLoginUserModel.h"

@interface ISSThirdAddHeadTableViewCell()
{
    UIImageView     * headIV;
    UILabel         * nameLabel;
    UILabel         * detailLabel;
    
}
@end

@implementation ISSThirdAddHeadTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorWhite;
        
        headIV = [[UIImageView alloc]initForAutoLayout];
        [headIV sd_setImageWithURL:[ISSLoginUserModel shareInstance].loginUser.imageData placeholderImage:[UIImage imageNamed:@"default-head"]];
        [self.contentView addSubview:headIV];
        [self.contentView addConstraints:[headIV constraintsSize:CGSizeMake(32, 32)]];
        [self.contentView addConstraint:[headIV constraintCenterYInContainer]];
        [self.contentView addConstraints:[headIV constraintsLeftInContainer:16]];
        
        nameLabel = [[UILabel alloc]initForAutoLayout];
        nameLabel.font = ISSFont14;
        nameLabel.textColor = ISSColorDardGray2;
        nameLabel.text = [ISSLoginUserModel shareInstance].loginUser.name;
        [self.contentView addSubview:nameLabel];
        [self.contentView addConstraint:[nameLabel constraintTopEqualToView:headIV]];
        [self.contentView addConstraints:[nameLabel constraintsLeft:12 FromView:headIV]];
        
        detailLabel = [[UILabel alloc]initForAutoLayout];
        detailLabel.font = ISSFont10;
        detailLabel.textColor = ISSColorDardGrayC;
        detailLabel.text = @"报告人员";
        [self.contentView addSubview:detailLabel];
        [self.contentView addConstraint:[detailLabel constraintBottomEqualToView:headIV]];
        [self.contentView addConstraints:[detailLabel constraintsLeft:12 FromView:headIV]];
        
    }
    return self;
}

@end
