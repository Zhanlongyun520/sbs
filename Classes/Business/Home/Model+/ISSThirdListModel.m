//
//  ISSThirdListModel.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/27.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdListModel.h"

@implementation ISSThirdListModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.thirdID = ToString(dic[@"id"]);
        self.address = ToString(dic[@"address"]);
        self.datetime = ToString(dic[@"date"]);
        self.company = ToString(dic[@"company"]);
        self.category = ToString(dic[@"category"]);

        NSDictionary * creatorDic = dic[@"creator"];
        self.account = ToString(creatorDic[@"account"]);

    }
    return self;
}

@end
