

//
//  ISSELineChartTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSELineChartTableViewCell.h"
#import "SmartBuildingSite-Bridging-Header.h"

@interface ISSELineChartTableViewCell()
{
    UIView         * cellBG;
    LineChartView  * lineChartView;
}

@end

@implementation ISSELineChartTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorViewBg;
        
        cellBG = [[UIView alloc]initForAutoLayout];
        cellBG.backgroundColor = ISSColorWhite;
        [self.contentView addSubview:cellBG];
        [self.contentView addConstraints:[cellBG constraintsSize:CGSizeMake(kScreenWidth - 32, 200)]];
        [self.contentView addConstraints:[cellBG constraintsTopInContainer:0]];
        [self.contentView addConstraints:[cellBG constraintsLeftInContainer:16]];
        
        lineChartView = [[LineChartView alloc]initWithFrame:CGRectMake(25, 10, kScreenWidth-50, 180)];
        lineChartView.dragEnabled = YES;//设置图表里能不能被拖动
        [lineChartView setScaleEnabled:YES];//设置图表能不能被放大
        lineChartView.descriptionText = @"";//隐藏描述文字
        lineChartView.noDataText = @"暂时数据";// 设置没有数据的显示内容
        lineChartView.legend.enabled = NO;//不显示图例说明
        lineChartView.rightAxis.enabled = NO;//不绘制右边轴的信息
//        lineChartView.xAxis.enabled = NO; //不绘制x轴
//        LineChartView.
        lineChartView.xAxis.drawGridLinesEnabled = NO;//不绘制网络线
        lineChartView.xAxis.granularity = 1;// 间隔为1
        lineChartView.xAxis.labelPosition = XAxisLabelPositionBottom;//设置x轴在下面显示，默认是在上面
        lineChartView.leftAxis.gridColor = [[UIColor grayColor]colorWithAlphaComponent:0.2];//分割线颜色


        [self.contentView addSubview:lineChartView];
    }
    return self;
}

- (void)conFigDataArray:(NSArray *)array accessory:(NSString *)acce {
    NSMutableArray *yVals = [NSMutableArray array];
    for (NSInteger i = 0; i < 24; i++) {
        
        __block double value = 0.0;
        [array enumerateObjectsUsingBlock:^(ISSEnvironmentListModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *time = [model.pushTime substringWithRange:NSMakeRange(11, 2)];
            if ([time integerValue] == i) {
                
                if ([acce isEqualToString:@"PM2.5"]) {
                    value = [model.pm25 doubleValue];
                }
                if ([acce isEqualToString:@"PM10"]) {
                    value = [model.pm10 doubleValue];
                }
                if ([acce isEqualToString:@"CO2"]) {
                    value = [model.co2 doubleValue];
                }
            }
        }];
        
        [yVals addObject:[[ChartDataEntry alloc]initWithX:i y:value]];
    }

    LineChartDataSet *set1 = nil;
    if (lineChartView.data.dataSetCount > 0) {
        set1 = (LineChartDataSet *)lineChartView.data.dataSets.firstObject;
        set1.values = yVals;
        
        [lineChartView.data notifyDataChanged];
        [lineChartView notifyDataSetChanged];
    } else {
        set1 = [[LineChartDataSet alloc]initWithValues:yVals label:acce];
        
        [set1 setColor:ISSColorKLine];
        [set1 setCircleColor:ISSColorKLine];
        set1.lineWidth = 1.0;
        set1.drawCircleHoleEnabled = NO;
        set1.valueFont = ISSFont0;
        set1.highlightEnabled = NO;
        set1.drawCircleHoleEnabled = YES;//设置空心点
        set1.circleRadius = 3.0;
        set1.circleHoleRadius = 2.0;
        LineChartData *data = [[LineChartData alloc] initWithDataSets:@[set1]];

        lineChartView.data = data;//设置数据
    }
    
}



- (LineChartData *)setData:(NSArray *)array
{
    LineChartData  * lineChartData;
    NSMutableArray *xVals = [[NSMutableArray alloc]initWithCapacity:array.count];
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count; i++)
    {
        ISSEnvironmentListModel * model = array[i];
        NSString * time = [model.pushTime substringWithRange:NSMakeRange(11, 2)];
        [xVals addObject:[NSString stringWithFormat:@"%@",time]];
        [yVals addObject:[[ChartDataEntry alloc]initWithX:i y:[model.pm10 doubleValue]]];
    }
    
    LineChartDataSet *set1 = nil;
    if (lineChartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)lineChartView.data.dataSets[0];
        [lineChartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc]initWithValues:yVals label:@"hfdha"];
        
        [set1 setColor:ISSColorKLine];
        [set1 setCircleColor:ISSColorKLine];
        set1.lineWidth = 1.0;
        set1.drawCircleHoleEnabled = NO;
        set1.valueFont = ISSFont0;
        set1.highlightEnabled = NO;
        set1.drawCircleHoleEnabled = YES;//设置空心点
        set1.circleRadius = 3.0;
        set1.circleHoleRadius = 2.0;
        lineChartData = [[LineChartData alloc]initWithDataSets:@[set1]];
    }
    
    return lineChartData;
}


- (LineChartData *)lineChartData{
    LineChartData  * lineChartData;
    NSMutableArray *xVals = [[NSMutableArray alloc]initWithCapacity:24];
    for (int i = 0; i < 24; i++)
    {
        [xVals addObject:[NSString stringWithFormat:@"%d",i+1]];
    }
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < 12; i++)
    {
        double mult = (12 + 1);
        double val = (double) (arc4random_uniform(mult)) + 3;
        [yVals addObject:[[ChartDataEntry alloc]initWithX:i y:val]];
    }
    
    LineChartDataSet *set1 = nil;
    if (lineChartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)lineChartView.data.dataSets[0];
        [lineChartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc]initWithValues:yVals label:nil];
        [set1 setColor:ISSColorKLine];
        [set1 setCircleColor:ISSColorKLine];
        set1.lineWidth = 1.0;
        set1.circleRadius = 3.0;
        set1.drawCircleHoleEnabled = NO;
        set1.valueFont = ISSFont9;
        set1.drawCircleHoleEnabled = YES;//设置空心点
        set1.circleHoleRadius = 1.5;
        lineChartData = [[LineChartData alloc]initWithDataSets:@[set1]];
    }
    
    return lineChartData;
}

- (void)setData1
{
    //设置最大显示值
    NSMutableArray *arr = [NSMutableArray array];
//    for (NSUInteger i = 0; i < self.environmentArray.count; i++) {
//        ISSEnvironmentListModel *model = self.environmentArray[i];
//        [arr addObject:@([model.pm10 doubleValue])];
//    }
    double max = [[arr valueForKeyPath:@"@max.doubleValue"] doubleValue];
    lineChartView.leftAxis.axisMaxValue = max; //设置最小显示值
    double min = [[arr valueForKeyPath:@"@min.doubleValue"] doubleValue];
    lineChartView.leftAxis.axisMinValue = min; // 设置区域显示，要显示7个数据，所以设置最大显示和最小显示
    [lineChartView setVisibleXRangeMaximum:6];// 最大显示
    [lineChartView setVisibleXRangeMinimum:6];// 最小显示 //设计师说要数据加载的时候前面留空白3个，拖到后面也是留空白3个，保证点都是在中间为准，所以又设置了留白数据
    lineChartView.xAxis.axisMinimum = -3; //最前面留空白3个区域
    //添加添加限制的线
    ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:100 label:@"初始数据"];
    limitLine.lineWidth = 1;
    limitLine.lineDashLengths = @[@(5.0),@(5.0)];
    limitLine.lineColor = [UIColor colorWithRed:1.000 green:0.671 blue:0.671 alpha:1.000];
    limitLine.labelPosition = ChartLimitLabelPositionLeftTop;//位置
    limitLine.valueTextColor = [UIColor colorWithWhite:0.502 alpha:1.000];//label文字颜色
    limitLine.valueFont = [UIFont systemFontOfSize:12];//label字体
    ChartLimitLine *limitLine2 = [[ChartLimitLine alloc] initWithLimit:200 label:@"目标"];
    limitLine2.lineWidth = 1;
    limitLine2.lineDashLengths = @[@(5.0),@(5.0)];
    limitLine2.lineColor = [UIColor colorWithRed:0.682 green:0.925 blue:1.000 alpha:1.000];
    limitLine2.labelPosition = ChartLimitLabelPositionLeftTop;//位置
    limitLine2.valueTextColor = [UIColor colorWithWhite:0.502 alpha:1.000];//label文字颜色
    limitLine2.valueFont = [UIFont systemFontOfSize:12];//label字体
    //把限制线添加到 chartview 里面
    [lineChartView.leftAxis addLimitLine:limitLine];
    [lineChartView.leftAxis addLimitLine:limitLine2]; //最后每次打开都自动高亮最后一个数据，所以需要设置
    [lineChartView highlightValueWithX:1 y:100 dataSetIndex:0 callDelegate:NO]; //由于每次打开都是显示在最前面的点，所以需要移动显示的位置
    [lineChartView moveViewToX:2];// 移动到那个点
    //最后显示出动画
    [lineChartView animateWithYAxisDuration:1];//动画
}

@end
