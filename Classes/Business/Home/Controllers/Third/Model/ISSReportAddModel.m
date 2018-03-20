//
//  ISSReportAddModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSReportAddModel.h"
#import "ISSLoginUserModel.h"

@implementation ISSReportAddModel

- (instancetype)init {
    if (self = [super init]) {
        _categoryIndex = -1;
        _addressTag = 7;
        _constructionTag = 1;
        _implementTag = 2;
        _superviseTag = 3;
        _usersTag = 4;
        _titleTag = 5;
        _contentTag = 6;
        _needVisit = YES;
        _dep = [ISSLoginUserModel shareInstance].loginUser.companyName;
        _categoryList = [ISSReportCategoryModel shareInstance].dataList;
        
//        _address = @"11111";
//        _users = @"22222";
//        _content = @"3333";
//        _title = @"4444";
//        _startTimeDes = @"2018-01-04 11:22";
//        _endTimeDes = @"2018-01-06 11:22";
//        _timeDes = @"2018-01-08 11:22";
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
