//
//  ISSHomeModel.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSHomeModel.h"
#import "ISSMessageModel.h"

@implementation ISSHomeModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.AQI = ToString(dic[@"AQI"]);
        self.allEmes = ToString(dic[@"allEmes"]);
        self.openEmes = ToString(dic[@"openEmes"]);
        self.allVses = ToString(dic[@"allVses"]);
        self.openVses = ToString(dic[@"openVses"]);
        self.openEmes = ToString(dic[@"openEmes"]);
        self.unreadMessages = ToString(dic[@"unreadMessages"]);
        self.untreatedPatrols = ToString(dic[@"untreatedPatrols"]);
        self.unHandleTask = ToString(dic[@"unHandleTask"]);

        NSDictionary * avgEqis = dic[@"avgEqis"];
        self.airHumidity = ToString(avgEqis[@"airHumidity"]);
        self.airTemperature = ToString(avgEqis[@"airTemperature"]);
        self.windDirection = ToString(avgEqis[@"windDirection"]);
        self.windSpeed = ToString(avgEqis[@"windSpeed"]);

//        NSDictionary * messages = dic[@"messages"];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *messageDic in dic[@"messages"]) {
            ISSMessageModel *messageModel = [[ISSMessageModel alloc] initWithDictionary:messageDic];
            [arr addObject:messageModel];
        }
        self.messageArray = [NSMutableArray arrayWithArray:arr];
        [arr removeAllObjects];
    }
    return self;
}
@end
