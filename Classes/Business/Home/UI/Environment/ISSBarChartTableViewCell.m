//
//  ISSBarChartTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBarChartTableViewCell.h"
#import "SmartBuildingSite-Bridging-Header.h"
#import "Masonry.h"

@interface ISSBarChartTableViewCell()

@property (nonatomic, strong) HorizontalBarChartView *chartView;

@end

@implementation ISSBarChartTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //图表
        _chartView = [[HorizontalBarChartView alloc] init];
        _chartView.dragEnabled = NO;//设置图表里能不能被拖动
        [_chartView setScaleEnabled:NO];//设置图表能不能被放大
        _chartView.chartDescription.enabled = NO;
        _chartView.noDataText = @"暂无数据";// 设置没有数据的显示内容
        _chartView.drawBarShadowEnabled = YES;
        _chartView.autoScaleMinMaxEnabled = YES;
        [self.contentView addSubview:_chartView];
        _chartView.dragDecelerationEnabled = YES;

        [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@40);
            make.right.equalTo(@(-10));
            make.left.equalTo(@(10));
            make.bottom.equalTo(@0);
        }];

        ChartXAxis *xAxis = _chartView.xAxis;
        xAxis.labelFont = [UIFont systemFontOfSize:12.f];
        xAxis.drawAxisLineEnabled = NO;
        xAxis.drawGridLinesEnabled = NO;
        xAxis.labelPosition = XAxisLabelPositionBottomInside;
        xAxis.labelTextColor = [UIColor darkGrayColor];
        xAxis.centerAxisLabelsEnabled = YES;
        xAxis.xOffset = 0.0;
        xAxis.granularity = 1.0;
        xAxis.axisMinimum = 0.0;
        
        ChartYAxis *leftAxis = _chartView.leftAxis;
        leftAxis.axisMinimum = 0.0;
        leftAxis.enabled = NO;
        
        ChartYAxis *rightAxis = _chartView.rightAxis;
        rightAxis.drawZeroLineEnabled = YES;
        rightAxis.enabled = NO;
        
        //图标标注
        ChartLegend *l = _chartView.legend;
        l.enabled = NO;
    }
    return self;
}


- (void)fillChatDataSource:(NSArray *)datas {
    if (datas.count == 0) {
        return;
    }
    //按流量从多到少排序
    datas = [datas sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj2[@"data"] integerValue] > [obj1[@"data"] integerValue];
    }];
    
    NSMutableArray *yVals = [NSMutableArray array];
    NSMutableArray *names = [NSMutableArray array];
    
    [datas enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *name = dict[@"archName"];
        [names addObject:name];  //路段名称
        
        double xValue = (datas.count-1 - idx);
        double value = [dict[@"data"] doubleValue];
        
        BarChartDataEntry *data = [[BarChartDataEntry alloc] initWithX:xValue y:value];
        [yVals addObject:data];  //流量数据
    }];
    

    BarChartDataSet *set = nil;
    if (_chartView.data.dataSetCount > 0) {
        set = (BarChartDataSet *)_chartView.data.dataSets.firstObject;
        set.values = yVals;
        
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    } else {
        set = [[BarChartDataSet alloc] initWithValues:yVals label:nil];
        set.color = IndicatorColorBlue;
        set.valueTextColor = [UIColor darkGrayColor];
        set.valueFont = [UIFont systemFontOfSize:10.f];
        set.valueFormatter = [[FloatAxisValueFormatter alloc] init];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSet:set];
        data.barWidth = 0.10;
        
        _chartView.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:names];
        _chartView.xAxis.labelCount = names.count;
        _chartView.data = data;
    }
}

@end
