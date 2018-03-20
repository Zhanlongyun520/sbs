//
//  APIPlainPendListManager.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/6.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIPlainPendListManager : APIBaseManager <APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *endDate;

@end
