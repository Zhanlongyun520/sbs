//
//  ISSTaskPositionModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/7.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"
#import "ISSTaskPeopleModel.h"

typedef NS_ENUM(NSInteger, ISSTaskPositionStatus) {
    ISSTaskPositionStatusNew = 0,
    ISSTaskPositionStatusFinished = 1
};
@protocol ISSTaskPositionModel

@end

@interface ISSTaskPositionModel : ISSBaseModel

@property(nonatomic, strong) NSString *id;
@property(nonatomic, strong) NSString *position;
@property(nonatomic, strong) NSString *executionTime;
@property(nonatomic, assign) double latitude;
@property(nonatomic, assign) double longitude;
@property(nonatomic, strong) ISSTaskPeopleModel *user;
@property(nonatomic, assign) ISSTaskPositionStatus status;

- (NSString *)getStatusName;
- (UIColor *)getStatusColor;

@end
