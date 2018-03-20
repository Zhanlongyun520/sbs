//
//  APIMessageListManager.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/26.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIMessageListManager : APIBaseManager <APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString * module;
@property (nonatomic, strong) NSString * page;
@property (nonatomic, strong) NSString * size;
@property (nonatomic, strong) NSString * sort;

@end
