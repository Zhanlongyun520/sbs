//
//  ISSStatTaskCompareView.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSStatTaskCompareView.h"
#import "JHChartHeader.h"
#import "ISSStatMonthTaskModel.h"

@interface ISSStatTaskCompareView ()
{
    JHLineChart *_lineChart;
}
@end

@implementation ISSStatTaskCompareView

- (instancetype)init {
    if (self = [super init]) {
        _titleLabel.text = @"单位月度任务量对比";
        _data1ImageView.backgroundColor = kPatrolStatLightBlueColor;
        _data2ImageView.backgroundColor = kPatrolStatOrangeColor;
        _depButton.hidden = NO;
        
        _departmentIndexArray = @[@(0), @(1)];
        
        _data2ImageView.layer.cornerRadius = 2;
        [_data2ImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@11);
        }];
        
        _data1ImageView.layer.cornerRadius = _data2ImageView.layer.cornerRadius;
    }
    return self;
}

- (void)showDepartmentPicker {
    if (self.showDepartmentArrayPickerBlock) {
        self.showDepartmentArrayPickerBlock(_departmentIndexArray, self.tag);
    }
}

- (void)setDataList:(NSArray *)dataList {
    _dataList = dataList;
   
    [self showChart];
}

- (void)showChart {
    if (_lineChart) {
        [_lineChart removeFromSuperview];
        _lineChart = nil;
    }
    
    if (_dataList.count != 2) {
        _emptyLabel.hidden = NO;
        return;
    }
    _emptyLabel.hidden = YES;
    
    NSMutableArray *valueArr1 = @[].mutableCopy;
    NSMutableArray *valueArr2 = @[].mutableCopy;
    NSMutableArray *xLineDataArr = @[].mutableCopy;
    
    NSArray *list1 = [_dataList objectAtIndex:0];
    [list1 enumerateObjectsUsingBlock:^(ISSStatMonthTaskModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [valueArr1 addObject:@(obj.count)];
        
        if (idx % 2 == 0) {
            [xLineDataArr addObject:[[obj.time componentsSeparatedByString:@"-"] lastObject]];
        } else {
            [xLineDataArr addObject:@""];
        }
        
        if (idx == 0) {
            _data1Label.text = obj.companyName;
        }
    }];
    
    NSArray *list2 = [_dataList objectAtIndex:1];
    [list2 enumerateObjectsUsingBlock:^(ISSStatMonthTaskModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [valueArr2 addObject:@(obj.count)];
        
        if (idx == 0) {
            _data2Label.text = obj.companyName;
        }
    }];
    
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
    lineChart.valueLineColorArr = @[kPatrolStatLightBlueColor, kPatrolStatOrangeColor];
    /* Colors for every line chart*/
    lineChart.pointColorArr = lineChart.valueLineColorArr; // 折点颜色
    /* color for XY axis */
    lineChart.xAndYLineColor = [UIColor darkGrayColor];
    /* XY axis scale color */
    lineChart.xAndYNumberColor = [UIColor darkGrayColor];
    /* Dotted line color of the coordinate point */
    lineChart.positionLineColorArr = lineChart.valueLineColorArr;
    /*        Set whether to fill the content, the default is False         */
    lineChart.contentFill = NO;
    /*        Set whether the curve path         */
    lineChart.pathCurve = NO; // 弧线或折线
    [_contentView addSubview:lineChart];
    /*       Start animation        */
    [lineChart showAnimation];
}

@end
