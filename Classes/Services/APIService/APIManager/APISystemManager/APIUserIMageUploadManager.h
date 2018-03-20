//
//  APIUserIMageUploadManager.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/31.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIUserIMageUploadManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString * imageStr;

@end
