//
//  ISSStatMonthTaskView.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSStatMonthTaskView.h"
#import "JHChartHeader.h"

@interface ISSStatMonthTaskView ()
{
    JHLineChart *_lineChart;
}
@end

@implementation ISSStatMonthTaskView

- (instancetype)init {
    if (self = [super init]) {
        _titleLabel.text = @"单位月度任务量";
        _data1Label.text = @"任务量";
        _data2Label.text = @"完成量";
        _data1ImageView.backgroundColor = kPatrolStatGrayColor;
        _data2ImageView.backgroundColor = kPatrolStatBlueColor;
        _depButton.hidden = NO;
    }
    return self;
}

- (void)setDataModel:(ISSStatMonthTaskGroupModel *)dataModel {
    _dataModel = dataModel;
    
    [self showChart];
}

- (void)showChart {
    if (_lineChart) {
        [_lineChart removeFromSuperview];
        _lineChart = nil;
    }
    
    if (_dataModel.all.count == 0) {
        _emptyLabel.hidden = NO;
        return;
    }
    _emptyLabel.hidden = YES;
    
    NSMutableArray *valueArr1 = @[].mutableCopy;
    NSMutableArray *valueArr2 = @[].mutableCopy;
    NSMutableArray *xLineDataArr = @[].mutableCopy;
    
    for (NSInteger i = 0; i < _dataModel.all.count; i++) {
        ISSStatMonthTaskModel *allModel = [_dataModel.all objectAtIndex:i];
        [valueArr1 addObject:@(allModel.count)];
        
        ISSStatMonthTaskModel *offModel = [_dataModel.off objectAtIndex:i];
        [valueArr2 addObject:@(offModel.count)];
        
        if (i % 2 == 0) {
            [xLineDataArr addObject:[[allModel.time componentsSeparatedByString:@"-"] lastObject]];
        } else {
            [xLineDataArr addObject:@""];
        }
    }
    
    
    /*     Create object        */
    JHLineChart *lineChart = [[JHLineChart alloc] initWithFrame:_contentView.bounds andLineChartType:JHChartLineValueNotForEveryX];
    _lineChart = lineChart;
    
    /* The scale value of the X axis can be passed into the NSString or NSNumber type and the data structure changes with the change of the line chart type. The details look at the document or other quadrant X axis data source sample.*/
    
    lineChart.xLineDataArr = xLineDataArr;
    lineChart.contentInsets = UIEdgeInsetsMake(0, 20, 20, 0);
    /* The different types of the broken line chart, according to the quadrant division, different quadrant correspond to different X axis scale data source and different value data source. */
    
    lineChart.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrant;
    
    // 数据源
    lineChart.valueArr = @[valueArr1, valueArr2];
    lineChart.showYLevelLine = YES;
    lineChart.showYLine = YES;
    lineChart.yLineDataArr = @[@[@20,@40,@60,@80],@[@10,@20,@30,@40]];
    lineChart.animationDuration = 1.0;
    lineChart.showDoubleYLevelLine = YES;
    lineChart.showValueLeadingLine = NO;
    lineChart.valueFontSize = 9.0;
    lineChart.backgroundColor = [UIColor whiteColor];
    lineChart.showPointDescription = NO;
    lineChart.showXDescVertical = YES;
    lineChart.xDescMaxWidth = 15;
    /* Line Chart colors */
    lineChart.valueLineColorArr = @[kPatrolStatGrayColor, kPatrolStatBlueColor];
    /* Colors for every line chart*/
    lineChart.pointColorArr = @[[UIColor clearColor], [UIColor clearColor]]; // 折点颜色
    /* color for XY axis */
    lineChart.xAndYLineColor = [UIColor darkGrayColor];
    /* XY axis scale color */
    lineChart.xAndYNumberColor = [UIColor darkGrayColor];
    /* Dotted line color of the coordinate point */
    lineChart.positionLineColorArr = lineChart.valueLineColorArr;
    /*        Set whether to fill the content, the default is False         */
    lineChart.contentFill = YES;
    /*        Set whether the curve path         */
    lineChart.pathCurve = YES; // 弧线或折线
    /*        Set fill color array         */
    lineChart.contentFillColorArr = @[[kPatrolStatGrayColor colorWithAlphaComponent:0.7], [kPatrolStatBlueColor colorWithAlphaComponent:0.8]];
    [_contentView addSubview:lineChart];
    /*       Start animation        */
    [lineChart showAnimation];
}

@end
