//
//  ISSENearestReformer.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSENearestReformer.h"
#import "ISSEnvironmentListModel.h"

#import "ISSENearestModel.h"

@implementation ISSENearestReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    NSArray * array = [NSArray arrayWithArray:data];
    NSMutableArray * eNearestArray = [NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        ISSEnvironmentListModel * eNearestModel = [[ISSEnvironmentListModel alloc] initWithDictionary:array[i]];
        [eNearestArray addObject:eNearestModel];
    }
    return eNearestArray;
}
@end
