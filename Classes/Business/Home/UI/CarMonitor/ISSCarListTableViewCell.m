//
//  ISSCarListTableViewCell.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSCarListTableViewCell.h"

@interface ISSCarListTableViewCell()
{
    UIView          * cellBG;
    UIView          * cellBG1;
    UIImageView     * logoIV;
    UILabel         * nameLabel;
    UILabel         * numLabel;

    UILabel         * timeLabel;
    UILabel         * addressLabel;
    UIImageView     * litarrowIV;
    UIImageView     * bottomLine;
    UIImageView     * spaceLine;
}

@end

@implementation ISSCarListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorViewBg;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cellBG1 = [[UIView alloc]initForAutoLayout];
        cellBG1.backgroundColor = ISSColorViewBg1;
        [self.contentView addSubview:cellBG1];
        [self.contentView addConstraints:[cellBG1 constraintsSize:CGSizeMake(kScreenWidth - 32, 44)]];
        [self.contentView addConstraints:[cellBG1 constraintsTopInContainer:10]];
        [self.contentView addConstraints:[cellBG1 constraintsLeftInContainer:16]];
        
        cellBG = [[UIView alloc]initForAutoLayout];
        cellBG.backgroundColor = ISSColorWhite;
        [self.contentView addSubview:cellBG];
        [self.contentView addConstraints:[cellBG constraintsSize:CGSizeMake(kScreenWidth - 32, 48 + 44)]];
        [self.contentView addConstraints:[cellBG constraintsTop:0 FromView:cellBG1]];
        [self.contentView addConstraints:[cellBG constraintsLeftInContainer:16]];
        
        nameLabel = [[UILabel alloc]initForAutoLayout];
        nameLabel.font = ISSFont12;
        nameLabel.textColor = ISSColorDardGray9;
        nameLabel.text = @"车牌号:";
        [self.contentView addSubview:nameLabel];
        [self.contentView addConstraints:[nameLabel constraintsTopInContainer:26]];
        [self.contentView addConstraints:[nameLabel constraintsLeftInContainer:32]];
        
        numLabel = [[UILabel alloc]initForAutoLayout];
        numLabel.font = ISSFont14;
        numLabel.textColor = ISSColorDardGray2;
        [self.contentView addSubview:numLabel];
        [self.contentView addConstraints:[numLabel constraintsTopInContainer:24]];
        [self.contentView addConstraints:[numLabel constraintsLeft:1 FromView:nameLabel]];
        
        timeLabel = [[UILabel alloc]initForAutoLayout];
        timeLabel.font = ISSFont12;
        timeLabel.textColor = ISSColorDardGray9;
        timeLabel.text = @"更新时间：2017-08-09";
        [self.contentView addSubview:timeLabel];
        [self.contentView addConstraints:[timeLabel constraintsTopInContainer:26]];
        [self.contentView addConstraints:[timeLabel constraintsRightInContainer:32]];
        
        logoIV = [[UIImageView alloc]initForAutoLayout];
        logoIV.image = [UIImage imageNamed:@"site"];
        [self.contentView addSubview:logoIV];
        [self.contentView addConstraints:[logoIV constraintsTop:33 FromView:nameLabel]];
        [self.contentView addConstraints:[logoIV constraintsLeftInContainer:32]];
        
        addressLabel = [[UILabel alloc]initForAutoLayout];
        addressLabel.font = ISSFont14;
        addressLabel.textColor = ISSColorDardGray2;
        addressLabel.text = @"未知地点";
        [self.contentView addSubview:addressLabel];
        [self.contentView addConstraints:[addressLabel constraintsTop:31 FromView:nameLabel]];
        [self.contentView addConstraints:[addressLabel constraintsLeft:4 FromView:logoIV]];
        
        litarrowIV = [[UIImageView alloc]initForAutoLayout];
        litarrowIV.image = [UIImage imageNamed:@"litarrow"];
        [self.contentView addSubview:litarrowIV];
        [self.contentView addConstraints:[litarrowIV constraintsTop:34 FromView:nameLabel]];
        [self.contentView addConstraints:[litarrowIV constraintsRightInContainer:32]];
        

        UIImageView * line = [[UIImageView alloc]initForAutoLayout];
        line.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:line];
        [self.contentView addConstraints:[line constraintsSize:CGSizeMake(0.5, 10)]];
        [self.contentView addConstraints:[line constraintsTop:27.5 FromView:addressLabel]];
        
        spaceLine = [[UIImageView alloc]initForAutoLayout];
        spaceLine.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:spaceLine];
        [self.contentView addConstraints:[spaceLine constraintsSize:CGSizeMake(0.5, 14)]];
        [self.contentView addConstraint:[spaceLine constraintCenterXInContainer]];
        [self.contentView addConstraints:[spaceLine constraintsBottomInContainer:15]];
        
        //下部
        bottomLine = [[UIImageView alloc]initForAutoLayout];
        bottomLine.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:bottomLine];
        [self.contentView addConstraints:[bottomLine constraintsSize:CGSizeMake(kScreenWidth - 64, 0.5)]];
        [self.contentView addConstraints:[bottomLine constraintsBottomInContainer:44]];
        [self.contentView addConstraints:[bottomLine constraintsLeftInContainer:32]];
        
        
        spaceLine = [[UIImageView alloc]initForAutoLayout];
        spaceLine.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:spaceLine];
        [self.contentView addConstraints:[spaceLine constraintsSize:CGSizeMake(0.5, 14)]];
        [self.contentView addConstraint:[spaceLine constraintCenterXInContainer]];
        [self.contentView addConstraints:[spaceLine constraintsBottomInContainer:15]];
        
        _historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _historyButton.translatesAutoresizingMaskIntoConstraints = NO;
        _historyButton.titleLabel.font = ISSFont12;
        [_historyButton setTitle:@"历史轨迹" forState:UIControlStateNormal];
        [_historyButton setTitleColor:ISSColorNavigationBar forState:UIControlStateNormal];
        [_historyButton setImage:[UIImage imageNamed:@"history"]  forState:UIControlStateNormal];
        [_historyButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [_historyButton addTarget:self action:@selector(contentViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_historyButton];
        [self.contentView addConstraints:[_historyButton constraintsLeftInContainer:(kScreenWidth-32)/4]];
        [self.contentView addConstraints:[_historyButton constraintsTop:0 FromView:bottomLine]];
        [self.contentView addConstraint:[_historyButton constraintHeight:44]];
        
        _photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _photoButton.translatesAutoresizingMaskIntoConstraints = NO;
        _photoButton.titleLabel.font = ISSFont12;
        [_photoButton setTitle:@"拍照取证" forState:UIControlStateNormal];
        [_photoButton setTitleColor:ISSColorNavigationBar forState:UIControlStateNormal];
        [_photoButton setImage:[UIImage imageNamed:@"capture"]  forState:UIControlStateNormal];
        [_photoButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [_photoButton addTarget:self action:@selector(contentViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_photoButton];
        [self.contentView addConstraints:[_photoButton constraintsRightInContainer:(kScreenWidth-32)/4]];
        [self.contentView addConstraints:[_photoButton constraintsTop:0 FromView:bottomLine]];
        [self.contentView addConstraint:[_photoButton constraintHeight:44]];
        
    }
    return self;
}

- (void)conFigDataCarListModel:(ISSCarListModel *)model {
    numLabel.text = model.licence;

    NSString *dateString = model.dateTime;
    if (dateString.length > 10) {
        dateString = [dateString substringToIndex:10];
    }
    
    addressLabel.text = model.addr.length > 0 ? model.addr : @"未知地点";
    timeLabel.text = [NSString stringWithFormat:@"更新时间：%@", dateString];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)contentViewBtnAction:(UIButton *)btn {
    if (self.btnAction) {
        self.btnAction(self, btn);
    }
}

@end
