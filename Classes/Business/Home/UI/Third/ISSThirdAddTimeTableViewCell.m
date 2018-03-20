//
//  ISSThirdAddTimeTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/3.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdAddTimeTableViewCell.h"

@interface ISSThirdAddTimeTableViewCell()
{
    UIImageView     * titleIV;
    UILabel         * titleLabel;
    UIImageView     * line;
    
}
@end

@implementation ISSThirdAddTimeTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorWhite;
        
        titleIV = [[UIImageView alloc]initForAutoLayout];
        titleIV.image = [UIImage imageNamed:@"addcolumn"];
        [self.contentView addSubview:titleIV];
        [self.contentView addConstraint:[titleIV constraintCenterYInContainer]];
        [self.contentView addConstraints:[titleIV constraintsLeftInContainer:16]];
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = ISSFont14;
        titleLabel.textColor = ISSColorDardGray6;
        titleLabel.text = @"巡查时间";
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraint:[titleLabel constraintCenterYInContainer]];
        [self.contentView addConstraints:[titleLabel constraintsLeft:12 FromView:titleIV]];
        
        line = [[UIImageView alloc]initForAutoLayout];
        line.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:line];
        [self.contentView addConstraint:[line constraintHeight:0.5]];
        [self.contentView addConstraint:[line constraintCenterYInContainer]];
        [self.contentView addConstraints:[line constraintsLeft:24 FromView:titleLabel]];
        [self.contentView addConstraints:[line constraintsRightInContainer:16]];
        
        _startTimeButton = [[ISSTimeButton alloc] init];
        _startTimeButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_startTimeButton setTitle:@"开始时间" forState:UIControlStateNormal];
        [self.contentView addSubview:_startTimeButton];
        [self.contentView addConstraints:[_startTimeButton constraintsRightInContainer:16]];
        [self.contentView addConstraints:[_startTimeButton constraintsTopInContainer:22]];
        
        _endTimeButton = [[ISSTimeButton alloc] init];
        _endTimeButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_endTimeButton setTitle:@"结束时间" forState:UIControlStateNormal];
        [self.contentView addSubview:_endTimeButton];
        [self.contentView addConstraints:[_endTimeButton constraintsRightInContainer:16]];
        [self.contentView addConstraints:[_endTimeButton constraintsBottomInContainer:21]];

    }
    return self;
}

@end
