//
//  ISSEnvironmentTopTableViewCell.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSEnvironmentTopTableViewCell.h"
#import "PGDatePicker.h"

@interface ISSEnvironmentTopTableViewCell() <PGDatePickerDelegate>
{
    UIImageView      * leftIV;
    UILabel          * titleLabel;
    UIView           * whiteBG;
    UIImageView      * bottomLine;
    
}
@end

@implementation ISSEnvironmentTopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = ISSColorViewBg;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        leftIV = [[UIImageView alloc]initForAutoLayout];
        leftIV.image = [ISSUtilityMethod createImageWithColor:ISSColorBlue size:CGSizeMake(5, 15)];
        leftIV.layer.masksToBounds = YES;
        leftIV.layer.cornerRadius = 2.5;
        [leftIV sizeToFit];
        [self.contentView addSubview:leftIV];
        [self.contentView addConstraints:[leftIV constraintsTopInContainer:11]];
        [self.contentView addConstraints:[leftIV constraintsLeftInContainer:15]];
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = ISSFont15;
        titleLabel.textColor = ISSColorDardGray9;
        titleLabel.text = @"区域月度综合排名";
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraints:[titleLabel constraintsTopInContainer:10]];
        [self.contentView addConstraints:[titleLabel constraintsLeft:8 FromView:leftIV]];
        
        whiteBG = [[UIView alloc]initForAutoLayout];
        whiteBG.backgroundColor = ISSColorWhite;
        [self.contentView addSubview:whiteBG];
        [self.contentView addConstraints:[whiteBG constraintsSize:CGSizeMake(kScreenWidth, 40)]];
        [self.contentView addConstraints:[whiteBG constraintsAssignBottom]];
        
        _timeButton = [[ISSTitleButton alloc] init];
        _timeButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_timeButton setTitle:@"2017年10月" forState:UIControlStateNormal];
        [_timeButton addTarget:self action:@selector(contentViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_timeButton];
        [self.contentView addConstraints:[_timeButton constraintsLeftInContainer:20]];
        [self.contentView addConstraints:[_timeButton constraintsBottomInContainer:5]];
        
        _choiceButton = [[ISSTitleButton alloc] init];
        _choiceButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_choiceButton setTitle:@"AQI" forState:UIControlStateNormal];
        [_choiceButton addTarget:self action:@selector(contentViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_choiceButton];
        [self.contentView addConstraints:[_choiceButton constraintsRightInContainer:20]];
        [self.contentView addConstraints:[_choiceButton constraintsBottomInContainer:5]];
        
        bottomLine = [[UIImageView alloc]initForAutoLayout];
        bottomLine.backgroundColor = ISSColorSeparatorLine;
        [self.contentView addSubview:bottomLine];
        [self.contentView addConstraints:[bottomLine constraintsSize:CGSizeMake(kScreenWidth, 1)]];
        [self.contentView addConstraints:[bottomLine constraintsAssignBottom]];
    }
    return self;
}


- (void)contentViewBtnAction:(UIButton *)btn {
    if ([btn isEqual:self.timeButton]) {
        [self showDatePicker];
    }
    
    if ([btn isEqual:self.choiceButton]) {
        self.btnAction(self, btn, nil);
    }
}

#pragma mark 时间
- (void)showDatePicker {
    PGDatePicker *datePicker = [[PGDatePicker alloc] init];
    datePicker.delegate = self;
    [datePicker showWithShadeBackgroud];
    datePicker.datePickerType = PGPickerViewType3;
    datePicker.datePickerMode = PGDatePickerModeYearAndMonth;
    datePicker.maximumDate = [NSDate date];
    datePicker.titleLabel.text = @"请选择时间";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月";
    NSDate *date = [formatter dateFromString:self.timeButton.currentTitle];
    
    [datePicker setDate:date];
}

#pragma PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:dateComponents];
    
    NSString *dateString = [self formatterBtnTitle:date];
    [self.timeButton setTitle:dateString forState:UIControlStateNormal];
    
    if (self.btnAction) {
        self.btnAction(self, self.timeButton, date);
    }
}

- (NSString *)formatterBtnTitle:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月";
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}

@end
