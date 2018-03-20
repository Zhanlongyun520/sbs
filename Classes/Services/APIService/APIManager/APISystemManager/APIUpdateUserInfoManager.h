//
//  APIUpdateUserInfoManager.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/26.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIUpdateUserInfoManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSDictionary *param;

@end
