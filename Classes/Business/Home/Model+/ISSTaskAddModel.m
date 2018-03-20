//
//  ISSTaskAddModel.m
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/8.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSTaskAddModel.h"

@implementation ISSTaskAddModel

- (instancetype)init {
    if (self = [super init]) {
        _positionArray = @[].mutableCopy;
        _peopleArray = @[].mutableCopy;
    }
    return self;
}

@end
