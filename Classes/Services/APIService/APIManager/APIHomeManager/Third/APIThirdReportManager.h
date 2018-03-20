//
//  APIThirdReportManager.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/30.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIThirdReportManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString * patrolId;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * status;


@property (nonatomic, strong) NSString * patrolUser;
@property (nonatomic, strong) NSString * patrolDateStart;
@property (nonatomic, strong) NSString * patrolDateEnd;

@end
