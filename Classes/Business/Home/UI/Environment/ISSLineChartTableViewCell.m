//
//  ISSLineChartTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/25.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSLineChartTableViewCell.h"
#import "SmartBuildingSite-Bridging-Header.h"

@interface ISSLineChartTableViewCell()
@property (nonatomic, strong) LineChartView *chartView;

@end

@implementation ISSLineChartTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorWhite;
        
        //图表
        _chartView = [[LineChartView alloc] init];
        _chartView.dragEnabled = NO;//设置图表里能不能被拖动
        [_chartView setScaleEnabled:NO];//设置图表能不能被放大
        _chartView.chartDescription.enabled = NO;
        _chartView.noDataText = @"暂无数据";// 设置没有数据的显示内容
        [self.contentView addSubview:_chartView];
        
        [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@40);
            make.bottom.right.equalTo(@(-10));
            make.left.equalTo(@(10));
        }];
        
        
        ChartXAxis *xAxis = _chartView.xAxis;
        xAxis.labelFont = [UIFont systemFontOfSize:10.f];
        xAxis.drawGridLinesEnabled = NO;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.granularity = 1;
        xAxis.axisMaxValue = 31.0;
        
        //
        ChartYAxis *leftAxis = _chartView.leftAxis;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
        leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        leftAxis.labelPosition = XAxisLabelPositionBottomInside;
        
        
        _chartView.rightAxis.enabled = NO;
        
        ChartLegend *l = _chartView.legend;
        l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
        l.verticalAlignment = ChartLegendVerticalAlignmentTop;
        l.orientation = ChartLegendOrientationHorizontal;
        l.drawInside = NO;
        l.form = ChartLegendFormCircle;
        l.formSize = 8.0;
        l.xEntrySpace = 12.0;
        l.xOffset = 3;

        
    }
    return self;
}

- (void)fillChatDataSource:(NSDictionary *)dict {
    //对比的数据
    if (dict.count == 0) {
        return;
    }
    
    NSString *title = @"", *title1 = @"";
    if (dict[@"archs"]) { //同期的路段对比
        NSArray *archs = dict[@"archs"];
        if (archs.count == 0) {
            return;
        }
        
        title = archs.firstObject;
        title1 = archs.lastObject;
        
        dict = dict[@"data"];
    } else { //同期的时间对比
        title = ((NSArray *)dict[@"currentMonth"]).firstObject [@"pushTimeDay"] ?: @"2017";
        if (title.length>4) {
            title = [title substringToIndex:4];
        }
        title1 = @([title integerValue]-1).stringValue;
    }

    
    //相关数据配置
    NSArray *dataSource = @[@{@"title":title,
                              @"color":ISSColorKLine,
                              @"data":[NSMutableArray array]},
                            @{@"title":title1,
                              @"color":IndicatorColorOrange,
                              @"data":[NSMutableArray array]}];
    
    NSMutableArray *firstData = dataSource.firstObject[@"data"];
    NSMutableArray *lastData = dataSource.lastObject[@"data"];
    
    
    NSArray *currentMonth = dict[@"currentMonth"];
    NSArray *beforeMonth = dict[@"beforeMonth"];
    
    for (NSInteger i=0; i<31; i++) {
        __block id aqi = 0;
        [currentMonth enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *dateTime = obj[@"pushTimeDay"];
            if (dateTime.length > 2) {
                dateTime = [dateTime substringFromIndex:dateTime.length-2];
            }
            
            if ([dateTime integerValue] == i) {
                aqi = obj[@"aqi"];
            }
        }];
        if (aqi) {
            ChartDataEntry *dataEntry = [[ChartDataEntry alloc] initWithX:i y:[aqi doubleValue]];
            [firstData addObject:dataEntry];
        }
        
        
        __block id beforeAqi = 0;
        [beforeMonth enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *dateTime = obj[@"pushTimeDay"];
            if (dateTime.length > 2) {
                dateTime = [dateTime substringFromIndex:dateTime.length-2];
            }
            
            if ([dateTime integerValue] == i) {
                beforeAqi = obj[@"aqi"];
            }
        }];
        if (beforeAqi) {
            ChartDataEntry *dataEntry1 = [[ChartDataEntry alloc] initWithX:i y:[beforeAqi doubleValue]];
            [lastData addObject:dataEntry1];
        }
    }
    
    if (_chartView.data.dataSetCount > 0) {
        [dataSource enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *values = dict[@"data"];
            UIColor *color = dict[@"color"];
            NSString *title = dict[@"title"];
            
            LineChartDataSet *set = (LineChartDataSet *)_chartView.data.dataSets[idx];
            set.values = values;
            set.label = title;
            [set setColor:color];
            [set setCircleColor:color];
            set.fillColor = color;
        }];
        
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    } else {
        NSMutableArray *dataSets = [NSMutableArray array];
        
        [dataSource enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *values = dict[@"data"];
            UIColor *color = dict[@"color"];
            NSString *title = dict[@"title"];
            
            LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:values label:title];
            [set setColor:color];
            [set setCircleColor:color];
            set.fillColor = color;
            set.drawValuesEnabled = NO;
            set.circleRadius = 3.0;
            set.circleHoleRadius = 2.0;
            set.circleHoleColor = [UIColor groupTableViewBackgroundColor];
            
            [dataSets addObject:set];
        }];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        
        _chartView.data = data;
    }

}


@end
