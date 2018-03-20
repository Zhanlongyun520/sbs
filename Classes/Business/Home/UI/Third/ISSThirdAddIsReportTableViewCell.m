//
//  ISSThirdAddIsReportTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdAddIsReportTableViewCell.h"

@interface ISSThirdAddIsReportTableViewCell()
{
    UIImageView     * titleIV;
    UILabel         * titleLabel;
    
    UIImageView     * line;
}

@end

@implementation ISSThirdAddIsReportTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorWhite;
        
        titleIV = [[UIImageView alloc]initForAutoLayout];
        titleIV.image = [UIImage imageNamed:@"editcolumn"];
        [self.contentView addSubview:titleIV];
        [self.contentView addConstraint:[titleIV constraintCenterYInContainer]];
        [self.contentView addConstraints:[titleIV constraintsLeftInContainer:16]];
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = ISSFont14;
        titleLabel.textColor = ISSColorDardGray6;
        titleLabel.text = @"是否回访";
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraint:[titleLabel constraintCenterYInContainer]];
        [self.contentView addConstraints:[titleLabel constraintsLeft:12 FromView:titleIV]];
        
        _rightButton = [[UIButton alloc] init];
        _rightButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_rightButton setTitle:@"否" forState:UIControlStateNormal];
        [_rightButton setTitleColor:ISSColorDardGray6 forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"ratio"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"ratioseltct"] forState:UIControlStateSelected];
        _rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _rightButton.titleLabel.font = ISSFont14;
        [self.contentView addSubview:_rightButton];
        [self.contentView addConstraints:[_rightButton constraintsRightInContainer:16]];
        [self.contentView addConstraint:[_rightButton constraintCenterYInContainer]];
        
        _leftButton = [[UIButton alloc] init];
        _leftButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_leftButton setTitle:@"是" forState:UIControlStateNormal];
        [_leftButton setTitleColor:ISSColorDardGray6 forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"ratio"] forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"ratioseltct"] forState:UIControlStateSelected];
        _leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _leftButton.titleLabel.font = ISSFont14;
        [self.contentView addSubview:_leftButton];
        [self.contentView addConstraints:[_leftButton constraintsRight:20 FromView:_rightButton]];
        [self.contentView addConstraint:[_leftButton constraintCenterYInContainer]];
        
        line = [[UIImageView alloc]initForAutoLayout];
        line.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:line];
        [self.contentView addConstraints:[line constraintsSize:CGSizeMake(kScreenWidth - 16, 0.5)]];
        [self.contentView addConstraints:[line constraintsBottomInContainer:0]];
        [self.contentView addConstraints:[line constraintsLeftInContainer:16]];
        
    }
    return self;
}

- (void)conFigDataTitle:(NSString *)titleStr LeftTitle:(BOOL)leftTitleStr HiddenText:(BOOL)isText
{
    
}

@end
