//
//  ISSMapEqiModel.h
//  SmartBuildingSite
//
//  Created by WuLeilei on 2017/12/28.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"

@interface ISSMapEqiModel : ISSBaseModel

@property(nonatomic, strong)NSString     * deviceId;
@property(nonatomic, strong)NSString     * deviceName;
@property(nonatomic, strong)NSString     * installTime;
@property(nonatomic, strong)NSString     * deviceCoding;
//    设备状态（0在线，1离线，2故障）
@property(nonatomic, strong)NSString     * deviceStatus;
@property(nonatomic, strong)NSString     * latitude;
@property(nonatomic, strong)NSString     * longitude;
@property(nonatomic, strong)NSString     * pm10;
@property(nonatomic, strong)NSString     * pm25;
@property(nonatomic, strong)NSString     * pm1;
@property(nonatomic, strong)NSString     * co2;
@property(nonatomic, strong)NSString     * pushTime;

@property(nonatomic, strong)NSString     * airHumidity; //湿度
@property(nonatomic, strong)NSString     * airTemperature; //温度
@property(nonatomic, strong)NSString     * windDirection; //风向
@property(nonatomic, strong)NSString     * windSpeed; //风速
@property(nonatomic, strong)NSString     * atmosphericPressure; //气压
@property(nonatomic, strong)NSString     * rainfall; //雨量

@end
