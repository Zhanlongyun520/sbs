//
//  ISSReportVisitModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportVisitModel.h"

@implementation ISSReportVisitModel

- (instancetype)init {
    if (self = [super init]) {
        _userTag = 1;
        _titleTag = 2;
        _contentTag = 3;
        _needVisit = YES;
    }
    return self;
}

- (void)setStartTime:(NSDate *)startTime {
    _startTime = startTime;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    _startTimeDes = [formatter stringFromDate:startTime];
}

- (void)setEndTime:(NSDate *)endTime {
    _endTime = endTime;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    _endTimeDes = [formatter stringFromDate:endTime];
}

- (void)setTime:(NSDate *)time {
    _time = time;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    _timeDes = [formatter stringFromDate:time];
}

@end
