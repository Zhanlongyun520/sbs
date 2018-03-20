//
//  APIDataRankingManager.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/27.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIDataRankingManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString * archId;
@property (nonatomic, strong) NSString * time;

@end
