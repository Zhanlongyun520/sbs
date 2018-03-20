//
//  APITaskDetailManager.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APITaskDetailManager : APIBaseManager <APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, copy) NSString *taskId;

@end
