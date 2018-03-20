//
//  ISSPlainPendingWeekView.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainPendingWeekView.h"
#import "ISSPlainPendingWeekDay.h"

@interface ISSPlainPendingWeekView () {
    NSMutableArray *_labelArray;
}
@end

@implementation ISSPlainPendingWeekView

- (instancetype)init {
    if (self = [super init]) {
        UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showPreviousWeek)];
        left.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:left];
        
        UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showNextWeek)];
        right.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:right];
        
        self.backgroundColor = [UIColor whiteColor];
        
        _textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)showPreviousWeek {
    if (self.previousWeekBlock) {
        self.previousWeekBlock(_currentDate);
    }
}

- (void)showNextWeek {
    if (self.nextWeekBlock) {
        self.nextWeekBlock(_currentDate);
    }
}

- (void)setCurrentDate:(NSDate *)currentDate {
    _currentDate = currentDate;
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:_currentDate];
    NSInteger week = [comps weekday];
    
    week -= 1; // 周一是第一天
    NSMutableArray *dArray = @[].mutableCopy;
    for (NSInteger i = 0; i < 7; i++) {
        NSDate *d = [_currentDate dateByAddingTimeInterval:-(week - 1 - i) * 24 * 60 * 60];
        [dArray addObject:d];
        
        if (i == 0) {
            _startDate = d;
        } else if (i == 7 - 1) {
            _endDate = d;
        }
    }
    
    _labelArray = @[].mutableCopy;
    for (NSInteger i = 0; i < dArray.count; i++) {
        ISSPlainPendingWeekDay *view = [[ISSPlainPendingWeekDay alloc] init];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDate:)]];
        view.label.textColor = _textColor;
        view.date = [dArray objectAtIndex:i];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.height.equalTo(@35);
        }];
        [_labelArray addObject:view];
    }
    [_labelArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:CGFLOAT_MIN leadSpacing:CGFLOAT_MIN tailSpacing:CGFLOAT_MIN];
}

- (void)clickDate:(UITapGestureRecognizer *)tap {
    ISSPlainPendingWeekDay *clickView = (ISSPlainPendingWeekDay *)tap.view;
    for (ISSPlainPendingWeekDay *view in _labelArray) {
        view.label.layer.borderWidth = 0.0;
        view.label.backgroundColor = [UIColor clearColor];
        view.label.textColor = _textColor;
    }
    
    clickView.label.layer.borderWidth = 1;
    clickView.label.layer.borderColor = kPlanBlueColor.CGColor;
    clickView.label.textColor = kPlanBlueColor;
    clickView.label.backgroundColor = [UIColor whiteColor];
    
    if (self.clickDateBlock) {
        self.clickDateBlock(clickView.date);
    }
}

- (void)setWhiteBg:(BOOL)whiteBg {
    _whiteBg = whiteBg;
    
    if (whiteBg) {
        _textColor = [UIColor darkTextColor];
    } else {
        _textColor = [UIColor whiteColor];
    }
    for (ISSPlainPendingWeekDay *view in _labelArray) {
        view.label.textColor = _textColor;
    }
}

@end
