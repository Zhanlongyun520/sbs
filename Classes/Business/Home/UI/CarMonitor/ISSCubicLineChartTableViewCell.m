//
//  ISSCubicLineChartTableViewCell.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSCubicLineChartTableViewCell.h"
#import "SmartBuildingSite-Bridging-Header.h"

@interface ISSCubicLineChartTableViewCell()

@property (nonatomic, strong) LineChartView *chartView;

@end

@implementation ISSCubicLineChartTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //图表
        _chartView = [[LineChartView alloc] initWithFrame:CGRectMake(16, 44, kScreenWidth - 32, 200-44)];
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
        
        ChartYAxis *leftAxis = _chartView.leftAxis;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
        leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        leftAxis.labelPosition = XAxisLabelPositionBottomInside;
        
        //
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
        
        [_chartView animateWithYAxisDuration:1.0];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillChatDataSource:(NSDictionary *)dataDict {
    //总流量
    NSArray *countFlow = dataDict[@"countFlow"];
    if (countFlow.count == 0) {
        return;
    }
    _chartView.xAxis.axisMaxValue = countFlow.count;
    
    //所有黑名单数据
    NSArray *isAlarms = dataDict[@"isAlarms"];
    
    //相关数据配置
    NSArray *dataSource = @[@{@"title":@"白名单",
                              @"color":IndicatorColorBlue,
                              @"data":[NSMutableArray array]},
                            @{@"title":@"黑名单",
                              @"color":IndicatorColorOrange,
                              @"data":[NSMutableArray array]}];
    
    //在总流量中查找黑白名单
    [countFlow enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *flow = dict[@"flow"];  //总流量
        
        //如果有对应日期有黑名单，则添加流量值，否则为0
        __block NSNumber *flow1 = @(0);
        [isAlarms enumerateObjectsUsingBlock:^(NSDictionary *dict1, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([dict1[@"dataTimeDay"] isEqual:dict[@"dataTimeDay"]]) {
                flow1 = dict[@"flow"];
            }
        }];
        
        double noAlarmValue = flow.doubleValue - flow1.doubleValue; //白名单
        double isAlarmValue = flow1.doubleValue; //黑名单
        
        //填充数据
        NSMutableArray *firstData = dataSource.firstObject[@"data"];
        [firstData addObject:[[BarChartDataEntry alloc] initWithX:idx y:noAlarmValue]];
        
        NSMutableArray *lastData = dataSource.lastObject[@"data"];
        [lastData addObject:[[BarChartDataEntry alloc] initWithX:idx y:isAlarmValue]];
    }];
    
    
    //图表数据
    if (_chartView.data.dataSetCount > 0) {
        [dataSource enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *values = dict[@"data"];
            UIColor *color = dict[@"color"];
            NSString *title = dict[@"title"];
            
            LineChartDataSet *set = (LineChartDataSet *)_chartView.data.dataSets[idx];
            set.values = values;
            set.label = title;
            [set setColor:color];
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
            set.mode = LineChartModeCubicBezier;
            set.cubicIntensity = 0.2;
            set.drawCirclesEnabled = NO;
            set.lineWidth = 0.0;
            [set setColor:color];
            set.fillColor = color;
            set.fillAlpha = 1.f;
            set.drawFilledEnabled = YES;
            
            [dataSets addObject:set];
        }];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:9.f]];
        [data setDrawValues:NO];
        
        _chartView.data = data;
    }
}

@end
