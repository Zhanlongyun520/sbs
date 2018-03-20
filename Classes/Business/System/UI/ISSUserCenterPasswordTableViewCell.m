//
//  ISSUserCenterPasswordTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/28.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSUserCenterPasswordTableViewCell.h"

@interface ISSUserCenterPasswordTableViewCell()
{
    UIImageView     * titleIV;
    UILabel         * titleLabel;
    UIView          * line;
}

@end

@implementation ISSUserCenterPasswordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        titleIV = [[UIImageView alloc]initForAutoLayout];
        titleIV.image = [UIImage imageNamed:@"editcolumn"];
        [self.contentView addSubview:titleIV];
        [self.contentView addConstraints:[titleIV constraintsSize:CGSizeMake(22, 22)]];
        [self.contentView addConstraint:[titleIV constraintCenterYInContainer]];
        [self.contentView addConstraints:[titleIV constraintsLeftInContainer:16]];
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = ISSFont14;
        titleLabel.textColor = ISSColorDardGray6;
        titleLabel.text = @"密码";
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraint:[titleLabel constraintCenterYInContainer]];
        [self.contentView addConstraints:[titleLabel constraintsLeft:12 FromView:titleIV]];
        
        _hiddenButton = [[UIButton alloc] init];
        _hiddenButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_hiddenButton setImage:[UIImage imageNamed:@"passwordhide"] forState:UIControlStateNormal];
        [_hiddenButton setImage:[UIImage imageNamed:@"passwordvisible"] forState:UIControlStateSelected];
        _hiddenButton.titleLabel.font = ISSFont14;
        [self.contentView addSubview:_hiddenButton];
        [self.contentView addConstraints:[_hiddenButton constraintsSize:CGSizeMake(15.5, 7.5)]];
        [self.contentView addConstraints:[_hiddenButton constraintsRightInContainer:16]];
        [self.contentView addConstraint:[_hiddenButton constraintCenterYInContainer]];
        
        self.textField = [[UITextField alloc]initForAutoLayout];
        _textField.font = ISSFont14;
        _textField.text = @"123456";
        _textField.secureTextEntry = YES;
        _textField.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_textField];
        [self.contentView addConstraint:[_textField constraintCenterYInContainer]];
        [self.contentView addConstraints:[_textField constraintsRight:10 FromView:_hiddenButton]];
        [self.contentView addConstraints:[_textField constraintsLeft:10 FromView:titleLabel]];
        
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
