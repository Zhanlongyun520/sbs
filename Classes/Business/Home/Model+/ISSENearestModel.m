
//
//  ISSENearestModel.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSENearestModel.h"

@implementation ISSENearestModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.pushTime = ToString(dic[@"pushTime"]);
    }
    return self;
}
@end
