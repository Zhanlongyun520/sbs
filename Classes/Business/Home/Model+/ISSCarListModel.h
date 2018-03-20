//
//  ISSCarListModel.h
//  SmartBuildingSite
//
//  Created by love77 on 2017/12/9.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "ISSBaseModel.h"

@interface ISSCarListModel : ISSBaseModel

@property (nonatomic, copy) NSString *licence;
@property (nonatomic, copy) NSString *dateTime;
@property (nonatomic, copy) NSString *dataTimeDay;
@property (nonatomic, copy) NSString *addr;
@property (nonatomic, strong) NSNumber *speed;
@property (nonatomic, copy) NSString *deviceCoding;
@property (nonatomic, copy) NSString *imgList;



@end
