//
//  APIPlainMonthManager.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIPlainMonthManager : APIBaseManager <APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, copy) NSString *taskTimeStart;
@property (nonatomic, copy) NSString *taskTimeEnd;
@property (nonatomic, copy) NSString *planId;
@property (nonatomic, copy) NSString *userId;

@end
