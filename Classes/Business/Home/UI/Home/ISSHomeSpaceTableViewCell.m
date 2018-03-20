//
//  ISSHomeSpaceTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/1.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSHomeSpaceTableViewCell.h"

@implementation ISSHomeSpaceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorViewBg;
        
        UIImageView * tipIV = [[UIImageView alloc]initForAutoLayout];
        tipIV.image = [UIImage imageNamed:@"home-tip"];
        [self.contentView addSubview:tipIV];
        [self.contentView addConstraints:[tipIV constraintsBottomInContainer:12]];
        [self.contentView addConstraints:[tipIV constraintsLeftInContainer:16]];
        
        UILabel * tipLabel = [[UILabel alloc]initForAutoLayout];
        tipLabel.font = ISSFont12;
        tipLabel.textColor = ISSColorDardGray9;
        tipLabel.text = @"即时消息";
        [self.contentView addSubview:tipLabel];
        [self.contentView addConstraints:[tipLabel constraintsBottomInContainer:11]];
        [self.contentView addConstraints:[tipLabel constraintsLeft:6 FromView:tipIV]];
    }
    return self;
}

@end
