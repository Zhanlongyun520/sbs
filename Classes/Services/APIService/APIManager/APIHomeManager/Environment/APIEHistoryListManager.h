//
//  APIEHistoryListManager.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/26.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIEHistoryListManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>


@property (nonatomic, strong) NSArray * deviceIdsStr;
@property (nonatomic, strong) NSString * dataType;
//@property (nonatomic, strong) NSString * spaceTime;
@property (nonatomic, strong) NSString * page;
@property (nonatomic, strong) NSString * size;
@property (nonatomic, strong) NSString * sort;

@end
