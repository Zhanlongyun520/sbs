//
//  ISSESpaceTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSESpaceTableViewCell.h"

@interface ISSESpaceTableViewCell()
{
    UIImageView      * leftIV;
    UILabel          * titleLabel;
    UIView           * whiteBG;
    UIImageView      * bottomLine;
    
}
@end

@implementation ISSESpaceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorViewBg;
        
        leftIV = [[UIImageView alloc]initForAutoLayout];
        leftIV.image = [UIImage imageNamed:@"home-tip"];
        [self.contentView addSubview:leftIV];
        [self.contentView addConstraints:[leftIV constraintsBottomInContainer:12]];
        [self.contentView addConstraints:[leftIV constraintsLeftInContainer:16]];
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = ISSFont12;
        titleLabel.textColor = ISSColorDardGray6;
        titleLabel.text = @"污染物数据";
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraints:[titleLabel constraintsBottomInContainer:11]];
        [self.contentView addConstraints:[titleLabel constraintsLeft:8 FromView:leftIV]];
        
        _choiceButton = [[ISSTitleButton alloc] init];
        _choiceButton.translatesAutoresizingMaskIntoConstraints = NO;
        _choiceButton.titleLabel.font = ISSFont13;
        _choiceButton.hidden = YES;
        [self.contentView addSubview:_choiceButton];
        [self.contentView addConstraints:[_choiceButton constraintsRightInContainer:20]];
        [self.contentView addConstraints:[_choiceButton constraintsBottomInContainer:12]];
    }
    return self;
}

- (void)conFigDataTitle:(NSString *)title ButtonHidden:(BOOL)isHidden ButtonTitle:(NSString *)buttonTitle
{
    titleLabel.text = title;
    _choiceButton.hidden = isHidden;
    [_choiceButton setTitle:buttonTitle forState:UIControlStateNormal];
}

@end
