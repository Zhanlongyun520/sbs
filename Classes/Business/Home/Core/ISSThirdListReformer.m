//
//  ISSThirdListReformer.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/27.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdListReformer.h"
#import "ISSThirdListModel.h"

@implementation ISSThirdListReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    NSArray * dataArray = [NSArray arrayWithArray:data[@"content"]];
    NSMutableArray * thirdListArray = [NSMutableArray array];
    for (int i=0; i<dataArray.count; i++) {
        ISSThirdListModel * thirdListModel = [[ISSThirdListModel alloc] initWithDictionary:dataArray[i]];
        [thirdListArray addObject:thirdListModel];
    }
    [dic setObject:thirdListArray forKey:@"thirdListArray"];
    
    [dic setObject:ToString(data[@"totalPages"]) forKey:@"totalPages"];
    [dic setObject:ToString(data[@"last"]) forKey:@"last"];
    
    return dic;
}

@end
