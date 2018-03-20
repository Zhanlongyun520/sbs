//
//  ISSEContaminantTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSEContaminantTableViewCell.h"

@interface ISSEContaminantTableViewCell()
{
    UIView          * cellBG;
    
    UILabel         * label1;
    UILabel         * labelValue1;
    UILabel         * label2;
    UILabel         * labelValue2;
    UILabel         * label3;
    UILabel         * labelValue3;
    UILabel         * label4;
    UILabel         * labelValue4;
    UILabel         * label5;
    UILabel         * labelValue5;
    UILabel         * label6;
    UILabel         * labelValue6;
}

@property(nonatomic , strong) NSArray       * titleArray1;
@property(nonatomic , strong) NSArray       * titleArray2;

@end

@implementation ISSEContaminantTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorViewBg;
        
        self.titleArray1 = @[@"PM10:",@"PM2.5:",@"CO2:"];
        self.titleArray2 = @[@"风速:",@"风向:",@"气压:",@"温度:",@"湿度:",@"雨量:"];

        cellBG = [[UIView alloc]initForAutoLayout];
        cellBG.backgroundColor = ISSColorWhite;
        [self.contentView addSubview:cellBG];
        [self.contentView addConstraints:[cellBG constraintsSize:CGSizeMake(kScreenWidth - 32, 80)]];
        [self.contentView addConstraints:[cellBG constraintsTopInContainer:0]];
        [self.contentView addConstraints:[cellBG constraintsLeftInContainer:16]];
        
        label1 = [[UILabel alloc]initForAutoLayout];
        label1.font = ISSFont12;
        label1.textColor = ISSColorDardGray2;
        [self.contentView addSubview:label1];
        [self.contentView addConstraints:[label1 constraintsTopInContainer:20]];
        [self.contentView addConstraints:[label1 constraintsLeftInContainer:38]];
        
        labelValue1 = [[UILabel alloc]initForAutoLayout];
        labelValue1.font = ISSFont12;
        labelValue1.textColor = ISSColorNavigationBar;
        [self.contentView addSubview:labelValue1];
        [self.contentView addConstraints:[labelValue1 constraintsTopInContainer:20]];
        [self.contentView addConstraints:[labelValue1 constraintsLeft:5 FromView:label1]];
        
        label2 = [[UILabel alloc]initForAutoLayout];
        label2.font = ISSFont12;
        label2.textColor = ISSColorDardGray2;
        [self.contentView addSubview:label2];
        [self.contentView addConstraints:[label2 constraintsTopInContainer:20]];
        [self.contentView addConstraints:[label2 constraintsLeft:24 FromView:labelValue1]];
        
        labelValue2 = [[UILabel alloc]initForAutoLayout];
        labelValue2.font = ISSFont12;
        labelValue2.textColor = ISSColorNavigationBar;
        [self.contentView addSubview:labelValue2];
        [self.contentView addConstraints:[labelValue2 constraintsTopInContainer:20]];
        [self.contentView addConstraints:[labelValue2 constraintsLeft:5 FromView:label2]];
        
        label3 = [[UILabel alloc]initForAutoLayout];
        label3.font = ISSFont12;
        label3.textColor = ISSColorDardGray2;
        [self.contentView addSubview:label3];
        [self.contentView addConstraints:[label3 constraintsTopInContainer:20]];
        [self.contentView addConstraints:[label3 constraintsLeft:28 FromView:labelValue2]];

        labelValue3 = [[UILabel alloc]initForAutoLayout];
        labelValue3.font = ISSFont12;
        labelValue3.textColor = ISSColorNavigationBar;
        [self.contentView addSubview:labelValue3];
        [self.contentView addConstraints:[labelValue3 constraintsTopInContainer:20]];
        [self.contentView addConstraints:[labelValue3 constraintsLeft:5 FromView:label3]];
        
        label4 = [[UILabel alloc]initForAutoLayout];
        label4.font = ISSFont12;
        label4.textColor = ISSColorDardGray2;
        [self.contentView addSubview:label4];
        [self.contentView addConstraints:[label4 constraintsTopInContainer:50]];
        [self.contentView addConstraints:[label4 constraintsLeftInContainer:38]];
        
        labelValue4 = [[UILabel alloc]initForAutoLayout];
        labelValue4.font = ISSFont12;
        labelValue4.textColor = ISSColorNavigationBar;
        [self.contentView addSubview:labelValue4];
        [self.contentView addConstraints:[labelValue4 constraintsTopInContainer:50]];
        [self.contentView addConstraints:[labelValue4 constraintsLeft:5 FromView:label4]];
        
        label5 = [[UILabel alloc]initForAutoLayout];
        label5.font = ISSFont12;
        label5.textColor = ISSColorDardGray2;
        [self.contentView addSubview:label5];
        [self.contentView addConstraints:[label5 constraintsTopInContainer:50]];
        [self.contentView addConstraints:[label5 constraintsLeft:24 FromView:labelValue4]];
        
        labelValue5 = [[UILabel alloc]initForAutoLayout];
        labelValue5.font = ISSFont12;
        labelValue5.textColor = ISSColorNavigationBar;
        [self.contentView addSubview:labelValue5];
        [self.contentView addConstraints:[labelValue5 constraintsTopInContainer:50]];
        [self.contentView addConstraints:[labelValue5 constraintsLeft:5 FromView:label5]];
        
        label6 = [[UILabel alloc]initForAutoLayout];
        label6.font = ISSFont12;
        label6.textColor = ISSColorDardGray2;
        [self.contentView addSubview:label6];
        [self.contentView addConstraints:[label6 constraintsTopInContainer:50]];
        [self.contentView addConstraints:[label6 constraintsLeft:24 FromView:labelValue5]];
        
        labelValue6 = [[UILabel alloc]initForAutoLayout];
        labelValue6.font = ISSFont12;
        labelValue6.textColor = ISSColorNavigationBar;
        [self.contentView addSubview:labelValue6];
        [self.contentView addConstraints:[labelValue6 constraintsTopInContainer:50]];
        [self.contentView addConstraints:[labelValue6 constraintsLeft:5 FromView:label6]];
    }
    return self;
}

- (void)conFigDataEnvironmentModel:(ISSEnvironmentListModel *)environmentListModel IsContamint:(BOOL)isContamint
{
    label4.hidden = labelValue4.hidden = label5.hidden = labelValue5.hidden = label6.hidden = labelValue6.hidden = isContamint;
    
    if (isContamint == YES) {
        label1.text = self.titleArray1[0];
        label2.text = self.titleArray1[1];
        label3.text = self.titleArray1[2];

        labelValue1.text = [NSString stringWithFormat:@"%.1f", environmentListModel.pm10.floatValue];
        labelValue2.text = [NSString stringWithFormat:@"%.1f", environmentListModel.pm25.floatValue];
        labelValue3.text = [NSString stringWithFormat:@"%.1f", environmentListModel.co2.floatValue];
    }else{
        label1.text = self.titleArray2[0];
        label2.text = self.titleArray2[1];
        label3.text = self.titleArray2[2];
        label4.text = self.titleArray2[3];
        label5.text = self.titleArray2[4];
        label6.text = self.titleArray2[5];
        
        labelValue1.text = [NSString stringWithFormat:@"%.1f", environmentListModel.windSpeed.floatValue];
        labelValue2.text = environmentListModel.windDirection ?: @"无";
        labelValue3.text = [NSString stringWithFormat:@"%.1f", environmentListModel.atmosphericPressure.floatValue];
        labelValue4.text = [NSString stringWithFormat:@"%.1f", environmentListModel.airTemperature.floatValue];
        labelValue5.text = [NSString stringWithFormat:@"%.1f", environmentListModel.airHumidity.floatValue];
        labelValue6.text = [NSString stringWithFormat:@"%.1f", environmentListModel.rainfall.floatValue];
    }
}
@end
