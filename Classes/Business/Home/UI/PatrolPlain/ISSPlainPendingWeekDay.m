//
//  ISSPlainPendingWeekDay.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSPlainPendingWeekDay.h"

@interface ISSPlainPendingWeekDay () {
    UILabel *_label;
}
@end

@implementation ISSPlainPendingWeekDay

- (instancetype)init {
    if (self = [super init]) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:15];
        _label.layer.cornerRadius = 15;
        _label.layer.masksToBounds = YES;
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@2.5);
            make.bottom.equalTo(@-2.5);
            make.width.equalTo(_label.mas_height);
            make.center.equalTo(self);
        }];
    }
    return self;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d";
    NSString *string = [formatter stringFromDate:date];
    
    _label.text = string;
}

@end
