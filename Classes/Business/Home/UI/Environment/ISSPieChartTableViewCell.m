//
//  ISSPieChartTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/25.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPieChartTableViewCell.h"
#import "SmartBuildingSite-Bridging-Header.h"
//#import "PNChart.h"

@interface ISSPieChartTableViewCell()
{
    PieChartView * chartView;
}


@end


@implementation ISSPieChartTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
      
        chartView = [[PieChartView alloc] init];
        chartView.drawSlicesUnderHoleEnabled = YES;
        chartView.holeRadiusPercent = 0.7; //空心半径百分比
        chartView.drawSliceTextEnabled = YES;
        chartView.descriptionText = @"";//隐藏描述文字
        chartView.noDataText = @"暂无数据";
        chartView.drawCenterTextEnabled = YES;
        [chartView highlightValues:nil];
        [self.contentView addSubview:chartView];
        
        chartView.transparentCircleRadiusPercent = 0.35;
//        chartView.rotationEnabled = NO;
        
        chartView.legend.textColor = ISSColorDardGray6;//图例字体颜色
        chartView.legend.horizontalAlignment = ChartLegendHorizontalAlignmentCenter; //图例位置
        chartView.legend.font = ISSFont12;
        chartView.legend.form = ChartLegendFormDefault; //图例色块样式
        chartView.legend.formSize = 10; //图例色块大小

        
        [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@40);
            make.right.equalTo(@(-10));
            make.left.equalTo(@(10));
            make.bottom.equalTo(@-10);
        }];
    }
    return self;
}

- (void)fillChatDataSource:(NSArray *)datas {
    NSMutableArray *array = @[].mutableCopy;
    NSMutableArray *titleArray = @[].mutableCopy;

    [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[@"value"] floatValue] > 0) {
            [titleArray addObject:obj[@"name"] ?: @""];
            [array addObject:obj[@"value"] ?: @""];
        }
    }];

    if (titleArray.count > 0) {
        NSMutableArray * values = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < array.count; i++)
        {
            PieChartDataEntry * pieChartData = [[PieChartDataEntry alloc]initWithValue:[array[i] doubleValue] label:titleArray[i]];
            [values addObject:pieChartData];
        }
        
        PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:nil];
        
        // add a lot of colors
        NSArray *colors = @[[ISSUtilityMethod colorWithHexColorString:@"#3CD080"],
                            [ISSUtilityMethod colorWithHexColorString:@"#599FFF"],
                            [ISSUtilityMethod colorWithHexColorString:@"#FFCC00"],
                            [UIColor orangeColor],
                            [UIColor redColor],
                            [UIColor purpleColor]];
        dataSet.colors = colors;
        
        dataSet.valueLineColor = ISSColorDardGray6;
        dataSet.xValuePosition = PieChartValuePositionOutsideSlice;
        //        dataSet.
        dataSet.yValuePosition = PieChartValuePositionOutsideSlice;
        
        PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
        
        NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
        pFormatter.numberStyle = NSNumberFormatterPercentStyle;
        pFormatter.maximumFractionDigits = 1;
        pFormatter.multiplier = @1.f;
        pFormatter.positiveSuffix = @" 天";
        [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
        [data setValueFont:ISSFont12];
        //        data.valueFont
        [data setValueTextColor:ISSColorDardGray6];
        
        
        chartView.data = data;
    }
    

}

@end
