//
//  APIUnRecListManager.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/22.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIUnRecListManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic ,strong )NSString          * licence;
@property (nonatomic, strong) NSString * page;
@property (nonatomic, strong) NSString * size;
@property (nonatomic, strong) NSString * sort;
@end
