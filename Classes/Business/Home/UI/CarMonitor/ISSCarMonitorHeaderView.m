//
//  ISSCarMonitorHeaderView.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSCarMonitorHeaderView.h"

@interface ISSCarMonitorHeaderView ()

@end

@implementation ISSCarMonitorHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        _leftIV = [[UIImageView alloc] initForAutoLayout];
        _leftIV.image = [ISSUtilityMethod createImageWithColor:ISSColorBlue size:CGSizeMake(5, 14)];
        _leftIV.layer.masksToBounds = YES;
        _leftIV.layer.cornerRadius = 2.5;
        [_leftIV sizeToFit];
        [self.contentView addSubview:_leftIV];
        [self.contentView addConstraints:[_leftIV constraintsTopInContainer:12]];
        [self.contentView addConstraints:[_leftIV constraintsLeftInContainer:15]];
        
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.font = ISSFont15;
        _titleLabel.textColor = ISSColorDardGray9;
        _titleLabel.text = @"区域月度综合排名";
        [self.contentView addSubview:_titleLabel];
        [self.contentView addConstraints:[_titleLabel constraintsTopInContainer:10]];
        [self.contentView addConstraints:[_titleLabel constraintsLeft:8 FromView:_leftIV]];
    }
    
    return self;
}

@end
