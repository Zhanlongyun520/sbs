//
//  ISSSystemTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/26.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSSystemTableViewCell.h"

@interface ISSSystemTableViewCell()
{
    UIImageView     * logoIV;
    UILabel         * titleLabel;
    UIView          * bottomLine;
}
@end

@implementation ISSSystemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorWhite;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        logoIV = [[UIImageView alloc]initForAutoLayout];
        [self.contentView addSubview:logoIV];
        [self.contentView addConstraint:[logoIV constraintCenterYInContainer]];
        [self.contentView addConstraints:[logoIV constraintsLeftInContainer:24]];
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = ISSFont14;
        titleLabel.textColor = ISSColorDardGray2;
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraint:[titleLabel constraintCenterYInContainer]];
        [self.contentView addConstraints:[titleLabel constraintsLeft:12 FromView:logoIV]];
        
        bottomLine = [[UIImageView alloc]initForAutoLayout];
        bottomLine.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:bottomLine];
        [self.contentView addConstraints:[bottomLine constraintsSize:CGSizeMake(kScreenWidth, 0.5)]];
        [self.contentView addConstraints:[bottomLine constraintsBottomInContainer:0]];
        
    }
    return self;
}

- (void)conFigDataTitle:(NSString *)titleStr Image:(NSString *)imageStr HiddenLine:(BOOL )isHiddenLine
{
    logoIV.image = [UIImage imageNamed:imageStr];
    titleLabel.text = titleStr;
    bottomLine.hidden = isHiddenLine;
}

@end
