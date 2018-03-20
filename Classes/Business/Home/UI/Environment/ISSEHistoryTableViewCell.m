//
//  ISSEHistoryTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/20.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSEHistoryTableViewCell.h"

@interface ISSEHistoryTableViewCell()
{
    UIView           * cellBG;
    UIImageView      * leftIV;
    UILabel          * timeLabel;
    
    UILabel         * label1;
    UILabel         * labelValue1;
    UILabel         * label2;
    UILabel         * labelValue2;
    UILabel         * label3;
    UILabel         * labelValue3;
    
    UIImageView     * spaceLine;

}
@property(nonatomic , strong) NSArray       * titleArray1;

@end

@implementation ISSEHistoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorViewBg;
        
        self.titleArray1 = @[@"PM10:",@"PM2.5:",@"CO2:"];

        
        cellBG = [[UIView alloc]initForAutoLayout];
        cellBG.backgroundColor = ISSColorWhite;
        [self.contentView addSubview:cellBG];
        [self.contentView addConstraints:[cellBG constraintsSize:CGSizeMake(kScreenWidth - 32, 68)]];
        [self.contentView addConstraints:[cellBG constraintsTopInContainer:0]];
        [self.contentView addConstraints:[cellBG constraintsLeftInContainer:16]];
        
        leftIV = [[UIImageView alloc]initForAutoLayout];
        leftIV.backgroundColor = ISSColorDardGray9;
        leftIV.layer.masksToBounds = YES;
        leftIV.layer.cornerRadius = 3;
        [self.contentView addSubview:leftIV];
        [self.contentView addConstraints:[leftIV constraintsSize:CGSizeMake(6, 6)]];
        [self.contentView addConstraints:[leftIV constraintsTopInContainer:16]];
        [self.contentView addConstraints:[leftIV constraintsLeftInContainer:20]];
        
        timeLabel = [[UILabel alloc]initForAutoLayout];
        timeLabel.font = ISSFont12;
        timeLabel.textColor = ISSColorDardGray9;
        timeLabel.text = @"21:00:00 2017-08-09";
        [self.contentView addSubview:timeLabel];
        [self.contentView addConstraints:[timeLabel constraintsTopInContainer:16]];
        [self.contentView addConstraints:[timeLabel constraintsLeft:12 FromView:leftIV]];
        
        label1 = [[UILabel alloc]initForAutoLayout];
        label1.font = ISSFont12;
        label1.textColor = ISSColorDardGray2;
        label1.text = @"PM10:";
        [self.contentView addSubview:label1];
        [self.contentView addConstraints:[label1 constraintsTopInContainer:40]];
        [self.contentView addConstraints:[label1 constraintsLeftInContainer:38]];
        
        labelValue1 = [[UILabel alloc]initForAutoLayout];
        labelValue1.font = ISSFont12;
        labelValue1.textColor = ISSColorNavigationBar;
        labelValue1.text = @"320";
        [self.contentView addSubview:labelValue1];
        [self.contentView addConstraints:[labelValue1 constraintsTopInContainer:40]];
        [self.contentView addConstraints:[labelValue1 constraintsLeft:5 FromView:label1]];
        
        label2 = [[UILabel alloc]initForAutoLayout];
        label2.font = ISSFont12;
        label2.textColor = ISSColorDardGray2;
        label2.text = @"PM2.5:";
        [self.contentView addSubview:label2];
        [self.contentView addConstraints:[label2 constraintsTopInContainer:40]];
        [self.contentView addConstraints:[label2 constraintsLeft:24 FromView:labelValue1]];
        
        labelValue2 = [[UILabel alloc]initForAutoLayout];
        labelValue2.font = ISSFont12;
        labelValue2.textColor = ISSColorNavigationBar;
        labelValue2.text = @"32";
        [self.contentView addSubview:labelValue2];
        [self.contentView addConstraints:[labelValue2 constraintsTopInContainer:40]];
        [self.contentView addConstraints:[labelValue2 constraintsLeft:5 FromView:label2]];
        
        label3 = [[UILabel alloc]initForAutoLayout];
        label3.font = ISSFont12;
        label3.textColor = ISSColorDardGray2;
        label3.text = @"PM10:";
        [self.contentView addSubview:label3];
        [self.contentView addConstraints:[label3 constraintsTopInContainer:40]];
        [self.contentView addConstraints:[label3 constraintsLeft:24 FromView:labelValue2]];
        
        labelValue3 = [[UILabel alloc]initForAutoLayout];
        labelValue3.font = ISSFont12;
        labelValue3.textColor = ISSColorNavigationBar;
        labelValue3.text = @"320";
        [self.contentView addSubview:labelValue3];
        [self.contentView addConstraints:[labelValue3 constraintsTopInContainer:40]];
        [self.contentView addConstraints:[labelValue3 constraintsLeft:5 FromView:label3]];
        
        spaceLine = [[UIImageView alloc]initForAutoLayout];
        spaceLine.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:spaceLine];
        [self.contentView addConstraints:[spaceLine constraintsSize:CGSizeMake(kScreenWidth - 32 - 16, 0.5)]];
        [self.contentView addConstraints:[spaceLine constraintsLeftInContainer:32]];
        [self.contentView addConstraints:[spaceLine constraintsAssignBottom]];
        
        }
    return self;
}

- (void)conFigDataEnvironmentModel:(ISSEnvironmentListModel *)environmentListModel
{
    label1.text = self.titleArray1[0];
    label2.text = self.titleArray1[1];
    label3.text = self.titleArray1[2];

    labelValue1.text = [NSString stringWithFormat:@"%.2f", environmentListModel.pm10.floatValue];
    labelValue2.text = [NSString stringWithFormat:@"%.2f", environmentListModel.pm25.floatValue];
    labelValue3.text = [NSString stringWithFormat:@"%.2f", environmentListModel.co2.floatValue];
    timeLabel.text = environmentListModel.pushTime;
}

@end
