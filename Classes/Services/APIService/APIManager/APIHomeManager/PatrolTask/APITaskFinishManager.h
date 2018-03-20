//
//  APITaskFinishManager.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APITaskFinishManager : APIBaseManager <APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, copy) NSString *taskId;
@property (nonatomic, copy) NSString *taskName;

@end
