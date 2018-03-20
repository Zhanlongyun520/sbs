//
//  APIDataComparisonManager.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/30.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIDataComparisonManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString * archId;
@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong) NSString * type;


@end
