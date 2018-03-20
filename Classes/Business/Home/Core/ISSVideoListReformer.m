//
//  ISSVideoListReformer.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/10/20.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSVideoListReformer.h"
#import "ISSVideoModel.h"

@implementation ISSVideoListReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    NSArray * dataArray = [NSArray arrayWithArray:data[@"content"]];
    NSMutableArray *videoArray = [NSMutableArray array];
    for (int i=0; i<dataArray.count; i++) {
        ISSVideoModel * videoModel = [[ISSVideoModel alloc] initWithDictionary:dataArray[i]];
        [videoArray addObject:videoModel];
    }
    [dic setObject:videoArray forKey:@"videoArray"];
    
    [dic setObject:ToString(data[@"totalPages"]) forKey:@"totalPages"];
    [dic setObject:ToString(data[@"last"]) forKey:@"last"];

    return dic;
}

@end
