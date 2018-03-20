//
//  ISSUserPositionModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"

@protocol ISSUserPositionModel

@end

@interface ISSUserPositionModel : ISSBaseModel

@property(nonatomic, strong) NSString *id;
@property(nonatomic, assign) double latitude;
@property(nonatomic, assign) double longitude;
@property(nonatomic, strong) NSString *taskId;
@property(nonatomic, strong) NSString *updateTime;
@property(nonatomic, strong) NSString *userId;

@end
