//
//  ISSStatMonthUserView.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSStatMonthUserView.h"
#import "JHChartHeader.h"

@interface ISSStatMonthUserView ()
{
    JHColumnChart *_columnChart;
}
@end

@implementation ISSStatMonthUserView

- (instancetype)init {
    if (self = [super init]) {
        _titleLabel.text = @"单位月度人员任务完成情况排名";
        _data1Label.text = @"已完成";
        _data2Label.text = @"未完成";
        _data1ImageView.backgroundColor = kPatrolStatBlueColor;
        _data2ImageView.backgroundColor = kPatrolStatGrayColor;
        _depButton.hidden = NO;
    }
    return self;
}

- (void)setDataList:(NSArray *)dataList {
    _dataList = dataList;
    
    [self showChart];
}

- (void)showChart {
    if (_columnChart) {
        [_columnChart removeFromSuperview];
        _columnChart = nil;
    }
    
    if (self.dataList.count == 0) {
        _emptyLabel.hidden = NO;
        return;
    }
    _emptyLabel.hidden = YES;
    
    NSMutableArray *valueArr = @[].mutableCopy;
    NSMutableArray *xShowInfoText = @[].mutableCopy;
    for (ISSStatMonthUserModel *model in self.dataList) {
        NSArray *unitArray = @[@[@(model.offCount)], @[@(model.unCount)]];
        [valueArr addObject:unitArray];
        
        [xShowInfoText addObject:model.user.name ? : @""];
    }
    
    JHColumnChart *column = [[JHColumnChart alloc] initWithFrame:_contentView.bounds];
    column.BGScrollView.scrollEnabled = NO;
    _columnChart = column;
    /*       This point represents the distance from the lower left corner of the origin.         */
    column.originSize = CGPointMake(20, 20);
    /*        Create an array of data sources, each array is a module data. For example, the first array can represent the average score of a class of different subjects, the next array represents the average score of different subjects in another class        */
    column.valueArr = valueArr;
    /*    The first column of the distance from the starting point     */
    column.drawFromOriginX = 0;
    column.backgroundColor = [UIColor clearColor];
    column.typeSpace = 18;
    column.isShowYLine = YES;
    column.contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    /*        Column width         */
    column.columnWidth = 16;
    /*        Column backgroundColor         */
    column.bgVewBackgoundColor = [UIColor clearColor];
    /*        X, Y axis font color         */
    column.drawTextColorForX_Y = [UIColor darkGrayColor];
    /*        X, Y axis line color         */
    column.colorForXYLine = [UIColor darkGrayColor];
    /*    Each module of the color array, such as the A class of the language performance of the color is red, the color of the math achievement is green     */
    column.columnBGcolorsArr = @[@[kPatrolStatBlueColor], @[kPatrolStatGrayColor]];
    /*        Module prompt         */
    column.xShowInfoText = xShowInfoText;
    
    /*       Start animation        */
    [column showAnimation];
    [_contentView addSubview:column];
}

@end
