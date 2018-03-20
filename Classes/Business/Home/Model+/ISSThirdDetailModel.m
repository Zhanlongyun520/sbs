//
//  ISSThirdDetailModel.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/12/4.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdDetailModel.h"
#import "ISSReportModel.h"

@implementation ISSThirdDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.address = ToString(dic[@"address"]);
        self.company = ToString(dic[@"company"]);
        self.thirdID = ToString(dic[@"id"]);
        self.constructionCompany = ToString(dic[@"constructionCompany"]);
        self.developmentCompany = ToString(dic[@"developmentCompany"]);
        self.supervisionCompany = ToString(dic[@"supervisionCompany"]);
        self.category = ToString(dic[@"category"]);
        self.date = ToString(dic[@"date"]);
        self.status = ToString(dic[@"status"]);
        self.needVisit = ToString(dic[@"needVisit"]);
        self.visitDate = ToString(dic[@"visitDate"]);

        self.reportsArray = [NSMutableArray array];
        for (NSDictionary * reportDic in dic[@"reports"]) {
            ISSReportModel * model = [[ISSReportModel alloc]initWithDictionary:reportDic];
            [self.reportsArray addObject:model];
        }
    }
    return self;
}

@end
