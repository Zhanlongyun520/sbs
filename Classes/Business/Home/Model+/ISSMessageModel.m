//
//  ISSMessageModel.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/13.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMessageModel.h"

@implementation ISSMessageModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.title = ToString(dic[@"title"]);
        self.content = ToString(dic[@"content"]);
        self.updateTime = ToString(dic[@"updateTime"]);
        self.status = ToString(dic[@"status"]);
        NSDictionary * infoType = dic[@"infoType"];
        self.searchCode = ToString(infoType[@"searchCode"]);
        self.infoTypeParentCode = ToString(infoType[@"infoTypeParentCode"]);


    }
    return self;
}

@end
