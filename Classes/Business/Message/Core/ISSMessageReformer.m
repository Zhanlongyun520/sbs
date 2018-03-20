
//
//  ISSMessageReformer.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/15.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSMessageReformer.h"
#import "ISSMessageModel.h"

@implementation ISSMessageReformer

- (id)manager:(APIBaseManager *)manager reformData:(id)data
{
    NSMutableArray * dataArray = [NSMutableArray array];
    
    NSDictionary * videoDic = [[NSDictionary alloc]initWithDictionary:data[@"video"]];
    NSArray * videoArray = videoDic[@"content"];
    ISSMessageModel *videoModel;
    if (videoArray.count != 0) {
        videoModel = [[ISSMessageModel alloc] initWithDictionary:videoArray[0]];
    }else{
        videoModel = [[ISSMessageModel alloc] init];
    }
    videoModel.unRead = ToString(data[@"unreadVideos"]);
    [dataArray addObject:videoModel];
    
    
    NSDictionary * environmentDic = [[NSDictionary alloc]initWithDictionary:data[@"environment"]];
    NSArray * environmentArray = environmentDic[@"content"];
    ISSMessageModel * environmentModel;
    if (environmentArray.count != 0) {
        environmentModel = [[ISSMessageModel alloc] initWithDictionary:environmentArray[0]];
    }else{
        environmentModel = [[ISSMessageModel alloc] init];
    }
    environmentModel.unRead = ToString(data[@"unreadEnvironment"]);
    [dataArray addObject:environmentModel];
    
    
    NSDictionary * patrolDic = [[NSDictionary alloc]initWithDictionary:data[@"patrol"]];
    NSArray * patrolArray = patrolDic[@"content"];
    ISSMessageModel *patrolModel;
    if (patrolArray.count != 0) {
        patrolModel = [[ISSMessageModel alloc] initWithDictionary:patrolArray[0]];
    }else{
        patrolModel = [[ISSMessageModel alloc] init];
    }
    patrolModel.unRead = ToString(data[@"unreadPatrol"]);
    [dataArray addObject:patrolModel];
    
    if (YES) {
        NSDictionary *dic = [[NSDictionary alloc]initWithDictionary:data[@"muckcar"]];
        NSArray *content = dic[@"content"];
        ISSMessageModel *model;
        if (content.count != 0) {
            model = [[ISSMessageModel alloc] initWithDictionary:content[0]];
        }else{
            model = [[ISSMessageModel alloc] init];
        }
        model.unRead = ToString(data[@"unreadMuckcar"]);
        [dataArray addObject:model];
    }
    
    if (YES) {
        NSDictionary *dic = [[NSDictionary alloc]initWithDictionary:data[@"task"]];
        NSArray *content = dic[@"content"];
        ISSMessageModel *model;
        if (content.count != 0) {
            model = [[ISSMessageModel alloc] initWithDictionary:content[0]];
        }else{
            model = [[ISSMessageModel alloc] init];
        }
        model.unRead = ToString(data[@"unreadTask"]);
        [dataArray addObject:model];
    }
    
    if (YES) {
        NSDictionary *dic = [[NSDictionary alloc]initWithDictionary:data[@"plan"]];
        NSArray *content = dic[@"content"];
        ISSMessageModel *model;
        if (content.count != 0) {
            model = [[ISSMessageModel alloc] initWithDictionary:content[0]];
        }else{
            model = [[ISSMessageModel alloc] init];
        }
        model.unRead = ToString(data[@"unreadPlan"]);
        [dataArray addObject:model];
    }
    
    return dataArray;
}
@end
