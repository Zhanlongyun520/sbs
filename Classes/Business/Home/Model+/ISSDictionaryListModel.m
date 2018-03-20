//
//  ISSDictionaryListModel.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/29.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSDictionaryListModel.h"

@implementation ISSDictionaryListModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.code = ToString(dic[@"code"]);
        self.content = ToString(dic[@"content"]);
        self.dictionaryID = ToString(dic[@"id"]);
        self.value = ToString(dic[@"value"]);
    }
    return self;
}

@end
