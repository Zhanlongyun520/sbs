//
//  ISSHomeReformer.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSHomeReformer.h"
#import "ISSHomeModel.h"

@implementation ISSHomeReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    ISSHomeModel * homeModel = [[ISSHomeModel alloc]initWithDictionary:data];
    return homeModel;
}

@end
