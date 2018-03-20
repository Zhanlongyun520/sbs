//
//  APIPlainTaskListManager.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIPlainTaskListManager : APIBaseManager <APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) NSInteger page;

@end
