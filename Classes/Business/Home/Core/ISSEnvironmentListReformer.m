//
//  ISSEnvironmentListReformer.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSEnvironmentListReformer.h"
#import "ISSEnvironmentListModel.h"

@implementation ISSEnvironmentListReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    NSArray * dataArray = [NSArray arrayWithArray:data[@"content"]];
    NSMutableArray *environmentArray = [NSMutableArray array];
    for (int i=0; i<dataArray.count; i++) {
        ISSEnvironmentListModel * environmentListModel = [[ISSEnvironmentListModel alloc] initWithDictionary:dataArray[i]];
        [environmentArray addObject:environmentListModel];
    }
    [dic setObject:environmentArray forKey:@"environmentArray"];
    
    [dic setObject:ToString(data[@"totalPages"]) forKey:@"totalPages"];
    [dic setObject:ToString(data[@"last"]) forKey:@"last"];
    
    return dic;
    
}
@end
