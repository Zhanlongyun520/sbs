//
//  APIRecForMobileManager.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/23.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIRecForMobileManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic ,strong)NSString           * carLicence;
@property (nonatomic, strong) NSString          * recResult;

@end
