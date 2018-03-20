

//
//  ISSThirdAddReportTimeTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdAddReportTimeTableViewCell.h"

@interface ISSThirdAddReportTimeTableViewCell()
{
    UIImageView     * titleIV;
    UILabel         * titleLabel;
    
    UIImageView     * line;
    
    
}

@end

@implementation ISSThirdAddReportTimeTableViewCell

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
        titleLabel.text = @"回访时间";
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraint:[titleLabel constraintCenterYInContainer]];
        [self.contentView addConstraints:[titleLabel constraintsLeft:12 FromView:titleIV]];
        
        _reportTimeButton = [[ISSTimeButton alloc] init];
        _reportTimeButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_reportTimeButton setTitle:@"填写时间" forState:UIControlStateNormal];
        [self.contentView addSubview:_reportTimeButton];
        [self.contentView addConstraints:[_reportTimeButton constraintsRightInContainer:16]];
        [self.contentView addConstraint:[_reportTimeButton constraintCenterYInContainer]];
        
        line = [[UIImageView alloc]initForAutoLayout];
        line.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:line];
        [self.contentView addConstraints:[line constraintsSize:CGSizeMake(kScreenWidth - 16, 0.5)]];
        [self.contentView addConstraints:[line constraintsBottomInContainer:0]];
        [self.contentView addConstraints:[line constraintsLeftInContainer:16]];
    }
    return self;
}

@end
