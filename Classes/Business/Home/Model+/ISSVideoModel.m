
//
//  ISSVideoModel.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/15.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSVideoModel.h"

@implementation ISSVideoModel

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
        self.deviceType = ToString(dic[@"deviceType"]);
//        self.pm10 = ToString(dic[@"pm10"]);

    }
    return self;
}

- (NSString *)getStatusDes {
    NSString *des;
    switch ([_deviceStatus integerValue]) {
        case 0:
            des = @"在线";
            break;
            
        case 1:
            des = @"离线";
            break;
            
        case 2:
            des = @"故障";
            break;
            
        default:
            break;
    }
    return des;
}

- (UIColor *)getStatusColor {
    UIColor *color;
    switch ([_deviceStatus integerValue]) {
        case 0:
            color = [UIColor colorWithRed:0.62 green:0.85 blue:0.79 alpha:1.00];
            break;
            
        case 1:
            color = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00];
            break;
            
        case 2:
            color = [UIColor colorWithRed:0.97 green:0.50 blue:0.53 alpha:1.00];
            break;
            
        default:
            break;
    }
    return color;
}

@end
