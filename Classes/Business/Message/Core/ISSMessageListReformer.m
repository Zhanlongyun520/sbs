
//
//  ISSMessageListReformer.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMessageListReformer.h"
#import "ISSMessageModel.h"

@implementation ISSMessageListReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];

    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *messageDic in data[@"content"]) {
        ISSMessageModel *messageModel = [[ISSMessageModel alloc] initWithDictionary:messageDic];
        [array addObject:messageModel];
    }
    [dic setObject:array forKey:@"messageArray"];
    
    [dic setObject:ToString(data[@"totalPages"]) forKey:@"totalPages"];
    [dic setObject:ToString(data[@"last"]) forKey:@"last"];
    
    return dic;
}

@end
