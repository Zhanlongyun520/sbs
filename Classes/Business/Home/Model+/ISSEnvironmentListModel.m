
//
//  ISSEnvironmentListModel.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSEnvironmentListModel.h"

@implementation ISSEnvironmentListModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.deviceId = ToString(dic[@"deviceId"]);
        self.deviceName = ToString(dic[@"deviceName"]);
        self.installTime = ToString(dic[@"installTime"]);
        self.deviceCoding = ToString(dic[@"deviceCoding"]);
        self.deviceStatus = ToString(dic[@"deviceStatus"]);
        self.latitude = ToString(dic[@"latitude"]);
        self.longitude = ToString(dic[@"longitude"]);
        self.pm10 = ToString(dic[@"pm10"]);
        self.pm25 = ToString(dic[@"pm2_5"]);
        self.pm1 = ToString(dic[@"pm1_0"]);
        self.co2 = ToString(dic[@"co2"]);
        self.pushTime = ToString(dic[@"pushTime"]);


        self.airHumidity = ToString(dic[@"airHumidity"]);
        self.airTemperature = ToString(dic[@"airTemperature"]);
        self.windDirection = ToString(dic[@"windDirection"]);
        self.windSpeed = ToString(dic[@"windSpeed"]);
        self.atmosphericPressure = ToString(dic[@"atmosphericPressure"]);
        self.rainfall = ToString(dic[@"rainfall"]);


    }
    return self;
}

@end
