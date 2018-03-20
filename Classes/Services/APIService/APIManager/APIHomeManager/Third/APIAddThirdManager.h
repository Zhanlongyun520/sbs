//
//  APIAddThirdManager.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/30.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "APIBaseManager.h"

@interface APIAddThirdManager : APIBaseManager<APIManagerParamSourceDelegate,APIManagerVaildator,APIManager>

@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * company;
@property (nonatomic, strong) NSString * developmentCompany;
@property (nonatomic, strong) NSString * constructionCompany;
@property (nonatomic, strong) NSString * supervisionCompany;
@property (nonatomic, strong) NSString * patrolUser;
@property (nonatomic, strong) NSString * patrolDateStart;
@property (nonatomic, strong) NSString * patrolDateEnd;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * content;

@property (nonatomic, strong) NSString * isVisit;
@property (nonatomic, strong) NSString * visitDate;



@end
