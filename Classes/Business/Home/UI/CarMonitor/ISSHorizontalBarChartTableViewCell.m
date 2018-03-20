//
//  ISSHorizontalBarChartTableViewCell.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSHorizontalBarChartTableViewCell.h"

@interface ISSHorizontalBarChartTableViewCell()
{
    UIView *_contentView;
}

@property (nonatomic, strong) HorizontalBarChartView *chartView;

@end

@implementation ISSHorizontalBarChartTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.choiceButton.hidden = YES;

        /*
        //图表
        _chartView = [[HorizontalBarChartView alloc] init];
        _chartView.dragEnabled = NO;//设置图表里能不能被拖动
        [_chartView setScaleEnabled:NO];//设置图表能不能被放大
        _chartView.chartDescription.enabled = NO;
        _chartView.noDataText = @"暂无数据";// 设置没有数据的显示内容
        _chartView.drawValueAboveBarEnabled = NO;
        _chartView.autoScaleMinMaxEnabled = YES;
        [self.contentView addSubview:_chartView];
//        _chartView.drawBarShadowEnabled = YES;
//        _chartView.highlightFullBarEnabled = YES;
        
        [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@40);
            make.right.equalTo(@(-10));
            make.left.equalTo(@(10));
            make.bottom.equalTo(@0);
        }];
        
        //主视图
        ChartXAxis *xAxis = _chartView.xAxis;
        xAxis.labelFont = [UIFont systemFontOfSize:12.f];
        xAxis.drawAxisLineEnabled = NO;
        xAxis.drawGridLinesEnabled = NO;
        xAxis.labelPosition = XAxisLabelPositionBottomInside;
        xAxis.labelTextColor = [UIColor darkGrayColor];
        xAxis.centerAxisLabelsEnabled = YES;
        xAxis.xOffset = 0.0;
//        xAxis.yOffset = 15.0;
//        xAxis.granularity = 1.05;
//        xAxis.spaceMax = 0.35;
        xAxis.wordWrapWidthPercent = 1.2;
        
        ChartYAxis *leftAxis = _chartView.leftAxis;
        leftAxis.spaceBottom = 0.3;
        leftAxis.axisMinimum = 0.0;
        leftAxis.enabled = NO;
        
        
        ChartYAxis *rightAxis = _chartView.rightAxis;
        rightAxis.drawZeroLineEnabled = YES;
        rightAxis.enabled = NO;
        
        //图标标注
        ChartLegend *l = _chartView.legend;
        l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
        l.verticalAlignment = ChartLegendVerticalAlignmentTop;
        l.orientation = ChartLegendOrientationHorizontal;
//        l.direction = ChartLegendDirectionRightToLeft;
        l.form = ChartLegendFormCircle;
        l.drawInside = NO;
        l.formSize = 8.0;
        l.xEntrySpace = 12.0;
        l.xOffset = 3;
        l.stackSpace = 10;
        
        _chartView.fitBars = YES;
         */
        
        UIImageView *data1ImageView;
        UIImageView *data2ImageView;
        UILabel *data1Label;
        UILabel *data2Label;
        
        for (NSInteger i = 0; i < 2; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:11];
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            
            UIImageView *icon = [[UIImageView alloc] init];
            icon.layer.cornerRadius = 4;
            icon.layer.masksToBounds = YES;
            [self.contentView addSubview:icon];
            
            switch (i) {
                case 0:
                    data2Label = label;
                    data2ImageView = icon;
                    break;
                    
                case 1:
                    data1Label = label;
                    data1ImageView = icon;
                    break;
                    
                default:
                    break;
            }
        }
        
        data2Label.text = @"黑名单";
        [data2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@12);
            make.top.equalTo(@45);
            make.right.equalTo(@-15);
        }];
        
        data2ImageView.backgroundColor = IndicatorColorOrange;
        data2ImageView.layer.cornerRadius = 4;
        data2ImageView.layer.masksToBounds = YES;
        [data2ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@8);
            make.height.equalTo(@8);
            make.centerY.equalTo(data2Label);
            make.right.equalTo(data2Label.mas_left).offset(-5);
        }];
        
        data1Label.text = @"白名单";
        [data1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(data2Label);
            make.right.equalTo(data2ImageView.mas_left).offset(-15);
        }];
        
        data1ImageView.backgroundColor = IndicatorColorBlue;
        data1ImageView.layer.cornerRadius = data2ImageView.layer.cornerRadius;
        data1ImageView.layer.masksToBounds = YES;
        [data1ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.centerY.equalTo(data2ImageView);
            make.right.equalTo(data1Label.mas_left).offset(-5);
        }];
        
        _contentView = [[UIView alloc] init];
        [self.contentView addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(@-30);
            make.bottom.equalTo(@-10);
            make.top.equalTo(data1Label.mas_bottom).offset(10);
        }];
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

- (void)fillChatDataSource:(NSArray *)datas {
    if (datas.count == 0) {
        return;
    }
    
    /*
    //由于是横向图从x轴开始，所以再次逆序
    NSMutableArray *yVals = [NSMutableArray array];
    NSMutableArray *names = [NSMutableArray array];
    
    [datas enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {

        NSDictionary *arch = dict[@"arch"];
        NSString *name = arch[@"name"];
        [names addObject:name];  //路段名称
        
        double xValue = (datas.count-1 - idx);
        
        double noAlarmMc = [dict[@"noAlarmMc"] doubleValue];
        double isAlarmMc = [dict[@"isAlarmMc"] doubleValue];
        
        //数据为个位数时候显示
        noAlarmMc = noAlarmMc <= 10 ? 9 + noAlarmMc/1000000.0 : noAlarmMc;
        isAlarmMc = isAlarmMc <= 10 ? 9 + isAlarmMc/1000000.0 : isAlarmMc;

        BarChartDataEntry *data = [[BarChartDataEntry alloc] initWithX:xValue yValues:@[@(isAlarmMc), @(noAlarmMc)]];
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
        set.stackLabels = @[@"黑名单", @"白名单"];
        set.colors = @[IndicatorColorOrange, IndicatorColorBlue];
        set.valueTextColor = [UIColor whiteColor];
        set.valueFont = [UIFont systemFontOfSize:10.f];
        set.valueFormatter = [[IntAxisValueFormatter alloc] init];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSet:set];
        data.barWidth = 0.38;
        
        _chartView.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:names];
        _chartView.data = data;
    }*/
    
    for (UIView *view in _contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSInteger maxWidth = CGFLOAT_MIN;
    for (NSDictionary *dic in datas) {
        NSInteger isAlarmMc = [[dic objectForKey:@"isAlarmMc"] integerValue];
        NSInteger noAlarmMc = [[dic objectForKey:@"noAlarmMc"] integerValue];
        NSInteger total = isAlarmMc + noAlarmMc;
        maxWidth = maxWidth > total ? maxWidth : total;
    }
    
    CGFloat rowHeight = 45;
    NSMutableArray *rowArray = @[].mutableCopy;
    for (NSDictionary *dic in datas) {
        NSInteger isAlarmMc = [[dic objectForKey:@"isAlarmMc"] integerValue];
        NSInteger noAlarmMc = [[dic objectForKey:@"noAlarmMc"] integerValue];
        
        UIView *row = [[UIView alloc] init];
        [_contentView addSubview:row];
        [row mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@(rowHeight));
        }];
        
        [rowArray addObject:row];
        
        // 名称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:12];
        nameLabel.text = [[dic objectForKey:@"arch"] objectForKey:@"name"];
        [row addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(@0);
            make.height.equalTo(@20);
        }];
        
        // isAlarmMc
        UILabel *isAlarmMcLabel = [[UILabel alloc] init];
        isAlarmMcLabel.font = [UIFont systemFontOfSize:10];
        isAlarmMcLabel.textColor = [UIColor whiteColor];
        isAlarmMcLabel.backgroundColor = IndicatorColorOrange;
        isAlarmMcLabel.text = [NSString stringWithFormat:@"%@", @(isAlarmMc)];
        [row addSubview:isAlarmMcLabel];
        [isAlarmMcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(nameLabel.mas_bottom);
            make.height.equalTo(@15);
            if (maxWidth == 0) {
                make.width.equalTo(@10);
            } else {
                make.width.equalTo(row).multipliedBy((CGFloat)isAlarmMc / maxWidth).offset(10);
            }
        }];
        
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.alignment = NSTextAlignmentRight;
        style.tailIndent = -2;
        
        NSMutableAttributedString *isAttString = [[NSMutableAttributedString alloc] initWithString:isAlarmMcLabel.text];
        [isAttString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, isAlarmMcLabel.text.length)];
        isAlarmMcLabel.attributedText = isAttString;
        
        // noAlarmMc
        UILabel *noAlarmMcLabel = [[UILabel alloc] init];
        noAlarmMcLabel.font = isAlarmMcLabel.font;
        noAlarmMcLabel.textColor = isAlarmMcLabel.textColor;
        noAlarmMcLabel.backgroundColor = IndicatorColorBlue;
        noAlarmMcLabel.text = [NSString stringWithFormat:@"%@", @(noAlarmMc)];
        [row addSubview:noAlarmMcLabel];
        [noAlarmMcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(isAlarmMcLabel);
            make.left.equalTo(isAlarmMcLabel.mas_right);
            if (maxWidth == 0) {
                make.width.equalTo(@10);
            } else {
                make.width.equalTo(row).multipliedBy((CGFloat)noAlarmMc / maxWidth).offset(10);
            }
        }];
        
        NSMutableAttributedString *noAttString = [[NSMutableAttributedString alloc] initWithString:noAlarmMcLabel.text];
        [noAttString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, noAlarmMcLabel.text.length)];
        noAlarmMcLabel.attributedText = noAttString;
    }
    [rowArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:rowHeight leadSpacing:CGFLOAT_MIN tailSpacing:CGFLOAT_MIN];
}

@end
