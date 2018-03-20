//
//  APIVideoListManager.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/20.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIVideoListManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>


@property (nonatomic, strong) NSString * deviceType;
@property (nonatomic, strong) NSString * page;
@property (nonatomic, strong) NSString * size;
@property (nonatomic, strong) NSString * sort;

@end
