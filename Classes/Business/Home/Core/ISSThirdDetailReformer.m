//
//  ISSThirdDetailReformer.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/29.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSThirdDetailReformer.h"
#import "ISSThirdDetailModel.h"
@implementation ISSThirdDetailReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    ISSThirdDetailModel * model = [[ISSThirdDetailModel alloc]initWithDictionary:data];
    return model;
}
@end
