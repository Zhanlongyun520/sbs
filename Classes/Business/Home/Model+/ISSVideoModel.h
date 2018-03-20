//
//  ISSVideoModel.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/15.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISSMapEqiModel.h"

@interface ISSVideoModel : NSObject

@property(nonatomic, strong)NSString     * deviceId;
@property(nonatomic, strong)NSString     * deviceName;
@property(nonatomic, strong)NSString     * installTime;
@property(nonatomic, strong)NSString     * deviceCoding;
//    设备状态（0在线，1离线，2故障）
@property(nonatomic, strong)NSString     * deviceStatus;
@property(nonatomic, strong)NSString     * latitude;
@property(nonatomic, strong)NSString     * longitude;
//    0为PM10，1为监控
@property(nonatomic, strong)NSString     * deviceType;
//@property(nonatomic, strong)NSString     * pm10;

@property(nonatomic, strong) ISSMapEqiModel *eqiModel;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

- (NSString *)getStatusDes;
- (UIColor *)getStatusColor;

@end
