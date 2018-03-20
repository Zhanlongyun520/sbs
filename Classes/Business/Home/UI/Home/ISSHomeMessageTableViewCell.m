//
//  ISSHomeMessageTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSHomeMessageTableViewCell.h"
#import "Masonry.h"

@interface ISSHomeMessageTableViewCell()
{
    UIView          * cellBG;
    UILabel         * nameLabel;
    UILabel         * badgeLabel;
    UILabel         * detailLabel;
    UILabel         * timeLabel;
    UIImageView     * tipIV;
}

@end

@implementation ISSHomeMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorViewBg;
        
        cellBG = [[UIView alloc]initForAutoLayout];
        cellBG.backgroundColor = ISSColorWhite;
        [self.contentView addSubview:cellBG];
        [self.contentView addConstraints:[cellBG constraintsBottomInContainer:10]];
        [self.contentView addConstraints:[cellBG constraintsLeftInContainer:16]];
        [self.contentView addConstraints:[cellBG constraintsRightInContainer:16]];

        timeLabel = [[UILabel alloc]initForAutoLayout];
        timeLabel.font = ISSFont12;
        timeLabel.textColor = ISSColorDardGrayC;
        timeLabel.text = @"20日\n10月";
        timeLabel.numberOfLines = 2;
        [self.contentView addSubview:timeLabel];
        [self.contentView addConstraints:[timeLabel constraintsLeftInContainer:32]];
        [self.contentView addConstraints:[timeLabel constraintsTopInContainer:16]];
        
        tipIV = [[UIImageView alloc]initForAutoLayout];
        [self.contentView addSubview:tipIV];
        [self.contentView addConstraints:[tipIV constraintsTop:10 FromView:timeLabel]];
        [self.contentView addConstraints:[tipIV constraintsLeftInContainer:28]];
        
        nameLabel = [[UILabel alloc]init];
        nameLabel.font = ISSFont14;
        nameLabel.textColor = ISSColorDardGray2;
        nameLabel.text = @"13095设备损坏需要维护";
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@12);
            make.left.equalTo(@70);
            make.right.equalTo(@-30);
            make.height.equalTo(@20);
        }];
        
        badgeLabel = [[UILabel alloc]initForAutoLayout];
        badgeLabel.backgroundColor = [UIColor redColor];
        badgeLabel.layer.cornerRadius = 5/2;
        badgeLabel.layer.masksToBounds = YES;
        badgeLabel.hidden = YES;
        [self.contentView addSubview:badgeLabel];
        [self.contentView addConstraints:[badgeLabel constraintsSize:CGSizeMake(5, 5)]];
        [self.contentView addConstraints:[badgeLabel constraintsTop:-18 FromView:nameLabel]];
        [self.contentView addConstraints:[badgeLabel constraintsLeft:1 FromView:nameLabel]];
        
        detailLabel = [[UILabel alloc]init];
        detailLabel.font = ISSFont12;
        detailLabel.textColor = ISSColorDardGray9;
        detailLabel.numberOfLines = 0;
        detailLabel.text = @"13095设备损坏，请及时查看。";
        [self.contentView addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLabel.mas_bottom);
            make.left.right.equalTo(nameLabel);
            make.bottom.equalTo(@-5);
        }];
        
        CGSize textSize = [self sizeWithText:detailLabel.text font:detailLabel.font maxWidth:kScreenWidth-64];
        [self.contentView addConstraints:[cellBG constraintsSize:CGSizeMake(kScreenWidth - 32, textSize.height + 60)]];
    }
    return self;
}

// 根据指定文本,字体和最大宽度计算尺寸
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}

- (void)conFigDataMessageModel:(ISSMessageModel *)messageModel
{
    timeLabel.text = @"20日\n10月";
    [self tipIV:messageModel.infoTypeParentCode];
    [self timeShow:messageModel.updateTime];
    nameLabel.text = [NSString stringWithFormat:@"%@",messageModel.title];
    detailLabel.text = [NSString stringWithFormat:@"%@",messageModel.content];
    
    CGSize textSize = [self sizeWithText:detailLabel.text font:detailLabel.font maxWidth:kScreenWidth-64];
    [self.contentView addConstraints:[cellBG constraintsSize:CGSizeMake(kScreenWidth - 32, textSize.height + 60)]];
    
    if ([messageModel.status isEqualToString:@"0"]) {
        badgeLabel.hidden = NO;
    }else{
        badgeLabel.hidden = YES;
    }
}

- (void)tipIV:(NSString *)infoTypeId
{
    if ([infoTypeId isEqualToString:@"1"]) {
        tipIV.image = [UIImage imageNamed:@"environment-tip"];
    } else if ([infoTypeId isEqualToString:@"2"]){
        tipIV.image = [UIImage imageNamed:@"video-tip"];
    } else if ([infoTypeId isEqualToString:@"3"]){
        tipIV.image = [UIImage imageNamed:@"third-tip"];
    } else if ([infoTypeId isEqualToString:@"4"]){
        tipIV.image = [UIImage imageNamed:@"car-tip"];
    } else if ([infoTypeId isEqualToString:@"7"]){
        tipIV.image = [UIImage imageNamed:@"task-tip"];
    } else if ([infoTypeId isEqualToString:@"110"]){
        tipIV.image = [UIImage imageNamed:@"plain-tip"];
    }
}

- (void)timeShow:(NSString *)timestring
{
    NSString * monthStr = [timestring substringWithRange:NSMakeRange(5, 2)];
    NSString * dayStr = [timestring substringWithRange:NSMakeRange(8, 2)];
    timeLabel.text = [NSString stringWithFormat:@"%@日\n%@月",dayStr,monthStr];
}

@end
