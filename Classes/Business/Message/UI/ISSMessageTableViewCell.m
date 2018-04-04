
//
//  ISSMessageTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/27.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMessageTableViewCell.h"
#import "Masonry.h"
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
        badgeLabel.adjustsFontSizeToFitWidth = YES;
        badgeLabel.layer.masksToBounds = YES;
        badgeLabel.hidden = YES;
        [self.contentView addSubview:badgeLabel];
        badgeLabel.layer.cornerRadius = 15/2;

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
        if (count < 100) {
            [self.contentView addConstraints:[label constraintsSize:CGSizeMake(15, 15)]];
            [self.contentView addConstraints:[badgeLabel constraintsLeft:-7 FromView:_logoIV]];
        }
        else{
           [self.contentView addConstraints:[label constraintsSize:CGSizeMake(30, 15)]];
        [self.contentView addConstraints:[badgeLabel constraintsLeft:-15 FromView:_logoIV]];
        }
        
        label.text = [NSString stringWithFormat:@"%ld",(long)count];
    }else{
        label.hidden = YES;
    }
    
   [self.contentView addConstraints:[badgeLabel constraintsTop:-47 FromView:_logoIV]];
}

@end
