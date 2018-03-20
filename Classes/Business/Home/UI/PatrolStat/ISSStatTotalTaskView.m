//
//  ISSStatTotalTaskView.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSStatTotalTaskView.h"
#import "JHChartHeader.h"
#import "ISSStatTotalTaskModel.h"

@interface ISSStatTotalTaskView ()
{
    JHRowChart *_rowChart;
}
@end

@implementation ISSStatTotalTaskView

- (instancetype)init {
    if (self = [super init]) {
        _titleLabel.text = @"巡查单位任务排名";
        _data1Label.text = @"已完成";
        _data2Label.text = @"未完成";
        _data1ImageView.backgroundColor = kPatrolStatBlueColor;
        _data2ImageView.backgroundColor = kPatrolStatGrayColor;
        _depButton.hidden = YES;
    }
    return self;
}

- (void)setDataList:(NSArray *)dataList {
    _dataList = dataList;
    
    [self showChart];
}

- (void)showChart {
    if (_rowChart) {
        [_rowChart removeFromSuperview];
        _rowChart = nil;
    }
    
    if (self.dataList.count == 0) {
        _emptyLabel.hidden = NO;
        return;
    }
    _emptyLabel.hidden = YES;
    
    NSMutableArray *valueArr = @[].mutableCopy;
    NSMutableArray *xShowInfoText = @[].mutableCopy;
    for (ISSStatTotalTaskModel *model in self.dataList) {
        NSArray *unitArray = @[@(model.off), @(model.unCount)];
        [valueArr addObject:unitArray];
        
        [xShowInfoText addObject:model.companyName ? : @"未知"];
    }
    
    JHRowChart *column = [[JHRowChart alloc] initWithFrame:_contentView.bounds];
    column.scrollView.scrollEnabled = NO;
    _rowChart = column;
    /*       This point represents the distance from the lower left corner of the origin.         */
    column.chartOrigin = CGPointMake(50, 20);
    /*        Create an array of data sources, each array is a module data. For example, the first array can represent the average score of a class of different subjects, the next array represents the average score of different subjects in another class        */
    column.valueArr = valueArr;
    column.rowBGcolorsArr=@[@[kPatrolStatBlueColor, kPatrolStatGrayColor]];//如果为复合型柱状图 即每个柱状图分段 需要传入如上颜色数组 达到同时指定复合型柱状图分段颜色的效果
    /*    The first column of the distance from the starting point     */
    column.backgroundColor = [UIColor clearColor];
    column.rowSpacing = 18;
    column.isShowYLine = YES;
    column.contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    /*        Column width         */
    column.rowHeight = 16;
    /*        Column backgroundColor         */
    column.bgVewBackgoundColor = [UIColor clearColor];
    /*        X, Y axis font color         */
    column.drawTextColorForX_Y = [UIColor darkGrayColor];
    /*        X, Y axis line color         */
    column.colorForXYLine = [UIColor darkGrayColor];
    /*    Each module of the color array, such as the A class of the language performance of the color is red, the color of the math achievement is green     */
    /*        Module prompt         */
    column.xShowInfoText = xShowInfoText;
    column.isShowLineChart = NO;
    
    /*       Start animation        */
    [column showAnimation];
    [_contentView addSubview:column];
}

@end
