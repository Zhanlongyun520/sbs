//
//  ISSCarTrackModel.h
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/17.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"

@interface ISSCarTrackModel : ISSBaseModel

@property (nonatomic, strong) NSNumber *speed;
@property (nonatomic, assign) double longitude;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, assign) double latitude;
@property (nonatomic, copy) NSString *licence;
@property (nonatomic, copy) NSString *addr;
@property (nonatomic, copy) NSString *deviceName;
@property (nonatomic, copy) NSString *deviceCoding;
@property (nonatomic, copy) NSString *dateTime;
@property (nonatomic, copy) NSString *imgList;
@property (nonatomic, copy) NSString *deviceStatus;
@property (nonatomic, copy) NSString *installTime;

@end
