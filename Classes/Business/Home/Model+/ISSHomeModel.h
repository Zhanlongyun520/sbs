//
//  ISSHomeModel.h
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/10.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISSHomeModel : NSObject

@property(nonatomic, strong)NSString     * AQI;
@property(nonatomic, strong)NSString     * allEmes;
@property(nonatomic, strong)NSString     * openEmes;
@property(nonatomic, strong)NSString     * allVses;
@property(nonatomic, strong)NSString     * openVses;
@property(nonatomic, strong)NSString     * unreadMessages;
@property(nonatomic, strong)NSString     * untreatedPatrols;
@property(nonatomic, strong)NSString     * unHandleTask;

@property(nonatomic, strong)NSString     * airHumidity;
@property(nonatomic, strong)NSString     * airTemperature;
@property(nonatomic, strong)NSString     * windDirection;
@property(nonatomic, strong)NSString     * windSpeed;

@property(nonatomic, strong)NSArray      * messageArray;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
