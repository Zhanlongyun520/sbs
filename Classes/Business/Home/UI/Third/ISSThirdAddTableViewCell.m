//
//  ISSThirdAddTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/3.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdAddTableViewCell.h"

@interface ISSThirdAddTableViewCell()<UITextFieldDelegate>
{
    UIImageView     * titleIV;
    UILabel         * titleLabel;
    UIImageView     * droparrowIV;

    UIImageView     * line;
    
    
}

@end

@implementation ISSThirdAddTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorWhite;
        
        titleIV = [[UIImageView alloc]initForAutoLayout];
        titleIV.image = [UIImage imageNamed:@"addcolumn"];
        [self.contentView addSubview:titleIV];
        [self.contentView addConstraints:[titleIV constraintsSize:CGSizeMake(22, 22)]];
        [self.contentView addConstraint:[titleIV constraintCenterYInContainer]];
        [self.contentView addConstraints:[titleIV constraintsLeftInContainer:16]];
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = ISSFont14;
        titleLabel.textColor = ISSColorDardGray6;
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraint:[titleLabel constraintCenterYInContainer]];
        [self.contentView addConstraints:[titleLabel constraintsLeft:12 FromView:titleIV]];
        
        self.textField = [[UITextField alloc]initForAutoLayout];
        _textField.font = ISSFont14;
        _textField.delegate = self;
        _textField.placeholder = @"请输入";
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_textField];
        [self.contentView addConstraint:[_textField constraintCenterYInContainer]];
        [self.contentView addConstraints:[_textField constraintsRightInContainer:12]];
        [self.contentView addConstraints:[_textField constraintsLeft:10 FromView:titleLabel]];

        
        droparrowIV = [[UIImageView alloc]initForAutoLayout];
        droparrowIV.image = [UIImage imageNamed:@"droparrow"];
        [self.contentView addSubview:droparrowIV];
        [self.contentView addConstraint:[droparrowIV constraintCenterYInContainer]];
        [self.contentView addConstraints:[droparrowIV constraintsRightInContainer:16]];
        
        self.textRightLabel = [[UILabel alloc]initForAutoLayout];
        _textRightLabel.font = ISSFont14;
        _textRightLabel.textColor = ISSColorDardGray9;
        _textRightLabel.text = @"请选择";
        _textRightLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_textRightLabel];
        [self.contentView addConstraint:[_textRightLabel constraintCenterYInContainer]];
        [self.contentView addConstraints:[_textRightLabel constraintsRight:5 FromView:droparrowIV]];
        
        line = [[UIImageView alloc]initForAutoLayout];
        line.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:line];
        [self.contentView addConstraints:[line constraintsSize:CGSizeMake(kScreenWidth - 16, 0.5)]];
        [self.contentView addConstraints:[line constraintsBottomInContainer:0]];
        [self.contentView addConstraints:[line constraintsLeftInContainer:16]];
        
        
    }
    return self;
}

- (void)conFigDataTitle:(NSString *)titleStr ISAddImage:(BOOL)isAddImage HiddenText:(BOOL)isText
{
    if (isAddImage == YES) {
        titleIV.image = [UIImage imageNamed:@"addcolumn"];
    }else{
        titleIV.image = [UIImage imageNamed:@"editcolumn"];
    }
    if (isText == YES) {
        self.textField.hidden = YES;
    }else{
        self.textRightLabel.hidden = YES;
        droparrowIV.hidden = YES;
    }
    titleLabel.text = titleStr;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

@end
