//
//  ISSBaseChatTableViewCell.m
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/13.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseChatTableViewCell.h"
#import "PGDatePicker.h"

@implementation IntAxisValueFormatter
- (NSString *)stringForValue:(double)value
                       entry:(ChartDataEntry *)entry
                dataSetIndex:(NSInteger)dataSetIndex
             viewPortHandler:(ChartViewPortHandler *)viewPortHandler {

    NSString *displayString = @((NSInteger)value).stringValue;
    if (value <= 10) {
        value = value * 1000000.0;
        
        NSString *originValue = @(value).stringValue;
        displayString = [originValue substringFromIndex:originValue.length-1];

        return displayString;
    }
    
    return displayString;
}
@end


@implementation FloatAxisValueFormatter
- (NSString *)stringForValue:(double)value
                       entry:(ChartDataEntry *)entry
                dataSetIndex:(NSInteger)dataSetIndex
             viewPortHandler:(ChartViewPortHandler *)viewPortHandler {
    
    NSString *displayString = [NSString stringWithFormat:@"%.1f",value];
    
    return displayString;
}
@end

@interface ISSBaseChatTableViewCell() <PGDatePickerDelegate>

@property (nonatomic, assign) NSInteger timeType;

@end

@implementation ISSBaseChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _timeButton = [[ISSTitleButton alloc] init];
        _timeButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_timeButton setTitle:@"2017年12月" forState:UIControlStateNormal];
        [_timeButton addTarget:self action:@selector(contentViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_timeButton];

        _choiceButton = [[ISSTitleButton alloc] init];
        _choiceButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_choiceButton setTitle:@"选择路段" forState:UIControlStateNormal];
        [_choiceButton addTarget:self action:@selector(contentViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_choiceButton];

        UIView *line = [[UIImageView alloc] initForAutoLayout];
        line.backgroundColor = TableSeparatorColor;
        [self.contentView addSubview:line];
        
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.left.equalTo(@10);
            make.right.equalTo(@(-10));
        }];
        
        [_timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.top.equalTo(@0);
            make.width.mas_lessThanOrEqualTo(140);
            make.height.equalTo(@35.5);
        }];
        
        [_choiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-16);
            make.top.equalTo(@0);
            make.height.equalTo(_timeButton);
            make.width.mas_lessThanOrEqualTo(120);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(_timeButton.mas_bottom);
            make.height.equalTo(@(0.5));
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

- (void)contentViewBtnAction:(UIButton *)btn {
    if ([btn isEqual:self.timeButton]) {
        [self showDatePicker];
    }
    
    if ([btn isEqual:self.choiceButton]) {
        if (self.btnAction) {
            self.btnAction(self, btn, nil);
        }
    }
}

- (void)fillChatDataSource:(id)data {
    //子类调用
}

#pragma mark 时间
- (void)showDatePicker {
    PGDatePicker *datePicker = [[PGDatePicker alloc] init];
    datePicker.delegate = self;
    [datePicker showWithShadeBackgroud];
    datePicker.datePickerType = PGPickerViewType3;
    datePicker.datePickerMode = self.timeType==1 ? PGDatePickerModeDate : PGDatePickerModeYearAndMonth;
    datePicker.maximumDate = [NSDate date];
    datePicker.titleLabel.text = @"请选择时间";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = self.timeType==1 ? @"yyyy年MM月dd日" : @"yyyy年MM月";
    NSDate *date = [formatter dateFromString:self.timeButton.currentTitle];
    
    [datePicker setDate:date];
}

#pragma PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:dateComponents];
    
    NSString *dateString = [self formatterBtnTitle:date type:_timeType];
    [self.timeButton setTitle:dateString forState:UIControlStateNormal];
    
    if (self.btnAction) {
        self.btnAction(self, self.timeButton, date);
    }
}

- (NSString *)formatterBtnTitle:(NSDate *)date type:(NSInteger)type {
    _timeType = type;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = (type == 1) ? @"yyyy年MM月dd日" : @"yyyy年MM月";
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}

@end
