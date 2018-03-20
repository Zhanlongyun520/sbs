//
//  ISSDualLineChartTableViewCell.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSDualLineChartTableViewCell.h"
#import "SmartBuildingSite-Bridging-Header.h"

@interface ISSDualLineChartTableViewCell()

@property (nonatomic, strong) LineChartView *chartView;

@end

@implementation ISSDualLineChartTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

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
        xAxis.axisMaxValue = 23.0;
        
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillChatDataSource:(NSDictionary *)dict {
    //对比的数据
    NSArray *datas = dict[@"datas"];
    if (datas.count == 0) {
        return;
    }
    _chartView.xAxis.axisMaxValue = ((NSArray *)datas.firstObject).count;
    
    //对象名称和id
    NSArray *compareObjs = dict[@"compareObjs"];
    
    //相关数据配置
    NSArray *dataSource = @[@{@"title":compareObjs.firstObject[@"name"],
                              @"color":IndicatorColorBlue,
                              @"data":[NSMutableArray array]},
                            @{@"title":compareObjs.lastObject[@"name"],
                              @"color":IndicatorColorOrange,
                              @"data":[NSMutableArray array]}];

    
    NSMutableArray *firstData = dataSource.firstObject[@"data"];
    NSMutableArray *lastData = dataSource.lastObject[@"data"];
    
    [datas enumerateObjectsUsingBlock:^(NSArray *list, NSUInteger idx, BOOL * _Nonnull stop) {
        //填充数据
        [list enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx1, BOOL * _Nonnull stop) {
            NSNumber *flow = dict[@"flow"];
            
            ChartDataEntry *dataEntry = [[ChartDataEntry alloc] initWithX:idx1 y:flow.doubleValue];
            if (idx==0) {
                [firstData addObject:dataEntry];
            }
            if (idx==1) {
                [lastData addObject:dataEntry];
            }
            
        }];
    }];
    

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
