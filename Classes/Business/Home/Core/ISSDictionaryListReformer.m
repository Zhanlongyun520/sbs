//
//  ISSDictionaryListReformer.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/29.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSDictionaryListReformer.h"
#import "ISSDictionaryListModel.h"

@implementation ISSDictionaryListReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{    
    NSArray * dataArray = [NSArray arrayWithArray:data[@"rawRecords"]];
    NSMutableArray * thirdListArray = [NSMutableArray array];
    for (int i=0; i<dataArray.count; i++) {
        ISSDictionaryListModel * thirdListModel = [[ISSDictionaryListModel alloc] initWithDictionary:dataArray[i]];
        [thirdListArray addObject:thirdListModel];
    }
    return thirdListArray;
}

@end
