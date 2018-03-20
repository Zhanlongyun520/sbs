//
//  ISSunRecListModel.h
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/16.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"

@interface ISSunRecListModel : ISSBaseModel

@property (nonatomic, copy) NSString *licence;
@property (nonatomic, copy) NSString *dateTimeHour;
@property (nonatomic, copy) NSString *speed;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, copy) NSString *deviceCoding;
@property (nonatomic, copy) NSString *imgList;
@property (nonatomic, copy) NSString *dataTimeDay;
@property (nonatomic, copy) NSString *dateTime;
@property (nonatomic, copy) NSString *addr;

@end
