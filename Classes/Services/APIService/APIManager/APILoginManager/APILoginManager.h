//
//  APILoginManager.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/19.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APILoginManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) NSString * JPushID;              //极光ID

@end
