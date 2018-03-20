//
//  ISSMessageListTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/27.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMessageListTableViewCell.h"
#import "Masonry.h"

@interface ISSMessageListTableViewCell()
{
    UIView          * cellBG;
    UILabel         * nameLabel;
    UILabel         * detailLabel;
    UILabel         * timeLabel;
    UILabel         * badgeLabel;

}
@end


@implementation ISSMessageListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = ISSColorViewBg;
        
        cellBG = [[UIView alloc] init];
        cellBG.backgroundColor = ISSColorWhite;
        [self.contentView addSubview:cellBG];
        [cellBG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.top.equalTo(@10);
            make.bottom.equalTo(@0);
        }];
        
        timeLabel = [[UILabel alloc]init];
        timeLabel.font = ISSFont12;
        timeLabel.textColor = ISSColorDardGrayC;
        timeLabel.text = @"20日\n10月";
        timeLabel.numberOfLines = 2;
        [cellBG addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(@15);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
        
        nameLabel = [[UILabel alloc]init];
        nameLabel.font = ISSFont14;
        nameLabel.textColor = ISSColorDardGray2;
        nameLabel.text = @"13095设备损坏需要维护";
        [cellBG addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(timeLabel.mas_right);
            make.right.equalTo(@-10);
            make.height.equalTo(@40);
            make.top.equalTo(@0);
        }];
        
        badgeLabel = [[UILabel alloc]init];
        badgeLabel.backgroundColor = [UIColor redColor];
        badgeLabel.layer.cornerRadius = 5/2;
        badgeLabel.layer.masksToBounds = YES;
        badgeLabel.hidden = YES;
        [cellBG addSubview:badgeLabel];
        [badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@5);
            make.top.equalTo(nameLabel).offset(-18);
            make.left.equalTo(nameLabel);
        }];
        
        detailLabel = [[UILabel alloc]init];
        detailLabel.font = ISSFont12;
        detailLabel.textColor = ISSColorDardGray9;
        detailLabel.numberOfLines = 0;
        detailLabel.text = @"13095设备损坏，请及时查看。设备无法工作请及时查看。设备无法工作请及时查看。";
        [cellBG addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(nameLabel);
            make.top.equalTo(nameLabel.mas_bottom);
            make.bottom.equalTo(@-12);
        }];
    }
    return self;
}

- (void)conFigDataMessageModel:(ISSMessageModel *)messageModel
{
    [self timeShow:messageModel.updateTime];
    nameLabel.text = [NSString stringWithFormat:@"%@",messageModel.title];
    detailLabel.text = [NSString stringWithFormat:@"%@",messageModel.content];
    
    if ([messageModel.status isEqualToString:@"0"]) {
        badgeLabel.hidden = NO;
    }else{
        badgeLabel.hidden = YES;
    }
}

- (void)timeShow:(NSString *)timestring
{
    NSString * monthStr = [timestring substringWithRange:NSMakeRange(5, 2)];
    NSString * dayStr = [timestring substringWithRange:NSMakeRange(8, 2)];
    timeLabel.text = [NSString stringWithFormat:@"%@日\n%@月",dayStr,monthStr];
}

@end
