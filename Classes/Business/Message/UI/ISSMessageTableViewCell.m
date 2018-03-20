
//
//  ISSMessageTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/27.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMessageTableViewCell.h"

@interface ISSMessageTableViewCell()
{
    UILabel         * detailLabel;
    UILabel         * badgeLabel;
    UILabel         * timeLabel;
    UIImageView     * litarrowIV;    
}
@end

@implementation ISSMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorWhite;
        
        self.logoIV = [[UIImageView alloc]initForAutoLayout];
        [self.contentView addSubview:_logoIV];
        [self.contentView addConstraints:[_logoIV constraintsSize:CGSizeMake(40, 40)]];
        [self.contentView addConstraint:[_logoIV constraintCenterYInContainer]];
        [self.contentView addConstraints:[_logoIV constraintsLeftInContainer:16]];
        
        badgeLabel = [[UILabel alloc]initForAutoLayout];
        badgeLabel.textColor = [UIColor whiteColor];
        badgeLabel.font = ISSFont9;
        badgeLabel.text = @"7";
        badgeLabel.textAlignment = NSTextAlignmentCenter;
        badgeLabel.backgroundColor = [UIColor redColor];
        badgeLabel.layer.cornerRadius = 15/2;
        badgeLabel.layer.masksToBounds = YES;
        badgeLabel.hidden = YES;
        [self.contentView addSubview:badgeLabel];
        [self.contentView addConstraints:[badgeLabel constraintsSize:CGSizeMake(15, 15)]];
        [self.contentView addConstraints:[badgeLabel constraintsTop:-47 FromView:_logoIV]];
        [self.contentView addConstraints:[badgeLabel constraintsLeft:-7 FromView:_logoIV]];
        
        self.nameLabel = [[UILabel alloc]initForAutoLayout];
        _nameLabel.font = ISSFont14;
        _nameLabel.textColor = ISSColorDardGray2;
        [self.contentView addSubview:_nameLabel];
        [self.contentView addConstraint:[_nameLabel constraintTopEqualToView:_logoIV]];
        [self.contentView addConstraints:[_nameLabel constraintsLeft:10 FromView:_logoIV]];
        
        litarrowIV = [[UIImageView alloc]initForAutoLayout];
        litarrowIV.image = [UIImage imageNamed:@"litarrow"];
        [self.contentView addSubview:litarrowIV];
        [self.contentView addConstraints:[litarrowIV constraintsSize:CGSizeMake(5.5, 9)]];
        [self.contentView addConstraint:[litarrowIV constraintBottomEqualToView:_logoIV]];
        [self.contentView addConstraints:[litarrowIV constraintsRightInContainer:16]];
        
        detailLabel = [[UILabel alloc]initForAutoLayout];
        detailLabel.font = ISSFont12;
        detailLabel.textColor = ISSColorDardGray9;
        detailLabel.text = @"13095设备损坏，请及时查看";
        [self.contentView addSubview:detailLabel];
        [self.contentView addConstraint:[detailLabel constraintBottomEqualToView:_logoIV]];
        [self.contentView addConstraints:[detailLabel constraintsLeft:10 FromView:_logoIV]];
        [self.contentView addConstraints:[detailLabel constraintsRight:10 FromView:litarrowIV]];

        
        timeLabel = [[UILabel alloc]initForAutoLayout];
        timeLabel.font = ISSFont12;
        timeLabel.textColor = ISSColorDardGrayC;
        timeLabel.text = @"11:21";
        [self.contentView addSubview:timeLabel];
        [self.contentView addConstraint:[timeLabel constraintTopEqualToView:_logoIV]];
        [self.contentView addConstraints:[timeLabel constraintsRightInContainer:16]];
        
        
    }
    return self;
}

- (void)conFigDataMessageModel:(ISSMessageModel *)messageModel
{
    detailLabel.text = messageModel.content;
    [self badgeLabel:badgeLabel badgeCount:[messageModel.unRead integerValue]];
    if (messageModel.updateTime != nil) {
        messageModel.updateTime = [messageModel.updateTime substringWithRange:NSMakeRange(0, 10)];
    }
    timeLabel.text = messageModel.updateTime;
}

- (void)badgeLabel:(UILabel *)label badgeCount:(NSInteger)count
{
    if (count > 0) {
        label.hidden = NO;
        if (count < 10) {
            label.size = CGSizeMake(15, 15);
        }else{
            label.size = CGSizeMake(22, 15);
        }
        label.text = [NSString stringWithFormat:@"%ld",(long)count];
    }else{
        label.hidden = YES;
    }
}

@end
