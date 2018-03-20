//
//  ISSReportVisitModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/24.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"

@interface ISSReportVisitModel : ISSBaseModel

@property (nonatomic, copy) NSString *user;
@property (nonatomic, assign) NSInteger userTag;

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, copy) NSString *startTimeDes;
@property (nonatomic, strong) NSDate *endTime;
@property (nonatomic, copy) NSString *endTimeDes;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger titleTag;

@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger contentTag;

@property (nonatomic, assign) BOOL needVisit;

@property (nonatomic, strong) NSDate *time;
@property (nonatomic, copy) NSString *timeDes;

@property (nonatomic, copy) NSString *status;

@end
